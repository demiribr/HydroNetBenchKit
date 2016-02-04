-- path enumeration model
-- query for parent

SELECT (string_to_array(path, '/') )[array_length(string_to_array(path, '/'), 1)]  
FROM src_pe WHERE id = {}; 

