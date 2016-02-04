-- stream model
-- query for sub-tree; return id ascending

SELECT src_sn.id FROM src_sn,
(SELECT * FROM src_sn WHERE id={}) node
WHERE src_sn.path <@ node.path AND src_sn.root=node.root
ORDER BY src_sn.id ASC;

