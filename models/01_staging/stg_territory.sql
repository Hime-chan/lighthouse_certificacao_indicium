with stg_territory as (
    select cast(territoryid as int) as territoryid
        , name as territoryname
        , countryregioncode
        , "Group" as regiongroup
        , cast(salesytd as decimal) as salesytd
        , cast(saleslastyear as decimal) as saleslastyear
        , cast(costytd as decimal) as costytd
        , cast(costlastyear as decimal) as costlastyear
    from {{ source('adw','salesterritory')}} ST
)
select * from stg_territory    