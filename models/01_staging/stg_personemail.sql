with stg_personemail as (
    select 
        cast(e.businessentityid as INT) as personid,
        cast(e.emailaddress as STRING) as emailaddress
    from {{ source('adw', 'emailaddress') }} e
)

select * from stg_personemail
