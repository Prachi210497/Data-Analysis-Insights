
-- Main Query to Analyze Belt Allocation Hourly with 2-hour Time Gap Classification

SELECT 
    -- Format start time to the nearest hour for time series analysis
    CAST(DATE_FORMAT(O.belt_allocation_start_time, '%Y-%m-%d %H:00:00') AS TIMESTAMP) AS allocation_hour,

    -- Count how many distinct belts were assigned during each hour
    COUNT(DISTINCT O.belt_name) AS belts_assigned,

    -- Classify into 2-hour time buckets
    CASE
        WHEN HOUR(O.belt_allocation_start_time) < 2 THEN '00:00 - 02:00'
        WHEN HOUR(O.belt_allocation_start_time) < 4 THEN '02:00 - 04:00'
        WHEN HOUR(O.belt_allocation_start_time) < 6 THEN '04:00 - 06:00'
        WHEN HOUR(O.belt_allocation_start_time) < 8 THEN '06:00 - 08:00'
        WHEN HOUR(O.belt_allocation_start_time) < 10 THEN '08:00 - 10:00'
        WHEN HOUR(O.belt_allocation_start_time) < 12 THEN '10:00 - 12:00'
        WHEN HOUR(O.belt_allocation_start_time) < 14 THEN '12:00 - 14:00'
        WHEN HOUR(O.belt_allocation_start_time) < 16 THEN '14:00 - 16:00'
        WHEN HOUR(O.belt_allocation_start_time) < 18 THEN '16:00 - 18:00'
        WHEN HOUR(O.belt_allocation_start_time) < 20 THEN '18:00 - 20:00'
        WHEN HOUR(O.belt_allocation_start_time) < 22 THEN '20:00 - 22:00'
        ELSE '22:00 - 00:00'
    END AS time_gap_2_hour,

    -- Optional: Calculate delay in minutes from 'delayed_time' format 'HH:MM:SS'
    (CAST(SPLIT_PART(delayed_time, ':', 1) AS INTEGER) * 60 +
     CAST(SPLIT_PART(delayed_time, ':', 2) AS INTEGER) +
     CAST(SPLIT_PART(delayed_time, ':', 3) AS INTEGER) / 60.0) AS delay_duration_minutes,

    -- Flight capacity assigned to the belt (can be summed later for capacity analysis)
    CAST(flights_passenger_capacity AS INTEGER) AS flight_capacity,

    -- Belt capacity from belt master table
    belt_capacity

FROM 
    gmraodb.gmraodb_belts_master_output_data O
    LEFT JOIN gmraodb.gmraodb_belt_master B 
        ON O.belt_name = B.belt_number 

WHERE 
    O.belt_allocation_start_time IS NOT NULL

ORDER BY 
    allocation_hour;
