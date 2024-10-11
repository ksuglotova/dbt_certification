-- Input: list of strings
-- Output: dict with the keys equal to list items, values equal to the keys in lowercase.

{% macro var_to_lowercase(value_list=[]) %}

	{%- set value_dict = dict() -%}
	
	{%- if value_list|length() != 0 -%}
	
		{%- for value in value_list -%}
			{%- set value_lower = value.lower() -%}
			{%- set _dummy = value_dict.update({ value: value_lower }) -%}
		{%- endfor %}
	
	{%- endif -%}
	
	{{ return(value_dict) }}
	
{% endmacro %}