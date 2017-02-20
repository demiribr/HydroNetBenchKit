-- path enumeration model
-- query for sub-tree

SELECT id FROM src_pe WHERE apath @> 
(SELECT apath::integer[] || {} FROM src_pe WHERE id={})
AND array_length(apath,1)> (SELECT array_length(apath,1) FROM src_pe WHERE id={});
