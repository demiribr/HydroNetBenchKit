-- copy structure and data from table src_st to st
CREATE TABLE st AS SELECT * FROM src_st;

-- Constraint: st_pkey
-- ALTER TABLE st DROP CONSTRAINT st_pkey;
ALTER TABLE st ADD CONSTRAINT st_pkey PRIMARY KEY(id);

-- Index: st_path_idx
-- DROP INDEX st_path_idx;
CREATE INDEX st_path_idx ON st USING btree(path);
