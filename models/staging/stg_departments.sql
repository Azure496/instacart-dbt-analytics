SELECT
    department_id,
    department
FROM
    {{ source(
        'instacart_raw',
        'departments'
    ) }}
