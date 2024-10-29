{% snapshot test_record_snapshot %}

	{{ config(
		updated_at='updated',
		invalidate_hard_deletes=True
		) 
	}}
	
	select * from {{ ref('test_seed_record') }}

{% endsnapshot %}