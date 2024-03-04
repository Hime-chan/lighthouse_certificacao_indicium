with categoryGroup as (
    select p.productid
        , string_agg(distinct(pc.category),', ') as categories
        , string_agg(distinct(pc.categoryGroup),', ') as categoriesgroups
    from {{ref('stg_product')}} p
    left join {{ ref('stg_productcategory') }} pc
        on pc.productcategoryid=p.productcategoryid
    group by p.productid    
)
, mart_DS_productstoresales as (
    select sod.salesorderdetailid as productsalesId
        , p.productid
        , p.completename as productcompletename
        , p.productname
        , p.makeflag as productmakeflag
        , p.finishedgoodsflag as productfinishedgoodsflag
        , p.safetystocklevel as productsafetystocklevel
        , p.reorderpoint as productreorderpoint
        , p.standardcost as productstandardcost
        , p.listprice as productlistprice
        , p.productsize
        , p.productweight
        , p.daystomanufacture as productdaystomanufacture
        , p.productline
        , p.productclass
        , p.productstyle
        , sod.Orderqty as productquantity
        , sod.productunitprice
        , soh.orderdate
        , st.storeid
        , st.storename
        , st.AnnualSales
        , st.AnnualRevenue
        , st.BankName
        , st.BusinessType
        , st.YearOpened
        , st.Specialty
        , st.SquareFeet
        , st.Brands
        , st.Internet
        , st.NumberEmployees
        , te.territoryname
        , te.countryregioncode as territorycountryregioncode
        , te.regiongroup as territoryregiongroup
        , te.salesytd as territorysalesytd
        , te.saleslastyear as territorysaleslastyear
        , te.costytd as territorycostytd
        , te.costlastyear as territorycostlastyear    
        , store_a.spatiallocation as store_spatiallocation
        , store_a.locationname as store_locationname
        , soh.salespersonid
        , sp.comissionpersalepercent as salespersoncomission
        , sp.bonusIfquota as salespersonbonusifquota
        , (sp.salesvaluelastyear>sp.salesquota) as salespersonachievequota
        , soh.productstotal
        , soh.completetotal
        , pc.categoriesgroups
        , pc.categories
    from {{ ref('stg_salesorderdetail') }} sod
    left join  {{ ref('stg_salesorderheader') }} soh 
        on sod.salesorderid = soh.salesorderid
    left join {{ref('stg_product')}} p
        on p.productid=sod.productid
    left join categoryGroup pc
        on pc.productid=p.productid
    left join {{ ref('stg_store') }} st
        on st.storeid=soh.storeid
    left join {{ ref('stg_territory') }} te
        on te.territoryid=soh.territoryid
    left join {{ ref('stg_address') }} store_a
        on store_a.addressid=st.addressid
    left join {{ ref('stg_salesperson') }} sp
        on sp.salespersonid=soh.salespersonid
)
select * from mart_DS_productstoresales