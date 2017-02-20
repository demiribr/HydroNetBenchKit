-- path enumeration model
-- query for child

SELECT id FROM src_pe WHERE apath @> 
(SELECT apath::integer[] || 1000 FROM src_pe WHERE id=1000)
AND array_length(apath,1) = (SELECT array_length(apath,1) + 1 FROM src_pe WHERE id=1000);