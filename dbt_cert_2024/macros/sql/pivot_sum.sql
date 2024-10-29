{% macro pivot_sum(dim_column_name, fact_column_name, value_dict=dict()) %}

  {%- for key, value in value_dict.items() -%}
	sum(case when {{ dim_column_name }} = '{{ key }}' then {{ fact_column_name }} else 0 end) as {{ value }}_sum
	{%- if not loop.last -%}
		,
	{% endif -%}	
  {%- endfor -%}
  
{% endmacro %}