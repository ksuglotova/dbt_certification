select
  d.indicator_id,
  i.string_field_1 as indicator_name,
  d.region_id,
  r.region_type,
  r.region,
  d.date,
  d.value
from {{ ref('stg_zillow_data') }} d
left join {{ ref('stg_zillow_indicators') }} i
  on i.string_field_0 = d.indicator_id
left join {{ ref('stg_zillow_regions') }} r
  on r.region_id = d.region_id 
where d.indicator_id = 'Z4BR'  