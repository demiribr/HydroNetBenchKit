-- copy structure and data from table src to test1
CREATE TABLE test1 AS SELECT * FROM src;

-- Constraint: main_key
-- ALTER TABLE test1 DROP CONSTRAINT main_key;
ALTER TABLE test1  ADD CONSTRAINT main_key_test1 PRIMARY KEY(link_id);

-- Index: parent_link_idx 
-- DROP INDEX parent_link_idx;
CREATE INDEX parent_link_idx_test1  ON test1  USING btree (parent_link);
