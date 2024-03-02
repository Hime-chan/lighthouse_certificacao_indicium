with mart_fact_salesproduct as (
    select salesorderdetailid as salesproductid
        , salesorderid
        , productid
        , orderqty as productquantity
        , productunitprice
    from {{ ref('stg_salesorderdetail') }}
)
select * from mart_fact_salesproduct