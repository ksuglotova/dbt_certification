select 
	*
from {{ source('zillow_raw', 'zillow_regions') }}	