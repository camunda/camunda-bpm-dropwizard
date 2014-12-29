package org.camunda.bpm.extension.dropwizard;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.dropwizard.Configuration;
import io.dropwizard.db.DataSourceFactory;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import sun.security.provider.DSAKeyFactory;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;


public class CamundaConfiguration extends Configuration {

  /**
   * Init with a default configuration. All values set on camundaConfiguration are propagated to this config.
   * TODO: jobexecutor and history must be configurable
   */
  // @formatter:off
  private final ProcessEngineConfiguration processEngineConfiguration = ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration()
    .setJobExecutorActivate(true)
    .setHistory(ProcessEngineConfiguration.HISTORY_FULL);
  // @formatter:on


  /**
   * Every camunda engine define a dataSource, so setting a camundaDatabase DataSourceFactory is required.
   * To simplify standalone operations, the camunda default (h2) is applied to the dropwizard datasourceFactory on
   * initialization.
   */
  @Valid
  @NotNull
  @JsonProperty
  private DataSourceFactory camundaDatabase = new DataSourceFactory() {{

    setUrl(processEngineConfiguration.getJdbcUrl());
    setUser(processEngineConfiguration.getJdbcUsername());
    setPassword(processEngineConfiguration.getJdbcPassword());
    setDriverClass(processEngineConfiguration.getJdbcDriver());

  }};

  /**
   * @return the database configuration
   */
  public DataSourceFactory getCamundaDataSourceFactory() {
    return camundaDatabase;
  }

  /**
   * @return the processEngineConfiguration based on standaloneDefaults and camundaDatabase configuration.
   */
  public ProcessEngineConfiguration getProcessEngineConfiguration() {
    processEngineConfiguration.setJdbcDriver(camundaDatabase.getDriverClass());
    processEngineConfiguration.setJdbcUrl(camundaDatabase.getUrl());
    processEngineConfiguration.setJdbcUsername(camundaDatabase.getUser());
    processEngineConfiguration.setJdbcPassword(camundaDatabase.getPassword());

    return processEngineConfiguration;
  }
}
