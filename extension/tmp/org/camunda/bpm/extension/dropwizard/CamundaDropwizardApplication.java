package org.camunda.bpm.extension.dropwizard;

import io.dropwizard.Application;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.extension.dropwizard.health.ProcessEngineRunning;

public class CamundaDropwizardApplication extends Application<CamundaDropwizardApplicationConfiguration> {

    public static final String NAME = "camunda-bpm-dropwizard";

    @Override
    public void run(final CamundaDropwizardApplicationConfiguration configuration, final Environment environment) throws Exception {

        environment.lifecycle().manage(new ProcessEngineManager());


        environment.healthChecks().register("engine", new ProcessEngineRunning());
    }

    @Override
    public String getName() {
        return NAME;
    }

    @Override
    public void initialize(final Bootstrap<CamundaDropwizardApplicationConfiguration> bootstrap) {
        // empty
    }

    public static void main(final String... args) throws Exception {
        new CamundaDropwizardApplication().run(args);
    }
}
