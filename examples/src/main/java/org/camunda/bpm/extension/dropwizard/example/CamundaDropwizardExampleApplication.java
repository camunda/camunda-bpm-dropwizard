package org.camunda.bpm.extension.dropwizard.example;

import io.dropwizard.Application;
import io.dropwizard.lifecycle.ServerLifecycleListener;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.extension.dropwizard.CamundaBundle;
import org.camunda.bpm.extension.dropwizard.CamundaConfiguration;
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
    // This is basically all you have to do (as long as you provide the necessary configuration yaml).
    bootstrap.addBundle(new CamundaBundle());
  }

  /**
   * Just a dummy to ensure customization is still possible. Uses only super()-features.
   */
  public static class Config extends CamundaConfiguration {
    // empty on purpose
  }

  public static void main(String... args) throws Exception {
    new CamundaDropwizardExampleApplication().run(args);
  }
}
