CREATE DATABASE highcloud_airlines;
USE highcloud_airlines;

CREATE TABLE flights_correct (
    YEAR INT,
    MONTH INT,
    DAY INT,
    DAY_OF_WEEK INT,
    AIRLINE TEXT,
    FLIGHT_NUMBER INT,
    TAIL_NUMBER TEXT,
    ORIGIN_AIRPORT TEXT,
    DESTINATION_AIRPORT TEXT,
    SCHEDULED_DEPARTURE INT,
    DEPARTURE_TIME INT,
    DEPARTURE_DELAY INT,
    TAXI_OUT INT,
    WHEELS_OFF INT,
    SCHEDULED_TIME INT,
    ELAPSED_TIME INT,
    AIR_TIME INT,
    DISTANCE INT,
    WHEELS_ON INT,
    TAXI_IN INT,
    SCHEDULED_ARRIVAL INT,
    ARRIVAL_TIME INT,
    ARRIVAL_DELAY INT,
    DIVERTED INT,
    CANCELLED INT,
    CANCELLATION_REASON TEXT,
    AIR_SYSTEM_DELAY INT,
    SECURITY_DELAY INT,
    AIRLINE_DELAY INT,
    LATE_AIRCRAFT_DELAY INT,
    WEATHER_DELAY INT,
    DATE TEXT
);

SELECT COUNT(*) AS Total_flights
FROM flights_correct;

SELECT
    COUNT(*) AS Total_Cancelled_Flights
FROM flights_correct
WHERE CANCELLED = 1;

-- Weekday Vs Weekend Total Flights Statistics
SELECT
    CASE
        WHEN DAY_OF_WEEK IN (6,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    COUNT(*) AS Total_Flights
FROM flights_correct
GROUP BY
    CASE
        WHEN DAY_OF_WEEK IN (6,7) THEN 'Weekend'
        ELSE 'Weekday'
    END;
    
    -- Total Cancelled Flights for JetBlue Airways on First Date of Every Month
    SELECT
    `YEAR`,
    `MONTH`,
    COUNT(*) AS Cancelled_Flights
FROM flights_correct
WHERE AIRLINE = 'B6'
  AND `DAY` = 1
  AND CANCELLED = 1
GROUP BY `YEAR`, `MONTH`
ORDER BY `YEAR`, `MONTH`;

-- Week-wise Delay Statistics with Airline Details
# Week-wise
SELECT
    WEEK(`DATE`, 1) AS Week_Number,
    AIRLINE,
    COUNT(*) AS Total_Flights,
    SUM(ARRIVAL_DELAY > 0) AS Delayed_Flights,
    ROUND(AVG(ARRIVAL_DELAY), 2) AS Avg_Arrival_Delay
FROM flights_correct
WHERE CANCELLED = 0
GROUP BY WEEK(`DATE`, 1), AIRLINE
ORDER BY Week_Number, AIRLINE;
    
-- Number of Airlines with No Departure/Arrival Delay and Distance Between 2500 and 3000
SELECT
    al.AIRLINE,
    COUNT(*) AS Flights
FROM flights_correct f
JOIN airlines al
    ON f.AIRLINE = al.IATA_CODE
WHERE f.DISTANCE BETWEEN 2500 AND 3000
  AND f.DEPARTURE_DELAY <= 0
  AND f.ARRIVAL_DELAY <= 0
  AND f.CANCELLED = 0
GROUP BY
    al.AIRLINE
ORDER BY
    Flights DESC;
    

