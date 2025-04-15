select
  to_char(to_date(invoicedate, 'YYYY-MM-DD'), 'YYYY-MM') as year_month,
  count(distinct user_id) as unique_customers
from {{ ref('int_invoice_fx_converted') }}
group by year_month
order by year_month;

