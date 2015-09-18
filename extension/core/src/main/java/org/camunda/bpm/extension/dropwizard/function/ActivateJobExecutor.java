package org.camunda.bpm.extension.dropwizard.function;

import com.google.common.collect.ImmutableMultimap;
import io.dropwizard.lifecycle.ServerLifecycleListener;
import io.dropwizard.servlets.tasks.Task;
import org.camunda.bpm.engine.impl.jobexecutor.JobExecutor;
import org.eclipse.jetty.server.Server;
import org.slf4j.Logger;

import java.io.PrintWriter;

import static org.slf4j.LoggerFactory.getLogger;

public class ActivateJobExecutor implements Runnable {

  public static final String NAME = "activate_job_executor";

  private final ProcessEngineConfigurationSupplier processEngineConfigurationSupplier = ProcessEngineConfigurationSupplier.INSTANCE;

  private final Logger logger = getLogger(this.getClass());

  @Override
  public void run() {
    logger.info(start());
  }

  private String start() {
    final JobExecutor jobExecutor = processEngineConfigurationSupplier.get().getJobExecutor();
    if (jobExecutor.isActive()) {
      return "jobExecutor is already running!";
    }

    jobExecutor.start();
    return "jobExecutor started!";
  }

  public static Task task() {
    return new Task(NAME) {
      @Override
      public void execute(final ImmutableMultimap<String, String> unused, final PrintWriter printWriter) throws Exception {
          printWriter.println(new ActivateJobExecutor().start());
      }
    };
  }

  public static ServerLifecycleListener serverLifecycleListener() {
    return new ServerLifecycleListener() {
      @Override
      public void serverStarted(final Server unused) {
        new ActivateJobExecutor().run();
      }
    };
  }
}
