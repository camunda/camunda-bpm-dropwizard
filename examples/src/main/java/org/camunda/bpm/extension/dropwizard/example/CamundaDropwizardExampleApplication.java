package org.camunda.bpm.extension.dropwizard.example;

import io.dropwizard.Application;
import io.dropwizard.Configuration;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.extension.dropwizard.CamundaBundle;
import org.camunda.bpm.extension.dropwizard.healthcheck.CamundaHealthChecks;
import org.slf4j.Logger;

import static org.slf4j.LoggerFactory.getLogger;

public class CamundaDropwizardExampleApplication extends Application<CamundaDropwizardExampleApplication.Config> {

    private final Logger logger = getLogger(this.getClass());

    @Override
    public void run(Config configuration, Environment environment) throws Exception {
        CamundaHealthChecks.processIsDeployed(environment, "process_dw_example");

       // ProcessEngines.getDefaultProcessEngine().getRuntimeService().startProcessInstanceByKey("process_dw_example");
    }

    @Override
    public void initialize(final Bootstrap<Config> bootstrap) {
        bootstrap.addBundle(new CamundaBundle());
    }

    public static class Config extends Configuration {
        // empty
    }

    public static void main(String... args) throws Exception {
        new CamundaDropwizardExampleApplication().run(args);
    }
}
