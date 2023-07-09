{{ config(
        materialized='table',
        schema = 'intermediate'
) }}


with 

a as (
    select * from {{ ref('stg_bigquery-public-data__cycle_hire') }}
),


b as (
select 
    rental_id,
    bike_id,
    EXTRACT(Date FROM start_date)                               AS start_date,
    EXTRACT(DAYOFWEEK FROM start_date)                          AS start_weekday_num,
    EXTRACT(HOUR FROM start_date)                               AS start_hour,
    start_station_id,
    start_station_name,
    end_station_id,
    end_station_name,
    CONCAT(start_station_name, ' - ', end_station_name)         AS route,
    Round(duration/60, 1)                                       AS duration_in_mins,
    IF(start_station_name = end_station_name, true, false)      AS start_and_end_at_the_same_station_flag,
from a
),

c as (
select
    * EXCEPT(start_weekday_num),
    CASE start_weekday_num
        WHEN 1 THEN 'Sun'
        WHEN 2 THEN 'Mon'
        WHEN 3 THEN 'Tue'
        WHEN 4 THEN 'Wed'
        WHEN 5 THEN 'Thu'
        WHEN 6 THEN 'Fri'
        WHEN 7 THEN 'Sat'
    END                                                          AS start_weekday
from b
where start_date < '2023-01-01'
)


select * from c