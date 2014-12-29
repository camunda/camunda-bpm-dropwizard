package org.camunda.bpm.extension.dropwizard.task;

import com.google.common.collect.ImmutableMultimap;
import io.dropwizard.servlets.tasks.Task;

import java.io.PrintWriter;


public class StartProcessTask extends Task {

  public StartProcessTask() {
    super("start_process");
  }

  @Override
  public void execute(ImmutableMultimap<String, String> immutableMultimap, final PrintWriter out) throws Exception {
    out.println("task executed");
  }
}
