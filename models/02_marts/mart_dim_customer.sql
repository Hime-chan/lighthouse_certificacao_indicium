select p.personid as customerid 
	, p.persontype
	, p.completename
	, e.emailaddress 
	, ph.phones
	, pj.job
	, pj.storename
	, p.title 
	, p.firstname 
	, p.middlename 
	, p.lastname 
	, p.suffix 
	, p.emailpromotion
from {{ ref('stg_personperson') }} p
left join {{ ref('stg_personemail') }} e 
on e.personid =p.personid 
left join {{ ref('stg_personphone') }} ph
on ph.personid = p.personid
left join {{ ref('stg_businessperson') }} pj
on pj.personid = p.personid 
where p.isCustomer