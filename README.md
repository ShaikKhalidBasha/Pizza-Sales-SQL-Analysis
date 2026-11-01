🍕 Pizza Sales Analysis using SQL

📌 Project Overview
This project analyzes pizza sales data to understand ordering patterns, product performance, and revenue trends. Using MySQL, the analysis helps a pizza business understand which pizzas, categories, and time slots drive the most sales.

🎯 Objectives
- Analyze total orders, revenue, and average daily sales
- Identify top-selling and highest-revenue pizzas
- Understand peak ordering hours
- Compare performance across pizza categories and sizes
- Provide actionable insights for business decision-making

🛠️ Technologies Used
- MySQL
- MySQL Workbench
- SQL concepts: Joins, GROUP BY, Aggregate Functions, Subqueries, Window Functions (SUM OVER, RANK)

🗂️ Dataset
- Maven Analytics "Pizza Place Sales" dataset
- 4 relational tables: `orders`, `order_details`, `pizzas`, `pizza_types`
- 21,350 orders and 48,620 order line items
- 32 pizza types and 96 pizza variations (size and price)

📊 Key Analysis Performed
- Database design and importing CSV files into MySQL
- Joined 4 tables to combine order, price, and product data
- Total orders, revenue, and average pizzas sold per day
- Top 5 pizzas by quantity and top 3 by revenue
- Hour-wise distribution of orders
- Category-wise quantity and revenue contribution (%)
- Cumulative revenue over time
- Top 3 pizzas by revenue within each category

📌 Key Metrics
 Metric - Value
 Total Orders - 21,350 
 Total Revenue - from Q2
 Pizzas Sold - SUM of quantity 
 Average Pizzas per Day - from Q9
 Average Order Value - revenue ÷ orders

📈 Sample Insights
- Highest-priced pizza: from Q3
- Most common pizza size: from Q4
- Best-selling pizza by quantity: from Q5
- Top revenue-generating pizza: from Q10
- Peak ordering hours: from Q7
- Category contributing the most revenue: from Q11

✅ Recommendations
- Staff the kitchen and delivery team heavily during peak hours - from Q7
- Keep the top-selling pizzas fully stocked, since they drive the most volume
- Promote high-revenue pizzas in the top category with combo offers
- Review low-performing pizzas for menu changes or discounts

▶️ How to Run
1. Create the `pizza_sales` database and tables in MySQL
2. Import the 4 CSV files from the `data` folder
3. Open `project_sql.sql` and run the queries one by one
├── project_sql.sql    # all 13 queries
└── README.md
```
