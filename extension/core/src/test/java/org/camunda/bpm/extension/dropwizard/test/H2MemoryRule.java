package org.camunda.bpm.extension.dropwizard.test;

import com.google.common.base.Supplier;
import org.flywaydb.core.Flyway;
import org.junit.rules.ExternalResource;
import org.skife.jdbi.v2.DBI;

public class H2MemoryRule<T> extends ExternalResource implements Supplier<T> {

  public static final String H2_URL = "jdbc:h2:mem:test;DB_CLOSE_DELAY=-1";
  public static final String H2_USER = "sa";
  public static final String H2_PW = "null";

  private final Flyway flyway = new Flyway();

  private final DBI dbi;
  private final T dao;

  public H2MemoryRule(final Class<T> daoType) {
    flyway.setDataSource(H2_URL, H2_USER, H2_PW);
    dbi = new DBI(flyway.getDataSource());
    this.dao = dbi.onDemand(daoType);
  }

  @Override
  protected void before() {
    flyway.migrate();
  }

  @Override
  protected void after() {
    flyway.clean();
  }

  @Override
  public T get() {
    return dao;
  }


  public DBI getDbi() {
    return dbi;
  }
}
