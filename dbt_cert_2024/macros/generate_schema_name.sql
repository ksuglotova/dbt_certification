# Macro adds target.name prefix to the generated schema name for all lower environments,
# assuming that 'prod' is the highest environment.
# All environments are in the same BigQuery project, so the separation of concerns is on the schema level.

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
	{%- if custom_schema_name is none and target.name != 'prod' -%}

        {{ target.name }}_{{ default_schema }}

    {%- elif custom_schema_name is none and target.name == 'prod' -%}
	
		{{ default_schema }}	
	
	{%- elif target.name != 'prod' -%}
        
        {{ target.name }}_{{ default_schema }}_{{ custom_schema_name | trim }}

    {%- else -%}

        {{ default_schema }}_{{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}