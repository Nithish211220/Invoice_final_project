
--monitor how budget exchange rates change across time.

{% snapshot fx_rate_snapshot %}
{{
    config(
        target_schema='snapshots',
        unique_key='invoice_id',
        strategy='check',
        check_cols=['budgettransfxrate', 'budgetlocalfxrate']
    )
}}

select * from {{ ref('stg_invoice_reporting') }}

{% endsnapshot %}
