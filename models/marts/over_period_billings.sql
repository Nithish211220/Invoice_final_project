with monthly_data as (
  select
    billing_month,
    sum(reporting_eur) as total_reporting_eur,
    sum(budget_eur) as total_budget_eur
  from {{ ref('int_invoice_fx_converted') }}
  group by 1
),

rolling_calculations as (
  select
    billing_month,
    total_reporting_eur,
    total_budget_eur,
    
    total_reporting_eur as lm_reporting_eur,
    
    
    sum(total_reporting_eur) over (
      order by billing_month 
      rows between 2 preceding and current row
    ) as l3m_reporting_eur,
    
    
    sum(total_reporting_eur) over (
      order by billing_month 
      rows between 11 preceding and current row
    ) as ltm_reporting_eur,
    
    
    -- 3-month moving average
    avg(total_reporting_eur) over (
      order by billing_month 
      rows between 2 preceding and current row
    ) as l3m_avg_reporting_eur,
    
  from monthly_data
)

select
  billing_month,
  total_reporting_eur,
  total_budget_eur,
  lm_reporting_eur,
  l3m_reporting_eur,
  ltm_reporting_eur,
  -- Additional period indicators
  case when row_number() over (order by billing_month) >= 3 
    then 'Yes' else 'No' end as has_full_l3m,
  case when row_number() over (order by billing_month) >= 12 
    then 'Yes' else 'No' end as has_full_ltm
from rolling_calculations
order by billing_month