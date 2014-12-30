package org.camunda.bpm.extension.dropwizard;

import com.google.common.base.Optional;
import com.google.common.base.Throwables;
import io.dropwizard.ConfiguredBundle;
import io.dropwizard.jdbi.DBIFactory;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.camunda.bpm.extension.dropwizard.db.GetHistoryLevelDao;
import org.camunda.bpm.extension.dropwizard.healthcheck.CamundaHealthChecks;
import org.camunda.bpm.extension.dropwizard.task.StartProcessTask;
import org.skife.jdbi.v2.DBI;
import org.slf4j.Logger;

import static com.google.common.base.Throwables.propagate;
import static org.slf4j.LoggerFactory.getLogger;

/**
 * The bundle is the hook that a developer of a camunda dropwizard application has to add so the engine
 * and process application are configured correctly.
 */
public class CamundaBundle implements ConfiguredBundle<CamundaConfiguration> {

  private final Logger logger = getLogger(this.getClass());

  @Override
  public void run(final CamundaConfiguration configuration, final Environment environment) throws Exception {
    // @formatter:off
    final ProcessEngineConfiguration processEngineConfiguration = configuration
      .overwriteHistoryLevel(environment)
      .buildProcessEngineConfiguration();
    // @formatter:on

    environment.lifecycle().manage(new ProcessEngineManager(processEngineConfiguration));

    environment.servlets().addServletListeners(new DropwizardProcessApplication());

    CamundaHealthChecks.processEngineIsRunning(environment);

    environment.admin().addTask(new StartProcessTask());
  }



  @Override
  public void initialize(final Bootstrap<?> bootstrap) {
    // nothing to do here, we need access to configuration and we won't have that until run() is executed.
  }

}
