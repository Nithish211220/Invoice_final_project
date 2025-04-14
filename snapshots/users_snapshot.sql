{% snapshot users_snapshot %}

{%- set snapshot_config -%}
  {{
    config(
      target_schema='snapshots',
      unique_key='user_id',
      strategy='check',
      check_cols=['city', 'country']
    )
  }}
{%- endset -%}

{{ snapshot_config }}

select * from {{ ref('stg_users') }}

{% endsnapshot %}
