-- nested set model
-- query for child

SELECT  DISTINCT ON (MAX(hc.nright) OVER (ORDER BY hc.nleft)) hc.id
FROM    src_ns hp
JOIN    src_ns hc
ON hc.nleft > hp.nleft
        AND hc.nleft < hp.nright
WHERE   hp.id = {}
ORDER BY
        MAX(hc.nright) OVER (ORDER BY hc.nleft), hc.nleft;

