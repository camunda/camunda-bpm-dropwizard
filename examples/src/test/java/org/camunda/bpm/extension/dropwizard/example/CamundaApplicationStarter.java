package org.camunda.bpm.extension.dropwizard.example;


import com.google.common.io.Resources;
import org.camunda.bpm.extension.dropwizard.example.CamundaDropwizardExampleApplication;

import java.io.File;

/**
 * This is not a test, just another main() class to start a configured application without messing with the main/java code.
 */
public class CamundaApplicationStarter {

    public static void main(String... unused) throws Exception {
        final File configFile = new File(Resources.getResource("camunda-bpm-dropwizard.yaml").toURI());

        CamundaDropwizardExampleApplication.main("server", configFile.getAbsolutePath());
    }

}