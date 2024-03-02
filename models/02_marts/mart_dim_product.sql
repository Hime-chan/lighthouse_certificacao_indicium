with categoryGroup as (
    select p.productid
        , string_agg(distinct(pc.category),', ') as categories
        , string_agg(distinct(pc.categoryGroup),', ') as categoriesgroups
    from {{ref('stg_product')}} p
    left join {{ ref('stg_productcategory') }} pc
        on pc.productcategoryid=p.productcategoryid
    group by p.productid    
)
, mart_dim_product as (
    select p.productid
    , p.completename
    , p.productname
    , p.makeflag
    , p.finishedgoodsflag
    , p.safetystocklevel
    , p.reorderpoint
    , p.standardcost
    , p.listprice
    , p.productsize
    , p.productweight
    , p.daystomanufacture
    , p.productline
    , p.productclass
    , p.productstyle
    , pc.categoriesgroups
    , pc.categories
from {{ ref('stg_product') }} p
left join categoryGroup pc
    on pc.productid=p.productid
)
select * from mart_dim_product