with stg_address as (
    select cast(a.addressid as int) as addressid
    , a.spatiallocation
    , concat(a.city,', ',s.name,' ',s.countryregioncode) as locationname
    from {{ source('adw', 'address') }} a
    left join {{ source('adw','stateprovince')}} s
    on a.stateprovinceid=s.stateprovinceid
)
select * from stg_address