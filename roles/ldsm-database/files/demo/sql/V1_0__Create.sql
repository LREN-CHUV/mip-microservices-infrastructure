
CREATE TABLE demo
(
  id character varying(128) NOT NULL,
  vol1 number,
  vol2 number,
  vol3 number,

  CONSTRAINT pk_demo PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
