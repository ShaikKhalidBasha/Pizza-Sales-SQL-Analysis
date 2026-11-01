
-- Pizza Sales SQL Analysis (MySQL)
-- Tables: orders, order_details, pizzas, pizza_types

USE pizza_sales;


-- 1. Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- 2. Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;

-- 3. Identify the highest-priced pizza.
SELECT pizza_types.name, pizzas.price
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- 4. Identify the most common pizza size ordered (counted by order lines).
SELECT pizzas.size, COUNT(order_details.order_details_id) AS order_count
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT pizza_types.name, SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 6. Find the total quantity of each pizza category ordered.
SELECT pizza_types.category, SUM(order_details.quantity) AS total_quantity
FROM pizzas
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;

-- 7. Determine the distribution of orders by hour of the day.
SELECT HOUR(`time`) AS order_hour, COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- 8. Find the category-wise distribution of pizzas (number of menu items per category).
SELECT category, COUNT(name) AS pizza_count
FROM pizza_types
GROUP BY category;

-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(daily_quantity), 0) AS avg_pizzas_per_day
FROM (
    SELECT orders.`date`, SUM(order_details.quantity) AS daily_quantity
    FROM orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.`date`
) AS daily_totals;

-- 10. Determine the top 3 pizza types based on revenue.
SELECT pizza_types.name,
       ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue
FROM pizzas
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

-- 11. Calculate the percentage contribution of each pizza category to total revenue.
SELECT pizza_types.category,
       ROUND(
           SUM(order_details.quantity * pizzas.price) /
           (SELECT SUM(order_details.quantity * pizzas.price)
            FROM order_details
            JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
       2) AS revenue_percentage
FROM pizzas
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue_percentage DESC;

-- 12. Analyze the cumulative revenue generated over time.
SELECT `date`,
       ROUND(SUM(revenue) OVER (ORDER BY `date`), 2) AS cumulative_revenue
FROM (
    SELECT orders.`date`,
           SUM(order_details.quantity * pizzas.price) AS revenue
    FROM order_details
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    JOIN orders ON orders.order_id = order_details.order_id
    GROUP BY orders.`date`
) AS sales;

-- 13. Determine the top 3 pizza types based on revenue for each pizza category.
SELECT category, name, revenue
FROM (
    SELECT category, name, revenue,
           RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn
    FROM (
        SELECT pizza_types.category,
               pizza_types.name,
               ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue
        FROM pizzas
        JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
        GROUP BY pizza_types.category, pizza_types.name
    ) AS category_revenue
) AS ranked
WHERE rn <= 3;