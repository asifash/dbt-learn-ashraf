{{config(
    materialized='view'
)
}}

SELECT
     id as payment_id,
     orderid as order_id,
     paymentmethod as payment_method,
     status,
     (amount/100.00) as amount_dollars,
     created

from 

     {{ source('stripe', 'payment') }}
     
     where status = 'success'