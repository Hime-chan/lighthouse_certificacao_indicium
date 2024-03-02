with stg_product as (
	select cast(productid as int) as productid
	, P.name as completename
	, case when coalesce(PM.name, '') = '' then translate(P.name, '0123456789', '')
      else PM.name
      end as productname
	, cast(P.makeflag as int) as makeflag	 			-- feito(1), manufaturado(0)
	, cast(coalesce(P.finishedgoodsflag,true) as int) as finishedgoodsflag 	--não é mais vendido(0)
	, cast(coalesce(P.safetystocklevel,0) as int) as safetystocklevel 		--qtd mínima inventório
	, cast(coalesce(P.reorderpoint,0) as int) as reorderpoint 			--alerta de falta de estoque (menor que o safety)
	, cast(P.standardcost as decimal) as standardcost			--custo padrão do produto
	, cast(P.listprice as decimal) as listprice				--preço de venda
	, coalesce(P.size, '-') as productsize	--tamanho
	, cast(coalesce(P.weight,0) as decimal) as productweight				--peso
	, cast(coalesce(P.daystomanufacture,0) as int) as daystomanufacture		--dias pra manufaturar
	, coalesce(P.productline,'-') as productline			--R:road, M:mountain, T:touring,S:standard
	, coalesce(P.class,'-') as productclass --High, Medium, Low
	, coalesce(P.style,'Universal') as productstyle					--Women, Man, Universal
	, P.productsubcategoryid as productcategoryid
	from {{ source('adw', 'product') }} P
	left join {{ source('adw', 'productmodel') }} PM
	on PM.productmodelid=P.productmodelid
)
select * from stg_product