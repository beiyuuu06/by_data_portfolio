{{ config(
        materialized='table',
        schema = 'staging'
) }}


with 

source as (

    select * from {{ source('bigquery-public-data', 'cycle_stations') }}

),

renamed as (

    select
        id,
        installed,
        latitude,
        locked,
        longitude,
        name,
        bikes_count,
        docks_count,
        nbemptydocks,
        temporary,
        terminal_name,
        install_date,
        removal_date

    from source

)

select * from renamed
