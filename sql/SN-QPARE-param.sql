-- stream network model
-- query for parent

SELECT sn.id FROM src_sn AS sn,
(SELECT * FROM src_sn WHERE id={}) node
WHERE sn.path=subpath(node.path, 0, nlevel(node.path)-1)
    AND sn.root=node.root;

