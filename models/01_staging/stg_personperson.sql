with stg_personperson as (
	select cast(p.businessentityid as int) as personid
		, case when p.persontype='IN' then 'Pessoa física' else 'Pessoa jurídica' end as persontype
		, concat(
			p.title 
			, ' '
			, case when namestyle then lastname else firstname end
			, ' '
			, case when MiddleName is not null then concat(left(middlename,1),'. ') end
			, case when namestyle then firstname else lastname end
			, ' '
			, p.suffix 
		) as completename
		, p.title 
		, p.firstname 
		, p.middlename 
		, p.lastname 
		, p.suffix 
		, cast(p.emailpromotion as int) as emailpromotion
		, cast(c.customerid is not null as bool) as isCustomer 
	from {{ source('adw', 'person') }} p
	left join {{ source('adw', 'customer')}} c
	on c.customerid = p.businessentityid
)
select * from stg_personperson
