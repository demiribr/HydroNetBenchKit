-- nested set model
-- query for parent

SELECT parent.id  
FROM src_ns node, src_ns parent
WHERE (node.nleft BETWEEN parent.nleft AND parent.nright)
AND node.id = 605797
ORDER BY parent.nright - parent.nleft LIMIT 1 OFFSET 1;

-- based on
-- http://stackoverflow.com/questions/1602536/mysql-nested-sets-how-to-find-parent-of-node
