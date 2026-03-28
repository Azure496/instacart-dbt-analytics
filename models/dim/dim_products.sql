SELECT
    p.product_id,
    p.product_name,
    a.aisle_id,
    a.aisle as aisle_name,
    d.department_id,
    d.department as department_name
FROM {{ ref('stg_products') }} p
LEFT JOIN {{ ref('stg_aisles') }} a ON p.aisle_id = a.aisle_id
LEFT JOIN {{ ref('stg_departments') }} d on p.department_id = d.department_id
