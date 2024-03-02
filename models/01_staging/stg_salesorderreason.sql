with stg_salesorderreason as (
    select cast(sr.salesorderid as int) as salesorderid
    , string_agg(distinct(s.name),',') as reasonsnames
    , string_agg(distinct(s.reasontype),',') as reasonstypes
    from {{ source('adw', 'salesreason') }} s
    inner join {{source('adw', 'salesorderheadersalesreason')}} sr
    on sr.salesreasonid=s.salesreasonid
    group by salesorderid
)
select * from stg_salesorderreason 