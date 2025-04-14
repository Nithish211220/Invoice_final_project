select
  cast(userid as string) as user_id,
  firstname,
  lastname,
  email,
  postcode,
  companyname,
  city,
  state,
  country,
  marketingemailsoptin,
  clientgroup,
  userstatus,
  parenttype,
  subcategory,
  phtype,
  brand
from {{ source('snowflake_source', 'USERS') }}