WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch AS ft
JOIN page_visits AS pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
LIMIT 5;

SELECT COUNT (DISTINCT utm_campaign)
FROM page_visits;

SELECT COUNT (DISTINCT utm_source)
FROM page_visits;

SELECT utm_campaign,
utm_source
FROM page_visits
GROUP BY 1;

SELECT DISTINCT (page_name)
FROM page_visits;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
result AS (
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch AS ft
JOIN page_visits AS pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT utm_campaign,
  utm_source,
  COUNT (*) AS 'Number of first touches'
FROM result
GROUP BY 1, 2
ORDER BY 3 DESC;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
result AS (
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM last_touch AS lt
JOIN page_visits AS pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT utm_campaign,
  utm_source,
  COUNT (*) AS 'Number of last touches'
FROM result
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT COUNT (DISTINCT user_id) AS 'Distinct Purchases'
FROM page_visits
WHERE page_name = '4 - purchase';

SELECT page_name, COUNT (DISTINCT user_id)
FROM page_visits
GROUP BY 1;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
result AS (
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM last_touch AS lt
JOIN page_visits AS pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE page_name = '4 - purchase'
)
SELECT utm_campaign,
  utm_source,
  COUNT (*) AS 'Number of last touches'
FROM result
GROUP BY 1, 2
ORDER BY 3 DESC;
