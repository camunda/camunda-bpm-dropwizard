package org.camunda.bpm.extension.dropwizard.example;

import io.dropwizard.Application;
import io.dropwizard.Configuration;
import io.dropwizard.setup.Environment;

public class CamundaDropwizardExampleApplication extends Application<CamundaDropwizardExampleApplication.Config> {


    @Override
    public void run(Config configuration, Environment environment) throws Exception {
        // nothing so far
    }

    public static class Config extends Configuration {
        // empty
    }

    public static void main(String... args) throws Exception {
        new CamundaDropwizardExampleApplication().run(args);
    }
}
