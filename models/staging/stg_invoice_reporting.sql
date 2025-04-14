select
  cast(invoiceid as string) as invoice_id,
  reportingtransfxrate,
  reportingmonthyear,
  transcurrencycode,
  budgettransfxrate,
  localcurrency,
  reportinglocalfxrate,
  budgetlocalfxrate
from {{ source('snowflake_source', 'INVOICE_REPORTING_CLEANED_V2') }}