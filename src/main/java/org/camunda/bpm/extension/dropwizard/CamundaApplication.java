package org.camunda.bpm.extension.dropwizard;

import io.dropwizard.Application;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;

public class CamundaApplication extends Application<CamundaConfiguration> {

    public static final String NAME = "camunda-bpm-dropwizard";

    @Override
    public void initialize(Bootstrap<CamundaConfiguration> camundaConfigurationBootstrap) {
        // nothing here
    }

    @Override
    public void run(CamundaConfiguration camundaConfiguration, Environment environment) throws Exception {
        environment.jersey().register(new HelloWorldResource(camundaConfiguration.getTemplate(), camundaConfiguration.getDefaultName()));
    }

    @Override
    public String getName() {
        return NAME;
    }

    public static void main(final String... args) throws Exception {
        new CamundaApplication().run(args);
    }
}
