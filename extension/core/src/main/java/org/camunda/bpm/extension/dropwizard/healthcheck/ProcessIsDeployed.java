package org.camunda.bpm.extension.dropwizard.healthcheck;

import com.codahale.metrics.health.HealthCheck;
import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.repository.ProcessDefinition;

public class ProcessIsDeployed extends HealthCheck {

  private final String processDefinitionKey;

  public ProcessIsDeployed(final String processDefinitionKey) {
    this.processDefinitionKey = processDefinitionKey;
  }

  @Override
  protected Result check() throws Exception {
    final ProcessDefinition processDefinition = ProcessEngines.getDefaultProcessEngine().getRepositoryService().createProcessDefinitionQuery().processDefinitionKey(processDefinitionKey).latestVersion().singleResult();
    return processDefinition != null ? Result.healthy("process deployed: %s, rev; %d", processDefinitionKey, processDefinition.getVersion()) : Result.unhealthy("no process deployed with key: %s", processDefinitionKey);
  }

}
