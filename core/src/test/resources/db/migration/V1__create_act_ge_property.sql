DROP TABLE IF EXISTS ACT_GE_PROPERTY;
CREATE TABLE ACT_GE_PROPERTY (
  NAME_ varchar(64) NOT NULL DEFAULT '',
  VALUE_ varchar(300) DEFAULT NULL,
  REV_ int(11) DEFAULT NULL,
  PRIMARY KEY (NAME_)
);

INSERT INTO ACT_GE_PROPERTY (NAME_, VALUE_, REV_) VALUES
('deployment.lock', '0',  1),
('historyLevel',  '3',  1),
('next.dbid',	'1',  1),
('schema.history',  'create(fox)',  1),
('schema.version',  'fox',  1);
