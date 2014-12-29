package org.camunda.bpm.extension.dropwizard.example;


import com.google.common.io.Resources;

import java.io.File;

/**
 * This is not a test, just another main() class to start a configured application without messing with the main/java code.
 */
public class CamundaApplicationStarter2 {

    public static void main(String... unused) throws Exception {
        final File configFile = new File(Resources.getResource("camunda-bpm-dropwizard-2.yaml").toURI());

        CamundaDropwizardExampleApplication.main("server", configFile.getAbsolutePath());
    }

}
