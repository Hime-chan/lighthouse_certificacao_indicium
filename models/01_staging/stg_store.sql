with stg_store as (
    select coalesce(
        nullif(S.name,'')
        , 'Online'
    ) as storename
    , CAST(S.businessentityid as INT) as storeid
    , cast(regexp_extract(demographics,r'<AnnualSales>(.+?)</AnnualSales>') as decimal) as AnnualSales
    , cast(regexp_extract(demographics,r'<AnnualRevenue>(.+?)</AnnualRevenue>') as decimal) as AnnualRevenue
    , regexp_extract(demographics,r'<BankName>(.+?)</BankName>') as BankName
    , regexp_extract(demographics,r'<BusinessType>(.+?)</BusinessType>') as BusinessType
    , cast(regexp_extract(demographics,r'<YearOpened>(.+?)</YearOpened>') as int) as YearOpened
    , regexp_extract(demographics,r'<Specialty>(.+?)</Specialty>') as Specialty
    , cast(regexp_extract(demographics,r'<SquareFeet>(.+?)</SquareFeet>') as decimal) as SquareFeet
    , regexp_extract(demographics,r'<Brands>(.+?)</Brands>') as Brands
    , regexp_extract(demographics,r'<Internet>(.+?)</Internet>') as Internet
    , cast(regexp_extract(demographics,r'<NumberEmployees>(.+?)</NumberEmployees>') as int) as NumberEmployees
    from {{ source('adw','store')}} S
)
select * from stg_store    