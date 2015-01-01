package org.camunda.bpm.extension.dropwizard.function;

import com.google.common.base.Supplier;
import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.impl.cfg.ProcessEngineConfigurationImpl;

public class ProcessEngineConfigurationSupplier implements Supplier<ProcessEngineConfigurationImpl> {

  public final static ProcessEngineConfigurationSupplier INSTANCE = new ProcessEngineConfigurationSupplier();

  @Override
  public ProcessEngineConfigurationImpl get() {
    return (ProcessEngineConfigurationImpl) ProcessEngines.getDefaultProcessEngine().getProcessEngineConfiguration();
  }
}
