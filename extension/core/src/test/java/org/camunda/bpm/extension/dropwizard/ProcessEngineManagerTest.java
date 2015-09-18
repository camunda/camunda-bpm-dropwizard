package org.camunda.bpm.extension.dropwizard;

import org.camunda.bpm.engine.ProcessEngine;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.camunda.bpm.engine.ProcessEngines;
import org.junit.Test;

import static org.assertj.core.api.Assertions.*;

public class ProcessEngineManagerTest {

  private final ProcessEngineManager manager = new ProcessEngineManager(ProcessEngineConfiguration.createStandaloneInMemProcessEngineConfiguration());

  @Test
  public void starts_process_engine() {
    manager.start();

    final ProcessEngine defaultProcessEngine = ProcessEngines.getDefaultProcessEngine();
    assertThat(defaultProcessEngine).isNotNull();
    assertThat(defaultProcessEngine.getName()).isEqualTo(ProcessEngines.NAME_DEFAULT);

    manager.stop();
  }

}
