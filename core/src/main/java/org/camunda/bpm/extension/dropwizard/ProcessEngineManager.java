package org.camunda.bpm.extension.dropwizard;

import org.camunda.bpm.container.RuntimeContainerDelegate;
import org.camunda.bpm.engine.ProcessEngine;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.dropwizard.lifecycle.Managed;

public class ProcessEngineManager implements Managed {

    private static final String JDBC_URL = String.format("jdbc:h2:mem:%s;DB_CLOSE_DELAY=1000", "camunda-dropwizard");
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private ProcessEngine processEngine;

    @Override
    public void start() {
        // FIXME make configurable via yaml
        processEngine = ProcessEngineConfiguration.createStandaloneInMemProcessEngineConfiguration().setJobExecutorActivate(true)
                .setHistory(ProcessEngineConfiguration.HISTORY_FULL).buildProcessEngine();

        RuntimeContainerDelegate.INSTANCE.get().registerProcessEngine(processEngine);
    }

    @Override
    public void stop() {
        processEngine.close();
    }

}
