-- path enumeration model
-- query for child

SELECT id FROM src_pe WHERE apath @> 
(SELECT apath::integer[] || {} FROM src_pe WHERE id={})
AND array_length(apath,1) = (SELECT array_length(apath,1) + 1 FROM src_pe WHERE id={});
