-- stream model
-- query for full path (downstream); return id from outlet/root

SELECT src_sn.id FROM src_sn,
(SELECT * FROM src_sn WHERE id=605797) node
WHERE src_sn.path @> node.path AND src_sn.root=node.root
ORDER BY src_sn.id ASC;
