package org.camunda.bpm.extension.dropwizard.healthcheck;


import io.dropwizard.setup.Environment;

public final class CamundaHealthChecks {
    private CamundaHealthChecks() {
        // do not instantiate
    }

    public static ProcessEngineIsRunning processEngineIsRunning(final Environment environment) {
        final ProcessEngineIsRunning processEngineIsRunning = new ProcessEngineIsRunning();
        environment.healthChecks().register("processEngineIsRunning", processEngineIsRunning);
        return processEngineIsRunning;
    }

    public static ProcessIsDeployed processIsDeployed(Environment environment, String processDefinitionKey) {
        final ProcessIsDeployed processIsDeployed = new ProcessIsDeployed(processDefinitionKey);
        environment.healthChecks().register(processDefinitionKey, processIsDeployed);
        return processIsDeployed;
    }
}
