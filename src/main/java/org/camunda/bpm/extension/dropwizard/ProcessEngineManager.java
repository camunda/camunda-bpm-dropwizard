package org.camunda.bpm.extension.dropwizard;


import com.google.common.collect.Sets;
import io.dropwizard.lifecycle.Managed;
import org.camunda.bpm.engine.ProcessEngine;
import org.camunda.bpm.engine.impl.bpmn.parser.BpmnParseListener;
import org.camunda.bpm.engine.impl.cfg.StandaloneInMemProcessEngineConfiguration;
import org.camunda.bpm.engine.impl.jobexecutor.JobHandler;
import org.camunda.bpm.engine.rest.spi.ProcessEngineProvider;
import org.camunda.bpm.engine.test.mock.MockExpressionManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Set;

import static com.google.common.base.Preconditions.checkState;

public class ProcessEngineManager implements Managed, ProcessEngineProvider {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private ProcessEngine processEngine;

    @Override
    public void start() throws Exception {
        // TODO make configurable
        processEngine = new StandaloneInMemProcessEngineConfiguration(){
            @Override
            public ProcessEngine buildProcessEngine() {

                this.history = HISTORY_FULL;
                this.databaseSchemaUpdate = DB_SCHEMA_UPDATE_TRUE;
                this.jobExecutorActivate = false;
                this.expressionManager = new MockExpressionManager();
                this.setCustomPostBPMNParseListeners(new ArrayList<BpmnParseListener>());
                this.setCustomJobHandlers(new ArrayList<JobHandler>());

                return super.buildProcessEngine();
            }
        }.buildProcessEngine();


    }

    @Override
    public void stop() throws Exception {
        processEngine.close();
    }

    @Override
    public ProcessEngine getDefaultProcessEngine() {
        checkState(processEngine != null);
        return processEngine;
    }

    @Override
    public ProcessEngine getProcessEngine(final String _) {
        return getDefaultProcessEngine();
    }

    @Override
    public Set<String> getProcessEngineNames() {
        return Sets.newHashSet(getDefaultProcessEngine().getName());
    }
}
