package org.camunda.bpm.extension.dropwizard;


import com.google.common.io.Resources;

import java.io.File;
import java.net.URISyntaxException;

/**
 * This is not a test, just another main() class to start a configured application without messing with the main/java code.
 */
public class CamundaApplicationStarter {

    public static void main(String... args) throws Exception {
        final File configFile = new File(Resources.getResource("camunda-bpm-dropwizard.yaml").toURI());

        CamundaApplication.main("server", configFile.getAbsolutePath());
    }

}