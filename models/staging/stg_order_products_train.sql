SELECT
    order_id,
    product_id,
    add_to_cart_order,
    reordered,
    CASE
        WHEN reordered = 1 THEN TRUE
        WHEN reordered = 0 THEN FALSE
    END AS is_reordered
FROM
    {{ source(
        'instacart_raw',
        'order_products_train'
    ) }}
