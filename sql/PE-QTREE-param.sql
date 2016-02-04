-- path enumeration model
-- query for sub-tree

SELECT id FROM src_pe 
WHERE '{}'::text = ANY (string_to_array(path, '/'))
ORDER BY id ASC;

