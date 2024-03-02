with stg_personphone as (
	select cast(businessentityid as int) as personid 
		, array_to_string(array_agg(distinct phonenumber), ', ') as phones
	from {{ source('adw', 'personphone') }}
	group by businessentityid 
)
select * from stg_personphone
