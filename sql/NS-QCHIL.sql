-- nested set model
-- query for child

SELECT  DISTINCT ON (MAX(hc.nright) OVER (ORDER BY hc.nleft)) hc.id
FROM    ns hp
JOIN    ns hc
ON      hc.nleft > hp.nleft
        AND hc.nleft < hp.nright
WHERE   hp.id = 45668
ORDER BY
        MAX(hc.nright) OVER (ORDER BY hc.nleft), hc.nleft;

-- based on
-- https://explainextended.com/2010/03/01/postgresql-nested-sets-and-r-tree/
