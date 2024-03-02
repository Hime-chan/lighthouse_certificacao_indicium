with stg_salesperson as (
    select cast(sp.businessentityid as int) as salespersonid
    , cast(coalesce(sp.salesquota,0) as decimal) as salesquota
    , cast(sp.bonus as decimal) as bonusIfquota
    , cast(sp.commissionpct as decimal) as comissionpersalepercent
    , cast(sp.saleslastyear as decimal) as salesvaluelastyear
    , cast(sp.salesytd as decimal) as salesvalueacurrentyear
    from {{ source('adw', 'salesperson') }} sp
)
select * from stg_salesperson --vendedor