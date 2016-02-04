-- nested set model
-- query for child

SELECT hc.id FROM src_ns hc JOIN src_ns hp
ON hc.nleft BETWEEN hp.nleft AND hp.nright
WHERE hp.id = 605797
AND
(SELECT count(*) FROM src_ns hn 
WHERE hc.nleft BETWEEN hn.nleft AND hn.nright 
	AND hn.nleft BETWEEN hp.nleft AND hp.nright
) = 2
ORDER BY hc.id ASC;

-- based on
-- http://explainextended.com/2009/09/24/adjacency-list-vs-nested-sets-postgresql/
