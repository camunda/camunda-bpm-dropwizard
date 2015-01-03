package org.camunda.bpm.extension.dropwizard.example.delegate;

import static org.slf4j.LoggerFactory.getLogger;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.camunda.bpm.extension.dropwizard.example.CamundaDropwizardExampleApplication;
import org.slf4j.Logger;

public class DoSomethingDelegate implements JavaDelegate {

    private final Logger logger = getLogger(this.getClass());

    @Override
    public void execute(DelegateExecution execution) throws Exception {
      logger.info("executed delegate: {} {}", execution, CamundaDropwizardExampleApplication.PROCESS_DEFINITION_KEY);
    }
}
