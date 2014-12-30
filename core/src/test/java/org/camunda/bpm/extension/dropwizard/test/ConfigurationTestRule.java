package org.camunda.bpm.extension.dropwizard.test;

import com.codahale.metrics.MetricRegistry;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Charsets;
import com.google.common.base.Function;
import com.google.common.base.Supplier;
import com.google.common.base.Throwables;
import com.google.common.io.Files;
import io.dropwizard.Configuration;
import io.dropwizard.configuration.ConfigurationFactory;
import io.dropwizard.setup.Bootstrap;
import org.camunda.bpm.extension.dropwizard.CamundaConfiguration;
import org.junit.Rule;
import org.junit.rules.ExternalResource;
import org.junit.rules.TemporaryFolder;
import org.mockito.Mockito;

import javax.annotation.Nullable;
import javax.validation.Validation;
import javax.validation.Validator;
import java.io.File;
import java.io.IOException;

import static com.google.common.base.Throwables.propagate;


public class ConfigurationTestRule<T extends Configuration> extends TemporaryFolder implements Function<String, T>, Supplier<ConfigurationFactory<T>> {

  public static <T extends Configuration> ConfigurationTestRule<T> create(Class<T> type) {
    return new ConfigurationTestRule<T>(type);
  }

  private final ConfigurationFactory<T> factory;

  private ConfigurationTestRule(Class<T> configurationClass) {
    final Bootstrap<T> bootstrap = new Bootstrap<T>(null) {
      @Override
      public MetricRegistry getMetricRegistry() {
        return Mockito.mock(MetricRegistry.class);
      }
    };
    factory = bootstrap.getConfigurationFactoryFactory().create(configurationClass, bootstrap.getValidatorFactory().getValidator(), bootstrap.getObjectMapper(), "dw.");
  }

  @Override
  public T apply(String content) {
    try {
      final File file = newFile();
      Files.write(content, file, Charsets.UTF_8);
      return factory.build(file);
    } catch (Exception e) {
      throw propagate(e);
    }
  }


  @Override
  public ConfigurationFactory<T> get() {
    return factory;
  }
}
