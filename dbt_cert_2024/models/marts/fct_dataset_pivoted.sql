-- This model returns deterministic results only with a static set of indicators in the dataset.
-- In order to make a model deterministic, remove max_records parameter in the first macro call.

{% set indicators = dbt_utils.get_column_values(
	table=ref('stg_zillow_indicators'),
	column='string_field_0',
	order_by='string_field_0',
	max_records=5
	) 
-%}

select
  date_trunc(d.date, month) as report_month,
  {{ pivot_sum(
		dim_column_name='d.indicator_id',
		fact_column_name='d.value',
		value_dict=var_to_lowercase(value_list=indicators)
	) 
  }}
from {{ ref('stg_zillow_data') }} d
group by 1
