with mart_dim_territory as (
    select territoryid
    , territoryname
    , countryregioncode
    , regiongroup
    , salesytd
    , saleslastyear
    , costytd
    , costlastyear
    from  {{ ref('stg_territory') }}
)
select * from mart_dim_territory
