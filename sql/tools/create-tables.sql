-- Table: src
-- DROP TABLE src;

CREATE TABLE src
(
  id integer NOT NULL,
  up_area bigint,
  nleft integer, 
  nright integer, 
  parent integer,
  CONSTRAINT main_key PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

-- Index: src_parent_idx
-- DROP INDEX src_parent_idx;

CREATE INDEX src_parent_idx
  ON src
  USING btree
  (parent);


-- Table: src_al
-- DROP TABLE src_al;

CREATE TABLE src_al
(
  id integer NOT NULL,
  up_area bigint,
  parent integer,
  CONSTRAINT main_key_al PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

-- Index: src_al_parent_idx
-- DROP INDEX src_al_parent_idx;

CREATE INDEX src_al_parent_idx
  ON src_al
  USING btree
  (parent);


-- Table: src_ns
-- DROP TABLE src_ns;

CREATE TABLE src_ns
(
  id integer NOT NULL,
  parent integer,
  nleft integer,
  nright integer,
  CONSTRAINT main_key_ns PRIMARY KEY (id),
  CONSTRAINT ns_ck_nleft_nright CHECK ((nleft + 1) <= nright)
)
WITH (
  OIDS=FALSE
);

-- Index: src_ns_nleft_idx
-- DROP INDEX src_ns_nleft_idx;

CREATE INDEX src_ns_nleft_idx
  ON src_ns
  USING btree
  (nleft);

-- Index: src_ns_nright_idx
-- DROP INDEX src_ns_nright_idx;

CREATE INDEX src_ns_nright_idx
  ON src_ns
  USING btree
  (nright);

-- Index: parent_idx_ns
-- DROP INDEX parent_idx_ns;

CREATE INDEX src_ns_parent_idx
  ON src_ns
  USING btree
  (parent);



-- Table: src_pe
-- DROP TABLE src_pe;

CREATE TABLE src_pe
(
  id integer NOT NULL,
  path text,
  apath integer[],
  CONSTRAINT main_key_src_pe PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

-- Index: src_pe_apath_idx
-- DROP INDEX src_pe_apath_idx;

CREATE INDEX src_pe_apath_idx
  ON src_pe
  USING gin
  (apath);


-- Stream network model
-- Table: src_sn
-- DROP TABLE src_sn;

CREATE TABLE src_sn
(
  id integer NOT NULL,
  root integer NOT NULL,
  parent integer NOT NULL,
  path ltree,
  up_area bigint,
  CONSTRAINT src_sn_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

-- Index: src_sn_path_idx
-- DROP INDEX src_sn_path_idx;

CREATE INDEX src_sn_path_idx
  ON src_sn
  USING btree
  (path);
