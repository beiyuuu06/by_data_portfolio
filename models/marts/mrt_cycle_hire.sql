{{ config(
        materialized='table',
        schema = 'marts'
) }}


with 

cycle_hire as (
    select * from {{ ref('int_cycle_hire') }}
),

start_station_info as (
    select * from {{ ref('stg_bigquery-public-data__cycle_stations') }}
),

end_station_info as (
    select * from {{ ref('stg_bigquery-public-data__cycle_stations') }}
),

final as (
    select 
        cycle_hire.*,

        start_station_info.latitude      AS start_station_latitude,
        start_station_info.longitude     AS start_station_longitude,
        start_station_info.install_date  AS start_station_install_date,

        end_station_info.latitude      AS end_station_latitude,
        end_station_info.longitude     AS end_station_longitude,
        end_station_info.install_date  AS end_station_install_date,

    from cycle_hire

    left join start_station_info
    on cycle_hire.start_station_id = start_station_info.id

    left join end_station_info
    on cycle_hire.end_station_id = end_station_info.id

)



    
select *
from final


