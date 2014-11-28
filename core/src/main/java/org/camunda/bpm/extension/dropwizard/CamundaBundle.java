package org.camunda.bpm.extension.dropwizard;

import com.codahale.metrics.health.HealthCheck;
import io.dropwizard.Bundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.application.impl.EmbeddedProcessApplication;

public class CamundaBundle implements Bundle {

    private final EmbeddedProcessApplication processApplication;
    private ProcessEngineManager processEngineManager;

    public CamundaBundle(EmbeddedProcessApplication processApplication) {
        this.processApplication = processApplication;
    }

    @Override
    public void initialize(final Bootstrap<?> bootstrap) {
        processEngineManager = new ProcessEngineManager(processApplication);
    }

    @Override
    public void run(final Environment environment) {
        environment.lifecycle().manage(processEngineManager);

        //environment.servlets().addServletListeners(new DropwizardProcessApplication());

        environment.healthChecks().register("dummy-camunda", new HealthCheck() {
            @Override
            protected Result check() throws Exception {
                return Result.healthy();
            }
        });
    }
}
