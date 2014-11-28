package org.camunda.bpm.extension.dropwizard.example;

import org.camunda.bpm.application.ProcessApplication;
import org.camunda.bpm.application.impl.EmbeddedProcessApplication;
import org.camunda.bpm.application.impl.ServletProcessApplication;

@ProcessApplication("camunda-dropwizard-example")
public class ExampleProcessApplication extends EmbeddedProcessApplication {
    // empty implementation
}
