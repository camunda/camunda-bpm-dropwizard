package org.camunda.bpm.extension.dropwizard;


import com.google.common.io.Resources;

import java.io.File;
import java.net.URISyntaxException;

public class CamundaApplicationRunner {

    public static void main(String... args) throws Exception {
        final File configFile = new File(Resources.getResource("camunda-bpm-dropwizard.yaml").toURI());

        CamundaApplication.main("server", configFile.getAbsolutePath());
    }

}