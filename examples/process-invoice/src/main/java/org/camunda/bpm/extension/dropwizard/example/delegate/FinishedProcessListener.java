package org.camunda.bpm.extension.dropwizard.example.delegate;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.ExecutionListener;
import org.slf4j.Logger;

import static org.slf4j.LoggerFactory.getLogger;

public class FinishedProcessListener implements ExecutionListener {

  private final Logger logger = getLogger(this.getClass());

  @Override
  public void notify(DelegateExecution execution) throws Exception {
    logger.info("process finished {}", execution);
  }
}
