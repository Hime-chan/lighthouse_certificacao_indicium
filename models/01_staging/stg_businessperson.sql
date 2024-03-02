with stg_businessperson as (
	select cast(bec.personid as int) as personid
		, ct.name as job
		, s.name as storename
	from {{ source('adw', 'businessentitycontact') }} bec
	left join {{ source('adw', 'contacttype') }} ct 
		on ct.contacttypeid=bec.contacttypeid 
	left join {{ source('adw', 'store') }} s
		on s.businessentityid = bec.businessentityid 
	order by bec.personid
) 
select * from stg_businessperson