{{ config(
        materialized='table',
        schema = 'marts'
) }}


with 

source as (

    select * from {{ ref('stg_bigquery-public-data__cycle_hire') }}
)
    
select *
from source


