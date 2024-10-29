with source as (
	select 
		*
	from {{ source('zillow_raw', 'zillow_data') }}
)

select 
	*,
	parse_date('%m/%d/%Y', date) as value_date
from source	