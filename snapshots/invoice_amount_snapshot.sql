

--Flags when someone changes an invoice amount after the invoice is issued.Helps detect anomalies, fraud, or accounting corrections

{% snapshot invoice_amount_snapshot %}
{{
    config(
        target_schema='snapshots',
        unique_key='invoice_id',
        strategy='check',
        check_cols=['invoiceamount']
    )
}}

select * from {{ ref('stg_invoices') }}

{% endsnapshot %}
