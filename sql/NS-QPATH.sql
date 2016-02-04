-- nested set model
-- query for full path (downstream)

SELECT Supers.id FROM src_ns AS t1, src_ns AS Supers 
WHERE t1.id = 605797 
AND t1.nleft BETWEEN Supers.nleft AND Supers.nright
ORDER BY id ASC;

