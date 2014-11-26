package org.camunda.bpm.extension.dropwizard.health;


import com.codahale.metrics.health.HealthCheck;
import org.camunda.bpm.engine.ProcessEngines;

public class ProcessEngineRunning extends HealthCheck {

    @Override
    protected Result check() throws Exception {
        try {
            ProcessEngines.getDefaultProcessEngine().getIdentityService().createGroupQuery().list();
            return Result.healthy();
        } catch (final Exception e) {
            return Result.unhealthy(e);
        }
    }
}
