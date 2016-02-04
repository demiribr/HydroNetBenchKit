-- path enumeration model
-- query for sub-tree

SELECT id FROM src_pe 
WHERE '605797'::text = ANY (string_to_array(path, '/'))
ORDER BY id ASC;

