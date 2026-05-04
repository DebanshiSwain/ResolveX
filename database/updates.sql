UPDATE complaints 
SET slot = NULL 
WHERE slot::text LIKE '%at%';

UPDATE complaints
SET slot = NULL
WHERE slot IS NOT NULL
AND slot::text !~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}';
