package org.camunda.bpm.extension.dropwizard.healthcheck;


import io.dropwizard.setup.Environment;

/**
 * Helper class to register camunda specific healthChecks to the dropwizard engine.
 */
public final class CamundaHealthChecks {
  private CamundaHealthChecks() {
    // do not instantiate
  }

  /**
   * @param environment the dropwizard environment
   * @return the registered healthcheck
   */
  public static ProcessEngineIsRunning processEngineIsRunning(final Environment environment) {
    final ProcessEngineIsRunning processEngineIsRunning = new ProcessEngineIsRunning();
    environment.healthChecks().register("processEngineIsRunning", processEngineIsRunning);
    return processEngineIsRunning;
  }

  /**
   *
   * @param environment the dropwizard environment
   * @param processDefinitionKey the process to monitor
   * @return the registered healthCheck
   */
  public static ProcessIsDeployed processIsDeployed(final Environment environment, final String processDefinitionKey) {
    final ProcessIsDeployed processIsDeployed = new ProcessIsDeployed(processDefinitionKey);
    environment.healthChecks().register(processDefinitionKey, processIsDeployed);
    return processIsDeployed;
  }
}
