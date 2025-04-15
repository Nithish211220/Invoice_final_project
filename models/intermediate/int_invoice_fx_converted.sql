
with joined as (
  select
    inv.invoice_id,
    inv.invoicedate,
    date_trunc('month', cast(inv.invoicedate as date)) as billing_month,
    inv.user_id,
    usr.firstname,
    usr.lastname,
    usr.city,
    usr.country,
    inv.productname,
    inv.invoiceamount,

    fx.reportingtransfxrate,
    fx.reportinglocalfxrate,
    fx.budgettransfxrate,
    fx.budgetlocalfxrate

  from {{ ref('stg_invoices') }} inv
  left join {{ ref('stg_users') }} usr on inv.user_id = usr.user_id
  left join {{ ref('stg_invoice_reporting') }} fx on inv.invoice_id = fx.invoice_id
)

select
  *,
  -- Reporting INR Conversion
  invoiceamount * (reportingtransfxrate / reportinglocalfxrate) as reporting_local,
  -- Reporting EUR
  (invoiceamount * (reportingtransfxrate / reportinglocalfxrate)) * budgetlocalfxrate as reporting_eur,

  -- Budget INR
  invoiceamount * (budgettransfxrate / budgetlocalfxrate) as budget_local,
  -- Budget EUR
  (invoiceamount * (budgettransfxrate / budgetlocalfxrate)) * budgetlocalfxrate as budget_eur
from joined
