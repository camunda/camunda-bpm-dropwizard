package org.camunda.bpm.extension.dropwizard.example;


import com.google.common.base.Charsets;
import com.google.common.io.Files;
import com.google.common.io.Resources;

import java.io.File;
import java.io.IOException;

import static java.lang.String.format;

/**
 * This is not a test, just another main() class to start a configured application without messing with the main/java code.
 */
public class InvoiceExampleStarter {


  public static class _1 {

     public static void main(String... unused) throws Exception {
        DropwizardInvoiceExampleApplication.main("server", createConfig(5678, true));
    }
  }

  public static class _2 {

     public static void main(String... unused) throws Exception {
        DropwizardInvoiceExampleApplication.main("server", createConfig(5679, false));
    }
  }


  private static String createConfig(int port, boolean jobExecutorActivate) throws IOException {
    final String content = Resources.toString(Resources.getResource("camunda-bpm-dropwizard.yaml"), Charsets.UTF_8);
    final File configFile = File.createTempFile("camunda", "yaml");
    Files.write(format(content, port, jobExecutorActivate),configFile, Charsets.UTF_8);

    return configFile.getAbsolutePath();
  }
}
