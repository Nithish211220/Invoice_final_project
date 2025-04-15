
--identify high-value customers.

select
  user_id,
  firstname || ' ' || lastname as customer_name,
  round(sum(invoiceamount) / count(*), 2) as avg_revenue_per_invoice
from {{ ref('int_invoice_fx_converted') }}
group by 1,2
order by avg_revenue_per_invoice desc;
