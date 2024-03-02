with stg_salesorderheader as (
    select date(SOH.orderdate) as orderdate 
    , cast(C.storeid as int) as storeid 
    , cast(SOH.territoryid as int) as territoryid 
    , cast(SOH.salesorderid as int) as salesorderid
    , cast(C.personid as int) as personcustomerid
    , cast(SOH.billtoaddressid as int) as billtoaddressid 
    , cast(SOH.shiptoaddressid as int) as shiptoaddressid  
    , cast(SOH.salespersonid as int) as salespersonid
    , cast(SOH.subtotal as decimal) as productstotal
    , cast(SOH.totaldue as decimal) as completetotal
    from {{ source('adw', 'salesorderheader') }} SOH
    left join {{ source('adw', 'customer') }} C
    on C.customerid = SOH.customerid
)
select * from stg_salesorderheader