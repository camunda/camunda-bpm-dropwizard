package org.camunda.bpm.extension.dropwizard.db;

import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.camunda.bpm.extension.dropwizard.test.H2MemoryRule;
import org.junit.Rule;
import org.junit.Test;
import org.skife.jdbi.v2.Handle;
import org.skife.jdbi.v2.tweak.HandleCallback;

import static org.assertj.core.api.Assertions.*;

public class GetHistoryLevelDaoTest {

  @Rule
  public final H2MemoryRule<GetHistoryLevelDao> h2 = new H2MemoryRule(GetHistoryLevelDao.class);

  @Test
  public void matches_history_level_full() {
    assertThat(h2.get().get()).isEqualTo(ProcessEngineConfiguration.HISTORY_FULL);
  }

  @Test
  public void returns_absent_when_no_value_is_found() {
    h2.getDbi().withHandle(new HandleCallback<Void>() {
      @Override
      public Void withHandle(Handle handle) throws Exception {
        handle.execute("drop table act_ge_property");
        return null;
      }
    });

    assertThat(h2.get().getFailsafe().isPresent()).isFalse();
  }
}
