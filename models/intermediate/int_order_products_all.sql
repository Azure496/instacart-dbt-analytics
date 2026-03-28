SELECT 
    order_id,
    product_id,
    add_to_cart_order,
    reordered,
    is_reordered,
    'prior' as order_products_set
FROM {{ ref('stg_order_products_prior')}}

union all

SELECT 
    order_id,
    product_id,
    add_to_cart_order,
    reordered,
    is_reordered,
    'train' as order_products_set
FROM {{ ref('stg_order_products_train') }}