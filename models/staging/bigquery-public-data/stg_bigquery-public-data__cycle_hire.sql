{{ config(
        materialized='table',
        schema = 'staging'
) }}


with 

source as (

    select * from {{ source('bigquery-public-data', 'cycle_hire') }}

),

renamed as (

    select
        rental_id,
        duration,
        duration_ms,
        bike_id,
        bike_model,
        end_date,
        end_station_id,
        end_station_name,
        start_date,
        start_station_id,
        start_station_name,
        end_station_logical_terminal,
        start_station_logical_terminal,
        end_station_priority_id,
        null AS test

    from source

)

select * from renamed
