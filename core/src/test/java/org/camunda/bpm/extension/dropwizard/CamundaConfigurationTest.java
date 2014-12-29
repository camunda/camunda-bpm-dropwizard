package org.camunda.bpm.extension.dropwizard;

import io.dropwizard.db.DataSourceFactory;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.junit.Test;

import javax.validation.Validation;
import javax.validation.Validator;

import static org.assertj.core.api.Assertions.*;

public class CamundaConfigurationTest {

  public static final String URL = "jdbc:foo/bar";
  public static final String USER = "user";
  public static final String PASSWORD = "password";
  public static final String DRIVER = "com.db.Driver";

  private final ProcessEngineConfiguration pec = ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration();

  private final Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

  @Test
  public void initializes_with_camunda_defaults() {
    final CamundaConfiguration configuration = new CamundaConfiguration();

    final DataSourceFactory database = configuration.getCamundaDataSourceFactory();

    assertThat(database.getDriverClass()).isEqualTo(pec.getJdbcDriver());
    assertThat(database.getUrl()).isEqualTo(pec.getJdbcUrl());
    assertThat(database.getUser()).isEqualTo(pec.getJdbcUsername());
    assertThat(database.getPassword()).isEqualTo(pec.getJdbcPassword());

  }

  @Test
  public void has_valid_defaults() {
    assertThat(validator.validate(new CamundaConfiguration())).isEmpty();
  }

  @Test
  public void uses_configured_dropwizard_values() {
    final CamundaConfiguration configuration = new CamundaConfiguration();
    final DataSourceFactory database = configuration.getCamundaDataSourceFactory();
    database.setDriverClass(DRIVER);
    database.setUser(USER);
    database.setPassword(PASSWORD);
    database.setUrl(URL);

    final ProcessEngineConfiguration processEngineConfiguration = configuration.getProcessEngineConfiguration();

    assertThat(processEngineConfiguration.getJdbcDriver()).isEqualTo(DRIVER);
    assertThat(processEngineConfiguration.getJdbcUsername()).isEqualTo(USER);
    assertThat(processEngineConfiguration.getJdbcPassword()).isEqualTo(PASSWORD);
    assertThat(processEngineConfiguration.getJdbcUrl()).isEqualTo(URL);
  }
}
