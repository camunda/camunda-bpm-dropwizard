package org.camunda.bpm.extension.dropwizard.example;

import org.camunda.bpm.application.ProcessApplication;
import org.camunda.bpm.application.impl.ServletProcessApplication;

@ProcessApplication("Example Application")
public class LoanApprovalApplication extends ServletProcessApplication {
    // empty implementation
}
