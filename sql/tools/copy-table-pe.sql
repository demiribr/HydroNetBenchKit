-- copy structure and data from table src_pe to pe
CREATE TABLE pe AS SELECT * FROM src_pe;

-- Constraint: main_key
-- ALTER TABLE pe DROP CONSTRAINT main_key_pe;
ALTER TABLE pe ADD CONSTRAINT main_key_pe PRIMARY KEY(id);

