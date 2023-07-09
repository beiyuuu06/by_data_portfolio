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
        bike_id,
        end_date,
        end_station_id,
        IFNULL(end_station_name, 'DID NOT DOCK')    AS end_station_name,
        start_date,
        start_station_id,
        start_station_name
    from source

)

select * from renamed
