package org.camunda.bpm.extension.dropwizard;

import com.codahale.metrics.health.HealthCheck;
import io.dropwizard.Bundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;

public class CamundaBundle implements Bundle {

    private ProcessEngineManager processEngineManager;

    @Override
    public void initialize(Bootstrap<?> bootstrap) {
        processEngineManager = new ProcessEngineManager();

        
    }

    @Override
    public void run(Environment environment) {
        environment.lifecycle().manage(processEngineManager);
        environment.healthChecks().register("dummy", new HealthCheck() {
            @Override
            protected Result check() throws Exception {
                return Result.healthy();
            }
        });
    }
}
