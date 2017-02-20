-- path enumeration model
-- query for parent

SELECT apath[array_length(apath,1)] FROM src_pe WHERE id={};
