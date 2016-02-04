-- nested set model
-- query for parent

SELECT parent.id  
FROM src_ns node, src_ns parent
WHERE (node.nleft BETWEEN parent.nleft AND parent.nright)
AND node.id = {}
ORDER BY parent.nright - parent.nleft LIMIT 1 OFFSET 1;


