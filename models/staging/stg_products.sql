SELECT
    product_id,
    product_name,
    aisle_id,
    department_id
FROM
    {{ source(
        'instacart_raw',
        'products'
    ) }}
