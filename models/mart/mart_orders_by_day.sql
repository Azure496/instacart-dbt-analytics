SELECT
    order_day_of_week,
    order_day_name,
    count(distinct order_id) as total_orders,
    count(*) as total_items,
    round(count(*)::float / count(distinct order_id), 2) as avg_items_per_order,
    round(
        100 * count(distinct order_id)::float / sum(count(distinct order_id)) over (),
        2) as pct_of_total_orders
FROM {{ ref('fct_order_items') }}
GROUP BY
    order_day_of_week,
    order_day_name