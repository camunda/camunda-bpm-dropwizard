package org.camunda.bpm.extension.dropwizard;


import io.dropwizard.lifecycle.Managed;
import org.camunda.bpm.engine.ProcessEngine;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProcessEngineManager implements Managed {

    private static final String JDBC_URL = String.format("jdbc:h2:mem:%s;DB_CLOSE_DELAY=1000", "camunda-dropwizard");
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private ProcessEngine processEngine;

    @Override
    public void start() throws Exception {
        // TODO make configurable via yaml
        processEngine = ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration()
                .setDatabaseSchemaUpdate(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_FALSE)
                .setJdbcUrl(JDBC_URL)
                .setJobExecutorActivate(true)
                .setHistory(ProcessEngineConfiguration.HISTORY_FULL)
                .setDatabaseSchemaUpdate(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_TRUE)
                .buildProcessEngine();
    }

    @Override
    public void stop() throws Exception {
        processEngine.close();
    }

}
