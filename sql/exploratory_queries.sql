/* Task 1. Find the number of trips for each company on November 15 and 16, 2017.
Order the result by the number of trips in descending order. */

SELECT 
    cabs.company_name, 
    COUNT( trips.trip_id) AS trips_amount

FROM trips
    
INNER JOIN cabs ON cabs.cab_id = trips.cab_id

WHERE CAST(trips.start_ts AS DATE) = '2017-11-15' OR CAST(trips.start_ts AS DATE) = '2017-11-16'

GROUP BY 
    cabs.company_name

ORDER BY trips_amount DESC

/* Task 2. Find the number of trips for each company that contains "Yellow" or "Blue" from November 1 to November 7, 2017.
Order the result by the number of trips in descending order. */


SELECT 
    cabs.company_name,
    COUNT(trips.trip_id) AS trips_amount
FROM 
    cabs
INNER JOIN 
    trips
ON 
    trips.cab_id = cabs.cab_id
WHERE 
CAST(trips.start_ts AS DATE) BETWEEN '2017-11-01' AND '2017-11-07' AND cabs.company_name LIKE '%Yellow%'
GROUP BY 
    company_name
UNION ALL
SELECT 
    cabs.company_name,
    COUNT(trips.trip_id) AS trips_amount
FROM 
    cabs
INNER JOIN 
    trips
ON 
    trips.cab_id = cabs.cab_id
WHERE 
CAST(trips.start_ts AS DATE) BETWEEN '2017-11-01' AND '2017-11-07' AND cabs.company_name LIKE '%Blue%'
GROUP BY 
    company_name

/* Task 3. Find the number of trips for each company that contains "Flash Cab" or "Taxi Affiliation Services" from November 1 to November 7, 2017.
Order the result by the number of trips in descending order. */

SELECT 
    CASE
        WHEN cabs.company_name = 'Flash Cab' THEN 'Flash Cab'
        WHEN cabs.company_name = 'Taxi Affiliation Services' THEN 'Taxi Affiliation Services'
        ELSE 'Other'
END AS company,
    COUNT(trips.trip_id) AS trips_amount
FROM 
    trips
INNER JOIN 
    cabs ON cabs.cab_id = trips.cab_id
WHERE 
    CAST(trips.start_ts AS DATE) BETWEEN '2017-11-1' AND '2017-11-7'
GROUP BY 
    company
ORDER BY 
    trips_amount DESC

/* Task 4. Find the id and name of the neighborhoods that end with "Hare" or "Loop". */

SELECT 
    neighborhood_id, name
FROM 
    neighborhoods
WHERE 
    name LIKE '%Hare' OR name LIKE 'Loop'

/* Task 5. Find the timestamp and weather conditions for each record in the weather_records table.
Consider the weather conditions as "Bad" if the description contains "rain" or "storm", and "Good" otherwise. */

SELECT 
    ts,
CASE
    WHEN description LIKE '%rain%' THEN 'Bad'
    WHEN description LIKE '%storm%' THEN 'Bad'
    ELSE 'Good'
END AS weather_conditions
FROM weather_records

/* Task 6. Find the timestamp, weather conditions, and duration of the trips that started on Saturday,
November 18, 2017, from location 50 to location 63.
Consider the weather conditions as "Bad" if the description contains "rain" or "storm", and "Good" otherwise.
Order the result by the trip_id. */

SELECT 
    start_ts,
    T.weather_conditions,
    duration_seconds

FROM trips
INNER JOIN (
    SELECT 
        ts,
        CASE
            WHEN description LIKE '%rain%' OR description LIKE '%storm%' THEN 'Bad'
            ELSE 'Good'
        END AS weather_conditions
    FROM weather_records
) T on T.ts = trips.start_ts
WHERE  pickup_location_id = 50 AND dropoff_location_id = 63 AND EXTRACT (DOW from trips.start_ts) = 6
ORDER BY 
    trip_id