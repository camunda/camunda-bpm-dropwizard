package org.camunda.bpm.extension.dropwizard;

import io.dropwizard.Bundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.camunda.bpm.extension.dropwizard.healthcheck.CamundaHealthChecks;
import org.camunda.bpm.extension.dropwizard.task.StartProcessTask;
import org.slf4j.Logger;

import static org.slf4j.LoggerFactory.getLogger;

public class CamundaBundle implements Bundle {

  private ProcessEngineManager processEngineManager;

  private final Logger logger = getLogger(this.getClass());

  private final ProcessEngineConfiguration processEngineConfiguration;

  public CamundaBundle(final ProcessEngineConfiguration processEngineConfiguration) {
    this.processEngineConfiguration = processEngineConfiguration;
  }


  @Override
  public void initialize(final Bootstrap<?> bootstrap) {
    processEngineManager = new ProcessEngineManager(processEngineConfiguration);
  }

  @Override
  public void run(final Environment environment) {
    environment.lifecycle().manage(processEngineManager);

    environment.servlets().addServletListeners(new DropwizardProcessApplication());

    CamundaHealthChecks.processEngineIsRunning(environment);

    environment.admin().addTask(new StartProcessTask());
  }
}
