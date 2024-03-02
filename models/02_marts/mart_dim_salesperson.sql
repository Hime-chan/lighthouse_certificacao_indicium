with mart_dim_salesperson as (
    select salespersonid
    , salesquota
    , bonusIfquota
    , comissionpersalepercent
    , salesvaluelastyear
    , salesvalueacurrentyear
    from {{ ref('stg_salesperson') }}
)
select * from mart_dim_salesperson --vendedor