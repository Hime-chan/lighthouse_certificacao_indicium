with mart_dim_store as (
    select storeid
    , storename
    , AnnualSales
    , AnnualRevenue
    , BankName
    , BusinessType
    , YearOpened
    , Speciality
    , SquareFeet
    , Brands
    , Internet
    , NumberEmployees
    from  {{ ref('stg_store') }}
)
select * from mart_dim_store
