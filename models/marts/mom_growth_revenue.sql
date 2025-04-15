with monthly_revenue as (
  select
    date_trunc('month', to_date(invoicedate, 'YYYY-MM-DD')) as month,
    sum(invoiceamount) as total_revenue
  from {{ ref('stg_invoices') }}
  group by month
),
with_growth as (
  select
    month,
    total_revenue,
    lag(total_revenue) over (order by month) as prev_month_revenue
  from monthly_revenue
)
select
  month,
  total_revenue,
  round(
    (total_revenue - prev_month_revenue), 2
  ) as mom_growth_pct
from with_growth;
