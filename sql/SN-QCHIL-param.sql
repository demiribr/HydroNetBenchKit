-- stream model
-- query for child; return id ascending

SELECT src_sn.id FROM src_sn,
(SELECT * FROM src_sn WHERE id={}) node
WHERE node.path = subpath(src_sn.path, 0, nlevel(src_sn.path)-1) AND src_sn.root=node.root
ORDER BY src_sn.id ASC;

