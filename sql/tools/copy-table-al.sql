-- copy structure and data from table src to al
CREATE TABLE al AS SELECT id, up_area, parent FROM src;

-- Constraint: main_key
-- ALTER TABLE al DROP CONSTRAINT main_key_al;
ALTER TABLE al ADD CONSTRAINT main_key_al PRIMARY KEY(id);

-- Index: parent_idx_al 
-- DROP INDEX parent_idx_al;
CREATE INDEX parent_idx_al ON al USING btree (parent);
