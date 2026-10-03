E-Commerce Sales & Customer Analytics

A data analytics project that analyzes e-commerce sales, customer behavior, product performance, sellers, payments, and reviews using MySQL and Power BI.

📊 Project Overview

This project uses the Brazilian E-Commerce Public Dataset by Olist to perform SQL-based data analysis and build an interactive Power BI dashboard.

The analysis focuses on:

Sales and revenue performance
Customer purchasing behavior
Product and category performance
Seller performance
Payment methods
Customer reviews
Order status
Geographic sales distribution

--> Tools & Technologies
MySQL – Database management and SQL analysis
Power BI – Interactive dashboard and data visualization
DBeaver – Database management and SQL development
Git & GitHub – Version control and project sharing

--> Database Tables
customers
orders
order_items
payments
products
sellers
reviews
geolocation
category_translation

--> SQL Analysis
The project includes analysis of:

Payment method performance
Review score distribution
Top products by revenue
Top product categories by revenue
Average product price by category
Top sellers by revenue
Average item price by seller
Customer order frequency
Top customers by spending
Average customer spending
Overall average order value
Orders by order status
Revenue by customer state

--> Power BI Dashboard
The interactive dashboard provides insights into e-commerce sales and customer behavior.

Key Metrics
Metric	Value
Total Orders	99K
Total Revenue	16.01M
Average Order Value	154.10
Customer Records	99.441K
Dashboard Visualizations
Revenue by Payment Method
Top 10 Sellers by Revenue
Revenue by Product Category
Top 10 Customers by Spending
Reviews by Rating
Average Item Price by Seller
Average Product Price by Category
Monthly Revenue
Top 10 Products by Revenue
Top Customers by Orders
Orders by Order Status
Revenue by Customer State

--> Key Insights
Credit card payments contribute the largest share of payment revenue.
A small group of sellers contributes significantly to overall product revenue.
Product categories show differences in revenue and average selling price.
Customer reviews are predominantly concentrated around higher ratings.
São Paulo (SP) contributes a significant share of customer revenue.
Revenue patterns vary across the months in the dataset.

--> Project Structure
E-Commerce-Sales-Customer-Analytics/
│
├── README.md
│
├── PowerBI/
│   └── E-Commerce_Sales_Customer_Analysis.pbix
│
├── SQL/
│   ├── analysis_queries.sql
│   ├── ecommerce_analytics_category_translation.sql
│   ├── ecommerce_analytics_customers.sql
│   ├── ecommerce_analytics_geolocation.sql
│   ├── ecommerce_analytics_order_items.sql
│   ├── ecommerce_analytics_orders.sql
│   ├── ecommerce_analytics_payments.sql
│   ├── ecommerce_analytics_products.sql
│   ├── ecommerce_analytics_reviews.sql
│   ├── ecommerce_analytics_routines.sql
│   └── ecommerce_analytics_sellers.sql


 How to Use
1. Set up the database

Create a MySQL database named:

CREATE DATABASE ecommerce_analytics;

Import the SQL files from the SQL folder.

2. Perform the analysis

Open SQL/analysis_queries.sql and run the queries using MySQL or DBeaver.

3. Open the Power BI Dashboard

Open:

PowerBI/E-Commerce_Sales_Customer_Analysis.pbix

The dashboard is connected to the MySQL database.

📚 Dataset

This project is based on the Brazilian E-Commerce Public Dataset by Olist, containing information about orders, customers, products, sellers, payments, reviews, and product categories.

🎯 Project Objective

The objective of this project is to transform raw e-commerce data into meaningful business insights using SQL analysis and interactive Power BI visualizations.

👩‍💻 Author

Fiyona Ann Sojan

B.Tech Computer Science & Engineering