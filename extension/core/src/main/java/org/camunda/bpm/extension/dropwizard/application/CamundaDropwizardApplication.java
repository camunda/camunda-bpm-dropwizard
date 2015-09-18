package org.camunda.bpm.extension.dropwizard.application;

/**
 * Created by Andrew Shapton on 05/05/2015.
 */

import io.dropwizard.Application;
import io.dropwizard.lifecycle.ServerLifecycleListener;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;

import java.util.ArrayList;
import java.util.List;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RepositoryService;
import org.camunda.bpm.engine.repository.Deployment;
import org.camunda.bpm.engine.rest.impl.CamundaRestResources;
import org.eclipse.jetty.server.Server;

import org.camunda.bpm.extension.dropwizard.CamundaBundle;
import org.camunda.bpm.extension.dropwizard.CamundaConfiguration;
import org.camunda.bpm.extension.dropwizard.healthcheck.CamundaHealthChecks;
import org.camunda.bpm.extension.dropwizard.task.StartProcessTask;

public class CamundaDropwizardApplication extends Application<CamundaConfiguration> {

    private List<StartProcessTask> startProcessTasks = new ArrayList<>();

    public static void main(String[] args) throws Exception {
        new CamundaDropwizardApplication().run(args);
    }

    @Override
    public String getName() {
        return "camunda";
    }

    @Override
    public void initialize(Bootstrap<CamundaConfiguration> bootstrap) {
        super.initialize(bootstrap);
        bootstrap.addBundle(new CamundaBundle());
    }

    @Override
    public void run(CamundaConfiguration configuration, Environment environment) throws ClassNotFoundException {

        for (Class<?> nextResourceClass : CamundaRestResources.getResourceClasses()) {
            environment.jersey().register(nextResourceClass);
        }
        for (Class<?> nextConfigurationClass : CamundaRestResources.getConfigurationClasses()) {
            environment.jersey().register(nextConfigurationClass);
        }

        CamundaHealthChecks.processEngineIsRunning(environment);
        for (String processKey : configuration.getCamunda().getDeployProcessKeys()) {
            CamundaHealthChecks.processIsDeployed(environment, processKey);
        }

        for (String processKey : configuration.getCamunda().getStartProcessKeys()) {
            final StartProcessTask startProcessTask = new StartProcessTask(processKey);
            environment.admin().addTask(startProcessTask);
            startProcessTasks.add(startProcessTask);
        }

        environment.lifecycle().addServerLifecycleListener(new ServerLifecycleListener() {
            @Override
            public void serverStarted(final Server server) {

                for (StartProcessTask startProcessTask : startProcessTasks) {
                    startProcessTask.startProcess();
                }
            }
        });
    }
}
