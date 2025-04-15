select
  country,

  sum(reporting_local) as total_reporting_local,
  sum(reporting_eur) as total_reporting_eur,
  sum(budget_local) as total_budget_local,
  sum(budget_eur) as total_budget_eur

from {{ ref('int_invoice_fx_converted') }}
group by 1