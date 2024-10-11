-- Indicators SAAM, SASM can have negative values
select *
from {{ ref('stg_zillow_data') }}
where value < 0
  and indicator_id not in ('SAAM', 'SASM')