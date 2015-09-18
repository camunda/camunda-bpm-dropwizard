package org.camunda.bpm.extension.dropwizard;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Optional;
import io.dropwizard.configuration.ConfigurationFactory;
import io.dropwizard.configuration.ConfigurationParsingException;
import io.dropwizard.db.DataSourceFactory;
import io.dropwizard.setup.Environment;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.camunda.bpm.extension.dropwizard.test.ConfigurationTestRule;
import org.hamcrest.CoreMatchers;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.mockito.Mockito;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.stubbing.Answer;
import org.slf4j.Logger;

import javax.validation.Validation;
import javax.validation.Validator;

import static org.assertj.core.api.Assertions.assertThat;
import static org.camunda.bpm.engine.ProcessEngineConfiguration.HISTORY_AUDIT;
import static org.camunda.bpm.engine.ProcessEngineConfiguration.HISTORY_FULL;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.slf4j.LoggerFactory.getLogger;

public class CamundaConfigurationTest {

  public static final String URL = "jdbc:foo/bar";
  public static final String USER = "user";
  public static final String PASSWORD = "password";
  public static final String DRIVER = "com.db.Driver";

  private final Logger logger = getLogger(this.getClass());

  @Rule
  public final ConfigurationTestRule<CamundaConfiguration> configurationTestRule = ConfigurationTestRule.create(CamundaConfiguration.class);

  @Rule
  public final ExpectedException thrown = ExpectedException.none();

  @Test
  public void reads_camunda_db_settings_from_file() {
    // @formatter:off
    final CamundaConfiguration configuration = configurationTestRule.apply(
      "camunda:\n" +
        "  database:\n" +
        "    user: user\n" +
        "    password: password\n" +
        "    driverClass: com.db.Driver\n" +
        "    url: jdbc:foo:bar");
    // @formatter:on

    final ProcessEngineConfiguration processEngineConfiguration = configuration.buildProcessEngineConfiguration();

    assertThat(processEngineConfiguration.getJdbcUsername()).isEqualTo("user");
    assertThat(processEngineConfiguration.getHistory()).isEqualTo(HISTORY_AUDIT);
    assertThat(configuration.getCamunda().getDatabase().getUser()).isEqualTo("user");
  }


  private final ProcessEngineConfiguration pec = ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration();

  private final Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

  private final ConfigurationFactory<CamundaConfiguration> configurationFactory = new ConfigurationFactory<CamundaConfiguration>(CamundaConfiguration.class, validator, new ObjectMapper(), "dw.");


  @Test
  public void fails_for_empty_file() {
    thrown.expectCause(CoreMatchers.is(ConfigurationParsingException.class));
    configurationTestRule.apply("");
  }

  @Test
  public void fails_for_unknown_key() {
    thrown.expectCause(CoreMatchers.is(ConfigurationParsingException.class));
    configurationTestRule.apply("foo: bar");
  }


  @Test
  public void initializes_with_camunda_defaults() {
    final CamundaConfiguration configuration = new CamundaConfiguration();

    final DataSourceFactory database = configuration.getCamunda().getDatabase();

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
    final DataSourceFactory database = configuration.getCamunda().getDatabase();
    database.setDriverClass(DRIVER);
    database.setUser(USER);
    database.setPassword(PASSWORD);
    database.setUrl(URL);

    final ProcessEngineConfiguration processEngineConfiguration = configuration.buildProcessEngineConfiguration();

    assertThat(processEngineConfiguration.getJdbcDriver()).isEqualTo(DRIVER);
    assertThat(processEngineConfiguration.getJdbcUsername()).isEqualTo(USER);
    assertThat(processEngineConfiguration.getJdbcPassword()).isEqualTo(PASSWORD);
    assertThat(processEngineConfiguration.getJdbcUrl()).isEqualTo(URL);
  }

  @Test
  public void does_not_overwrite_historyLevel_when_not_set_to_auto() {
    final CamundaConfiguration configuration = overwriteHistoryLevel("camunda:\n" +
      "  historyLevel: audit", HISTORY_FULL);
    assertThat(configuration.buildProcessEngineConfiguration().getHistory()).isEqualTo(HISTORY_AUDIT);
  }

  @Test
  public void overwrite_historyLevel_when_set_to_auto() {
    final CamundaConfiguration configuration = overwriteHistoryLevel("camunda:\n" +
      "  historyLevel: auto", HISTORY_FULL);
    assertThat(configuration.buildProcessEngineConfiguration().getHistory()).isEqualTo(HISTORY_FULL);
  }

  private CamundaConfiguration overwriteHistoryLevel(final String configContent, final String historyLevel) {
    // @formatter:off
    final CamundaConfiguration configuration = Mockito.spy(configurationTestRule.apply(configContent));
    // @formatter:on

    doAnswer(new Answer<Optional<String>>() {
      @Override
      public Optional<String> answer(InvocationOnMock invocationOnMock) throws Throwable {
        return Optional.of(historyLevel);
      }
    }).when(configuration).selectHistoryLevel(any(Environment.class));

    return configuration.overwriteHistoryLevel(mock(Environment.class));
  }


}
