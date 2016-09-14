
CREATE TABLE demo
(
  id character varying(128) NOT NULL,
  vol1 numeric,
  vol2 numeric,
  vol3 numeric,

  CONSTRAINT pk_demo PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
