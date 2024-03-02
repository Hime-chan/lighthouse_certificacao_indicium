with productquantity as (
    select s.salesorderid
        , sum(s.orderqty) as quantity
    from {{ ref('stg_salesorderdetail') }} s
    group by s.salesorderid
)
, mart_fact_salesorder as (
    select soh.salesorderid as salesorderid
        , orderdate
        , storeid
        , salespersonid 
        , territoryid 
        , bill_a.spatiallocation as bill_spatiallocation
        , bill_a.locationname as bill_locationname
        , ship_a.spatiallocation as ship_spatiallocation
        , ship_a.locationname as ship_locationname
        , productstotal
        , completetotal
        , sr.reasonsnames as reasons
        , sr.reasonstypes as reasonstypes
        , PQ.quantity as totalproductquantity
        , personcustomerid as customerid
    from {{ ref('stg_salesorderheader') }} soh
    left join {{ ref('stg_address') }} bill_a
        on bill_a.addressid=soh.billtoaddressid
    left join {{ ref('stg_address') }} ship_a
        on ship_a.addressid=soh.shiptoaddressid
    left join {{ ref('stg_salesorderreason') }} sr 
        on sr.salesorderid = soh.salesorderid    
    left join productquantity pq 
        on pq.salesorderid = soh.salesorderid    
)
select * from mart_fact_salesorder
