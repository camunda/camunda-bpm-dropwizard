package org.camunda.bpm.extension.dropwizard;

import org.camunda.bpm.engine.ProcessEngine;
import org.camunda.bpm.engine.ProcessEngines;

import java.util.Set;

public class ProcessEngineProvider implements org.camunda.bpm.engine.rest.spi.ProcessEngineProvider {

    @Override
    public ProcessEngine getDefaultProcessEngine() {
        return ProcessEngines.getDefaultProcessEngine();
    }

    @Override
    public ProcessEngine getProcessEngine(final String name) {
        return ProcessEngines.getProcessEngine(name);
    }

    @Override
    public Set<String> getProcessEngineNames() {
        return ProcessEngines.getProcessEngines().keySet();
    }

}
