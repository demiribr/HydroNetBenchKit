-- nested set model
-- query for sub-tree

SELECT t2.id FROM src_ns t1
JOIN src_ns t2 ON t2.nleft
BETWEEN t1.nleft AND t1.nright
WHERE t1.id = {}
ORDER BY t2.id ASC;
