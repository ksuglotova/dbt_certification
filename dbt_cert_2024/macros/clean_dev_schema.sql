{% macro clean_dev_schema(database=target.database, schema=target.schema, days=7, dry_run=True) %}

	{% set get_drop_commands_query %}
		select
		  'DROP ' ||
		  case when table_type = 'VIEW' then 'VIEW' else 'TABLE' end ||
		  ' `' || table_catalog || '.' || table_schema || '.' || table_name || '`;'
		from `region-US`.INFORMATION_SCHEMA.TABLES
		where table_catalog = '{{ database }}'
		  and contains_substr(table_schema, 'dev_')
		  and contains_substr(table_schema, '{{ target.schema }}')
		  and date(creation_time) < current_date - interval {{ days }} day
	{% endset %}
	
	{{ log('\nGenerating drop queries...\n', info=True) }}
	
	{% set drop_queries = run_query(get_drop_commands_query).columns[0].values() %}
	
	{% for drop_query in drop_queries %}
		{% if execute and not dry_run %}
			{{ log('\nDropping object with command: ' ~ drop_query, info=True) }}
			{% do run_query(drop_query) %}
		{% else %}
			{{ log(drop_query, info=True) }}
		{% endif %}
	{% endfor %}
	
{% endmacro %}