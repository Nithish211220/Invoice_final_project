select
  cast(invoiceid as string) as invoice_id,
  cast(userid as string) as user_id,
  invoicedate,
  currency,
  invoiceamount,
  productname
from {{ source('snowflake_source', 'INVOICES') }}