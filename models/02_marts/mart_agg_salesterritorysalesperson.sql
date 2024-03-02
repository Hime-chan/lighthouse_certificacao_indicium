with  salesbyterritorybysalesperson as (
    select dt.territoryid
        , dsp.salespersonid
        , count(fso.salesorderid) as orderquantity
        , sum(fso.totalproductquantity) as totalproductquantity
        , sum(fso.productstotal) as totalpriceproducts
        , sum(fso.completetotal) as totalpricecomplete
        , max(fso.orderdate) as lastorder
        , min(fso.orderdate) as firstorder
        , count(distinct(fso.customerid)) as customerquantity
    from {{ ref('mart_fact_salesorder') }} fso
    inner join {{ ref('mart_dim_territory') }} dt
        on fso.territoryid = dt.territoryid
    inner join {{ ref('mart_dim_salesperson') }} dsp
        on dsp.salespersonid = fso.salespersonid
    group by 
        dt.territoryid
        , dsp.salespersonid     
)
, mart_agg_salesterritorysalesperson as (
    select fso.territoryid
        , fso.salespersonid
        , fso.orderquantity
        , fso.totalproductquantity
        , fso.totalpriceproducts
        , fso.totalpricecomplete
        , fso.lastorder
        , fso.firstorder
        , fso.customerquantity
        , dt.territoryname
        , dt.countryregioncode
        , dt.regiongroup
        , dt.salesytd
        , dt.saleslastyear
        , dt.costytd
        , dt.costlastyear
        , dsp.salesquota
        , dsp.bonusIfquota
        , dsp.comissionpersalepercent
        , dsp.salesvaluelastyear
        , dsp.salesvalueacurrentyear
    from salesbyterritorybysalesperson fso
     inner join {{ ref('mart_dim_territory') }} dt
        on fso.territoryid = dt.territoryid
    inner join {{ ref('mart_dim_salesperson') }} dsp
        on dsp.salespersonid = fso.salespersonid
)
select * from mart_agg_salesterritorysalesperson