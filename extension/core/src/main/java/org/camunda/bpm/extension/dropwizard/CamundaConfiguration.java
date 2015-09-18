package org.camunda.bpm.extension.dropwizard;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.common.annotations.VisibleForTesting;
import com.google.common.base.Optional;
import com.google.common.base.Throwables;
import io.dropwizard.Configuration;
import io.dropwizard.db.DataSourceFactory;
import io.dropwizard.jackson.Jackson;
import io.dropwizard.jdbi.DBIFactory;
import io.dropwizard.setup.Environment;
import io.dropwizard.validation.OneOf;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.camunda.bpm.extension.dropwizard.db.GetHistoryLevelDao;
import org.hibernate.validator.constraints.NotEmpty;
import org.skife.jdbi.v2.DBI;
import org.slf4j.Logger;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

import static com.google.common.base.Throwables.propagate;
import static org.camunda.bpm.engine.ProcessEngineConfiguration.HISTORY_ACTIVITY;
import static org.camunda.bpm.engine.ProcessEngineConfiguration.HISTORY_AUDIT;
import static org.camunda.bpm.engine.ProcessEngineConfiguration.HISTORY_FULL;
import static org.camunda.bpm.engine.ProcessEngineConfiguration.HISTORY_NONE;
import static org.slf4j.LoggerFactory.getLogger;


public class CamundaConfiguration extends Configuration implements Serializable {

  public static final String HISTORY_AUTO = "auto";
  private static final long serialVersionUID = 1L;

  private final Logger logger = getLogger(this.getClass());

  @NotNull
  @Valid
  @JsonProperty
  private final ProcessEngineConfigurationFactory camunda = new ProcessEngineConfigurationFactory();

  public ProcessEngineConfigurationFactory getCamunda() {
    return camunda;
  }

  public ProcessEngineConfiguration buildProcessEngineConfiguration() {
    return ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration()
      .setJdbcDriver(camunda.database.getDriverClass())
      .setJdbcUrl(camunda.database.getUrl())
      .setJdbcUsername(camunda.database.getUser())
      .setJdbcPassword(camunda.database.getPassword())
      .setJobExecutorActivate(false) // we activate the executor via LifecycleListener (see CamundaBundle)
      .setJdbcMaxActiveConnections(camunda.database.getMaxSize())
      .setHistory(camunda.historyLevel)
      .setDatabaseSchemaUpdate(camunda.databaseSchemaUpdate)
      .setJobExecutorDeploymentAware(camunda.jobExecutorDeploymentAware);
  }

  public CamundaConfiguration overwriteHistoryLevel(final Environment environment) {
    if (HISTORY_AUTO.equalsIgnoreCase(camunda.historyLevel)) {
      final Optional<String> historyLevel = selectHistoryLevel(environment);

      if (historyLevel.isPresent()) {
        camunda.historyLevel = historyLevel.get();
        logger.info("historyLevel detected automatically: {}", camunda.historyLevel);
      } else {
        camunda.historyLevel = HISTORY_AUDIT;
        logger.info("historyLevel not set on db, using default: {}", camunda.historyLevel);
      }
    }
    return this;
  }

  @VisibleForTesting
  Optional<String> selectHistoryLevel(final Environment environment) {
      final DBI dbi = new DBIFactory().build(environment, camunda.database, "camundaDataSource");
      return dbi.onDemand(GetHistoryLevelDao.class).getFailsafe();
  }

  @Override
  public String toString() {
    try {
      return Jackson.newObjectMapper().writeValueAsString(this);
    } catch (JsonProcessingException e) {
      throw Throwables.propagate(e);
    }
  }

  public static class ProcessEngineConfigurationFactory implements Serializable {
    private static final long serialVersionUID = 1L;

    @Valid
    @NotNull
    @JsonProperty
    private final DataSourceFactory database = new DataSourceFactory();

    @NotNull
    @JsonProperty
    private boolean jobExecutorActivate;

    @NotNull
    @JsonProperty
    private String[] deployProcessKeys = new String[] {};

    @JsonProperty
    private String[] startProcessKeys = new String[] {};

    /**
     * Since it is most likely that dropwizard-camunda-processes will run as a heterogeneous cluster,
     * the default value is changed to <code>true</code>.
     */
    @NotNull
    @JsonProperty
    private boolean jobExecutorDeploymentAware = true;

    @JsonProperty
    private String databaseSchemaUpdate = "false";

    @NotEmpty
    @JsonProperty
    @OneOf({HISTORY_NONE, HISTORY_ACTIVITY, HISTORY_AUDIT, HISTORY_FULL, HISTORY_AUTO})
    private String historyLevel;

    public ProcessEngineConfigurationFactory() {
      // init with standalone defaults
      final ProcessEngineConfiguration p = ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration();

      this.jobExecutorActivate = p.isJobExecutorActivate();
      this.historyLevel = p.getHistory();

      this.database.setUrl(p.getJdbcUrl());
      this.database.setUser(p.getJdbcUsername());
      this.database.setPassword(p.getJdbcPassword());
      this.database.setDriverClass(p.getJdbcDriver());
    }

    public DataSourceFactory getDatabase() {
      return database;
    }

    public boolean isJobExecutorActivate() {
      return jobExecutorActivate;
    }

    public String[] getDeployProcessKeys() {
      return deployProcessKeys;
    }

    public String[] getStartProcessKeys() {
      return startProcessKeys;
    }
  }
}

