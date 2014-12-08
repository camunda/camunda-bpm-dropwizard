package org.camunda.bpm.extension.dropwizard;

import com.codahale.metrics.health.HealthCheck;
import io.dropwizard.Bundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.application.impl.EmbeddedProcessApplication;
import org.camunda.bpm.extension.dropwizard.healthcheck.CamundaHealthChecks;
import org.camunda.bpm.extension.dropwizard.task.StartProcessTask;
import org.slf4j.Logger;

import static org.slf4j.LoggerFactory.getLogger;

public class CamundaBundle implements Bundle {

    private ProcessEngineManager processEngineManager;

    private final Logger logger = getLogger(this.getClass());

    @Override
    public void initialize(final Bootstrap<?> bootstrap) {
        processEngineManager = new ProcessEngineManager();
    }

    @Override
    public void run(final Environment environment) {
        environment.lifecycle().manage(processEngineManager);

        environment.servlets().addServletListeners(new DropwizardProcessApplication());

        CamundaHealthChecks.processEngineIsRunning(environment);

        environment.admin().addTask(new StartProcessTask());
    }
}
