package org.camunda.bpm.extension.dropwizard;

import io.dropwizard.lifecycle.Managed;
import org.camunda.bpm.container.RuntimeContainerDelegate;
import org.camunda.bpm.engine.ProcessEngine;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProcessEngineManager implements Managed {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());
  private ProcessEngine processEngine;

  private final ProcessEngineConfiguration processEngineConfiguration;

  public ProcessEngineManager(final ProcessEngineConfiguration processEngineConfiguration) {
    this.processEngineConfiguration = processEngineConfiguration;
  }

  @Override
  public void start() {
    processEngine = processEngineConfiguration.buildProcessEngine();
    RuntimeContainerDelegate.INSTANCE.get().registerProcessEngine(processEngine);
  }

  @Override
  public void stop() {
    processEngine.close();
  }

}
