package org.camunda.bpm.extension.dropwizard.example.delegate;

import org.camunda.bpm.engine.delegate.DelegateTask;
import org.camunda.bpm.engine.delegate.TaskListener;
import org.slf4j.Logger;

import static org.slf4j.LoggerFactory.getLogger;

public class TaskCreated implements TaskListener {

  private final Logger logger = getLogger(this.getClass());

  @Override
  public void notify(DelegateTask delegateTask) {
    logger.info("task created: {}", delegateTask.getName());
  }
}
