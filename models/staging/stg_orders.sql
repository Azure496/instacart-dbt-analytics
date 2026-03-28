SELECT
    order_id,
    user_id,
    eval_set,
    order_number,
    order_dow AS order_day_of_week,
    CASE
        order_dow
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS order_day_name,
    order_hour_of_the_day,
    days_since_prior_order
FROM
    {{ source(
        'instacart_raw',
        'orders'
    ) }}
