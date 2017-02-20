-- path enumeration model
-- query for sub-tree

SELECT id FROM src_pe WHERE apath @> 
(SELECT apath::integer[] || 1000 FROM src_pe WHERE id=1000)
AND array_length(apath,1)> (SELECT array_length(apath,1) FROM src_pe WHERE id=1000);