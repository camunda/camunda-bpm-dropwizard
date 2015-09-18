package org.camunda.bpm.extension.dropwizard.db;

import com.google.common.base.Optional;
import com.google.common.base.Supplier;
import com.google.common.base.Throwables;
import org.camunda.bpm.engine.ProcessEngineConfiguration;
import org.skife.jdbi.v2.StatementContext;
import org.skife.jdbi.v2.sqlobject.SqlQuery;
import org.skife.jdbi.v2.sqlobject.customizers.Mapper;
import org.skife.jdbi.v2.tweak.ResultSetMapper;
import org.slf4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;

import static org.slf4j.LoggerFactory.getLogger;


public abstract class GetHistoryLevelDao implements Supplier<String> {

  // @formatter:off
  private static final String[] MAPPING = new String[]{
    ProcessEngineConfiguration.HISTORY_NONE,
    ProcessEngineConfiguration.HISTORY_ACTIVITY,
    ProcessEngineConfiguration.HISTORY_AUDIT,
    ProcessEngineConfiguration.HISTORY_FULL
  };
  // @formatter:on

  private final Logger logger = getLogger(this.getClass());

  public static class HistoryLevelMapper implements ResultSetMapper<String> {
    @Override
    public String map(int index, ResultSet r, StatementContext ctx) throws SQLException {
      // TODO: consider multiple revisions, get highest
      return MAPPING[r.getInt("value_")];
    }
  }

  /**
   * @return the historyLevel name
   */
  @Override
  // note: table and column names must be uppercase, otherwise mysql fails!
  @SqlQuery("select VALUE_ from ACT_GE_PROPERTY where NAME_ = 'historyLevel'")
  @Mapper(HistoryLevelMapper.class)
  public abstract String get();

  public Optional<String> getFailsafe() {
    try {
      return Optional.fromNullable(get());
    } catch (Exception e) {
      logger.error(Throwables.getStackTraceAsString(e));
      return Optional.absent();
    }
  }
}
