with stg_productcategory as (
	select cast(PS.productsubcategoryid as int) as productcategoryid
	, coalesce(
		nullif(PC.name, ''),
		'Outros'
		) as categoryGroup
	, coalesce(
		nullif(PS.name, ''),
		'Outros'
		) as category
	from {{ source('adw', 'productsubcategory') }} PS 
	left join {{ source('adw', 'productcategory') }} PC
		on PC.productcategoryid =PS.productcategoryid 
)
select * from stg_productcategory