SELECT
    opa.order_id,
    opa.product_id,
    opa.add_to_cart_order,
    opa.reordered,
    opa.is_reordered,
    o.user_id,
    o.eval_set,
    o.order_number,
    o.order_day_of_week,
    o.order_day_name,
    o.order_hour_of_the_day,
    o.days_since_prior_order 
FROM {{ ref('int_order_products_all') }} opa
LEFT JOIN {{ ref('stg_orders') }} o on opa.order_id = o.order_id
    
