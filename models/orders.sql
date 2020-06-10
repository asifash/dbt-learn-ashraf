{{config(
    materialized = 'view'
)}}


with payments as (
    select * from {{ref('stg_payments')}}
),

orders as (
    select * from {{ref('stg_orders')}}
),

order_payments as (
    select order_id,
    sum(amount_dollars) as amount
    from payments
    group by 1
),

final as (

select 
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        order_payments.amount
    from orders orders 
    left join order_payments  order_payments
    on orders.order_id = order_payments.order_id
 )

select * from final