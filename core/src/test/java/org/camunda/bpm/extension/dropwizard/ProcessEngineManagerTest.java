package org.camunda.bpm.extension.dropwizard;

import org.junit.Test;

public class ProcessEngineManagerTest {

    private final ProcessEngineManager manager = new ProcessEngineManager();

    @Test
    public void starts_process_engine() {
        manager.start();
    }

}
