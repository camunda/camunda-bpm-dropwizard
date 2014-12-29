package org.camunda.bpm.extension.dropwizard.example;

import io.dropwizard.Application;
import io.dropwizard.Configuration;
import io.dropwizard.lifecycle.ServerLifecycleListener;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.extension.dropwizard.CamundaBundle;
import org.camunda.bpm.extension.dropwizard.healthcheck.CamundaHealthChecks;
import org.eclipse.jetty.server.Server;
import org.slf4j.Logger;

import static org.slf4j.LoggerFactory.getLogger;

public class CamundaDropwizardExampleApplication extends Application<CamundaDropwizardExampleApplication.Config> {

  public static final String PROCESS_DEFINITION_KEY = "process_dw_example";
  private final Logger logger = getLogger(this.getClass());

  @Override
  public void run(Config configuration, Environment environment) throws Exception {
    CamundaHealthChecks.processIsDeployed(environment, PROCESS_DEFINITION_KEY);

    environment.lifecycle().addServerLifecycleListener(new ServerLifecycleListener() {
      @Override
      public void serverStarted(final Server server) {

        ProcessEngines.getDefaultProcessEngine().getRuntimeService().startProcessInstanceByKey(PROCESS_DEFINITION_KEY);
      }
    });

  }

  @Override
  public void initialize(final Bootstrap<Config> bootstrap) {
    bootstrap.addBundle(new CamundaBundle(ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration()
      .setJobExecutorActivate(true)
      .setJdbcUrl("jdbc:mysql://janhoo.net/janhoone_camunda")
      .setJdbcUsername("janhoone_camunda")
      .setJdbcPassword("Fa+7cAu*4kaU;5a")
      .setJdbcDriver("com.mysql.jdbc.Driver")
      .setHistory(ProcessEngineConfiguration.HISTORY_FULL)));
  }

  public static class Config extends Configuration {
    // empty
  }

  public static void main(String... args) throws Exception {
    new CamundaDropwizardExampleApplication().run(args);
  }
}
