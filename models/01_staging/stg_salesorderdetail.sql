with stg_salesorderdetail as (
    select cast(SOD.salesorderid as int) as salesorderid
        , cast(SOD.salesorderdetailid as int) as salesorderdetailid
        , cast(SOD.productID as int) as productID 
        , cast(SOD.Orderqty as int) as Orderqty
        , cast(SOD.unitprice - SOD.unitpriceDiscount as decimal) as productunitprice 
    from {{ source('adw', 'salesorderdetail') }} SOD
)
select * from stg_salesorderdetail