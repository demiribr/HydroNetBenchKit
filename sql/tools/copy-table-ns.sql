-- copy structure and data from table src to ns
CREATE TABLE ns AS SELECT id, parent, nleft, nright FROM src;

-- Constraint: main_key
-- ALTER TABLE ns DROP CONSTRAINT main_key_ns;
-- ALTER TABLE ns DROP CONSTRAINT ns_ck_nleft_nright;
ALTER TABLE ns ADD CONSTRAINT main_key_ns PRIMARY KEY(id);

-- left node vs. right node
-- ALTER TABLE ns ADD CONSTRAINT ns_ck_nleft_nright CHECK ((nleft + 1) <= nright);

-- Index: nleft_idx_ns, nright_idx_ns  
-- DROP INDEX nleft_idx_ns;
-- DROP INDEX nright_idx_ns;
-- DROP INDEX parent_idx_ns;
CREATE INDEX nleft_idx_ns ON ns USING btree (nleft);
CREATE INDEX nright_idx_ns ON ns USING btree (nright);
CREATE INDEX parent_idx_ns ON ns USING btree (parent);
