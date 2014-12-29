package org.camunda.bpm.extension.dropwizard;

import org.camunda.bpm.application.ProcessApplication;
import org.camunda.bpm.application.impl.ServletProcessApplication;

/**
 * The ProcessApplication makes the resulting jar file a valid camunda process application.
 * It is added as a servlet listener inside the CamundaBundle.
 */
@ProcessApplication
public class DropwizardProcessApplication extends ServletProcessApplication {
  // empty
}
