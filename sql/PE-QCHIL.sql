-- path enumeration model
-- query for child

SELECT id from src_pe 
WHERE (string_to_array(path, '/') )[array_length(string_to_array(path, '/'), 1)] :: int = 605797
ORDER BY id ASC; 
