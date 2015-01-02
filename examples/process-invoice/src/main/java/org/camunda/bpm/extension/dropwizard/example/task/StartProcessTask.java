package org.camunda.bpm.extension.dropwizard.example.task;

import com.google.common.collect.ImmutableMultimap;
import io.dropwizard.servlets.tasks.Task;
import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.runtime.ProcessInstance;
import org.camunda.bpm.extension.dropwizard.example.CamundaDropwizardExampleApplication;

import java.io.PrintWriter;


public class StartProcessTask extends Task {

  public StartProcessTask() {
    super("start_process");
  }

  @Override
  public void execute(ImmutableMultimap<String, String> immutableMultimap, final PrintWriter out) throws Exception {
    startProcess();
    out.println("task executed");
  }

  public ProcessInstance startProcess() {
    return ProcessEngines.getDefaultProcessEngine().getRuntimeService().startProcessInstanceByKey(CamundaDropwizardExampleApplication.PROCESS_DEFINITION_KEY);
  }
}
