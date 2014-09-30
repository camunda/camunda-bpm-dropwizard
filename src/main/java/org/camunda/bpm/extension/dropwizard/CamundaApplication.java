package org.camunda.bpm.extension.dropwizard;

import io.dropwizard.Application;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.engine.rest.impl.CamundaRestResources;
import org.camunda.bpm.extension.dropwizard.health.ProcessEngineRunning;
import org.camunda.bpm.extension.dropwizard.resource.HelloWorldResource;

public class CamundaApplication extends Application<CamundaApplicationConfiguration> {

    public static final String NAME = "camunda-bpm-dropwizard";

    @Override
    public void run(final CamundaApplicationConfiguration configuration, final Environment environment) throws Exception {
        environment.jersey().register(new HelloWorldResource(configuration.getTemplate(), configuration.getDefaultName()));

        for (final Class<?> componentClass : CamundaRestResources.getResourceClasses()) {
            environment.jersey().register(componentClass);
        }

        environment.lifecycle().manage(new ProcessEngineManager());


        environment.healthChecks().register("engine", new ProcessEngineRunning());
    }

    @Override
    public String getName() {
        return NAME;
    }

    @Override
    public void initialize(final Bootstrap<CamundaApplicationConfiguration> bootstrap) {
        // empty
    }

    public static void main(final String... args) throws Exception {
        new CamundaApplication().run(args);
    }
}
