package org.camunda.bpm.extension.dropwizard;


import io.dropwizard.lifecycle.Managed;
import org.camunda.bpm.application.impl.EmbeddedProcessApplication;
import org.camunda.bpm.engine.ProcessEngine;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.camunda.bpm.engine.ProcessEngines;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProcessEngineManager implements Managed {

    private static final String JDBC_URL = String.format("jdbc:h2:mem:%s;DB_CLOSE_DELAY=1000", "camunda-dropwizard");
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final EmbeddedProcessApplication processApplication;
    private ProcessEngine processEngine;

    public ProcessEngineManager() {
        this(null);
    }

    public ProcessEngineManager(EmbeddedProcessApplication processApplication) {
        this.processApplication = processApplication;
    }

    @Override
    public void start() {
        // TODO make configurable via yaml
        processEngine = ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration()
                .setDatabaseSchemaUpdate(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_FALSE)
                .setJdbcUrl(JDBC_URL)
                .setJobExecutorActivate(true)
                .setHistory(ProcessEngineConfiguration.HISTORY_FULL)
                .setDatabaseSchemaUpdate(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_TRUE)
                .buildProcessEngine();

        logger.info("registered default engine: {}", ProcessEngines.getDefaultProcessEngine());

        //processApplication.deploy();
    }

    @Override
    public void stop() {
        //processApplication.undeploy();
        processEngine.close();
    }

}
