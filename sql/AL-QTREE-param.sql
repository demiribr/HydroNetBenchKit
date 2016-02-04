-- adjacency list model
-- query for sub-tree

WITH RECURSIVE node(id, parent) AS (
    SELECT id, parent
    FROM src_al
    WHERE id = {}
    UNION ALL
    SELECT C.id, C.parent
    FROM node P
    INNER JOIN src_al C ON P.id = C.parent
)
SELECT id FROM node
ORDER BY id ASC;
