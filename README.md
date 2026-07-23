# 🎬 Maven Movies SQL Business Analysis

## 📌 Project Overview

This project demonstrates how SQL can be used to analyze and understand the operations of a DVD rental business. Using the **Maven Movies** relational database, I explored business data to answer operational, customer, inventory, and management-related questions through SQL queries.

The project focuses on transforming raw transactional data into meaningful business insights using **MySQL**.

---

# 📖 Business Scenario

A new ownership team has acquired **Maven Movies**, a DVD rental company operating multiple physical stores.

As the new analyst responsible for understanding the business, the goal is to explore every aspect of the company's operations before making strategic decisions.

Since there is no existing reporting system available, all business insights must be generated directly from the SQL database.

The analysis covers:

- Store Management
- Inventory Analysis
- Film Categories
- Customer Information
- Customer Value
- Business Advisors & Investors
- Award-winning Actors Coverage

---

# 🎯 Project Objectives

The objective of this project is to use SQL to answer real-world business questions by analyzing relational data.

Main goals include:

- Explore the complete Maven Movies database
- Understand relationships between multiple database tables
- Perform business-focused SQL analysis
- Write optimized SQL queries using joins, aggregations, grouping and conditional logic
- Convert raw business data into decision-making insights

---

# 🗂 Database Information

The Maven Movies database contains multiple interconnected tables representing different parts of the business.

Major entities include:

- Store
- Staff
- Customer
- Inventory
- Film
- Category
- Rental
- Payment
- Address
- City
- Country
- Actor
- Film Actor
- Film Category
- Advisor
- Investor
- Actor Awards

These tables are connected through primary and foreign keys to simulate a real-world business database.

---

# 🛠 SQL Concepts Used

Throughout this project, the following SQL concepts were applied:

- SELECT Statements
- Filtering Data
- INNER JOIN
- LEFT JOIN
- Aggregate Functions
- GROUP BY
- ORDER BY
- CASE Statements
- UNION
- COUNT
- SUM
- AVG
- Business Reporting Queries

---

# 📊 Business Questions & Insights

---

## 1. Store Managers & Store Locations

### Business Question

Retrieve every store manager along with the complete address of each store.

### Tables Used

- Store
- Staff
- Address
- City
- Country

### SQL Skills

- Multiple LEFT JOINs
- Relational Mapping

### Business Insight

Provides complete visibility into store ownership and management structure, making it easier for new business owners to schedule meetings with store managers and understand store locations.

```sql
SELECT 
    staff.first_name AS manager_first_name,
    staff.last_name AS manager_last_name,
    address.address,
    address.district,
    city.city,
    country.country
FROM store
LEFT JOIN staff
    ON store.manager_staff_id = staff.staff_id
LEFT JOIN address
    ON store.address_id = address.address_id
LEFT JOIN city
    ON address.city_id = city.city_id
LEFT JOIN country
    ON city.country_id = country.country_id;
```

---

## 2. Complete Inventory Report

### Business Question

Generate a detailed inventory list including store, inventory ID, film title, rating, rental price and replacement cost.

### Tables Used

- Inventory
- Film

### SQL Skills

- LEFT JOIN
- Data Retrieval

### Business Insight

Helps understand every rentable item owned by the business and estimates replacement expenses if inventory needs to be replenished.

```sql
SELECT
    inventory.store_id,
    inventory.inventory_id,
    film.title,
    film.rating,
    film.rental_rate,
    film.replacement_cost
FROM inventory
LEFT JOIN film
    ON inventory.film_id = film.film_id;
```

---

## 3. Inventory Summary by Rating

### Business Question

Count the number of inventory items available for every film rating at each store.

### SQL Skills

- GROUP BY
- COUNT()

### Business Insight

Shows how inventory is distributed across movie ratings, helping identify whether stores are balanced or overly concentrated in specific audience categories.

```sql
SELECT
    inventory.store_id,
    film.rating,
    COUNT(inventory_id) AS inventory_items
FROM inventory
LEFT JOIN film
    ON inventory.film_id = film.film_id
GROUP BY
    inventory.store_id,
    film.rating;
```

---

## 4. Replacement Cost Analysis by Film Category

### Business Question

Analyze replacement cost by store and film category.

### SQL Skills

- GROUP BY
- SUM()
- AVG()
- Multiple LEFT JOINs

### Business Insight

Measures financial exposure by category, allowing management to estimate replacement costs if a specific genre underperforms.

```sql
SELECT
    store_id,
    category.name AS category,
    COUNT(inventory.inventory_id) AS films,
    AVG(film.replacement_cost) AS avg_replacement_cost,
    SUM(film.replacement_cost) AS total_replacement_cost
FROM inventory
LEFT JOIN film
    ON inventory.film_id = film.film_id
LEFT JOIN film_category
    ON film.film_id = film_category.film_id
LEFT JOIN category
    ON category.category_id = film_category.category_id
GROUP BY
    store_id,
    category.name
ORDER BY
    SUM(film.replacement_cost) DESC;
```

---

## 5. Customer Directory

### Business Question

Retrieve customer details including active status and complete address.

### Tables Used

- Customer
- Address
- City
- Country

### Business Insight

Provides a complete customer directory useful for customer relationship management and operational reporting.

```sql
SELECT
    customer.first_name,
    customer.last_name,
    customer.store_id,
    customer.active,
    address.address,
    city.city,
    country.country
FROM customer
LEFT JOIN address
    ON customer.address_id = address.address_id
LEFT JOIN city
    ON address.city_id = city.city_id
LEFT JOIN country
    ON city.country_id = country.country_id;
```

---

## 6. Customer Lifetime Value Analysis

### Business Question

Identify the highest-value customers based on rentals and total payments.

### SQL Skills

- COUNT()
- SUM()
- GROUP BY
- ORDER BY

### Business Insight

Ranks customers by lifetime value, helping identify loyal customers and supporting retention or reward programs.

```sql
SELECT
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_rentals,
    SUM(payment.amount) AS total_payment_amount
FROM customer
LEFT JOIN rental
    ON customer.customer_id = rental.customer_id
LEFT JOIN payment
    ON rental.rental_id = payment.rental_id
GROUP BY
    customer.first_name,
    customer.last_name
ORDER BY
    SUM(payment.amount) DESC;
```

---

## 7. Advisors & Investors Directory

### Business Question

Combine advisors and investors into a single report.

### SQL Skills

- UNION
- NULL Handling

### Business Insight

Creates a unified stakeholder directory for management and ownership reference.

```sql
SELECT
    'investor' AS type,
    first_name,
    last_name,
    company_name
FROM investor

UNION

SELECT
    'advisor' AS type,
    first_name,
    last_name,
    NULL
FROM advisor;
```

---

## 8. Award-Winning Actor Coverage

### Business Question

Measure how well the business covers actors with one, two or three major awards.

### SQL Skills

- CASE Statement
- GROUP BY
- AVG()

### Business Insight

Evaluates the diversity and prestige of the movie catalog by analyzing award-winning actor representation.

```sql
SELECT
CASE
    WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
    WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony','Oscar, Tony') THEN '2 awards'
    ELSE '1 award'
END AS number_of_awards,

AVG(
CASE
    WHEN actor_award.actor_id IS NULL THEN 0
    ELSE 1
END
) AS pct_w_one_film

FROM actor_award

GROUP BY
CASE
    WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
    WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony','Oscar, Tony') THEN '2 awards'
    ELSE '1 award'
END;
```

---

# 🚀 Skills Demonstrated

- SQL Query Writing
- Relational Database Analysis
- Business Intelligence
- Data Exploration
- Data Aggregation
- Data Modeling Concepts
- Reporting & Analytics
- Business Problem Solving
- MySQL

---

# 📌 Tools Used

- MySQL
- MySQL Workbench
- Maven Movies Database
- GitHub

---

# 📈 Learning Outcomes

Through this project, I strengthened my understanding of:

- Writing complex SQL queries
- Working with relational databases
- Joining multiple tables efficiently
- Building business reports from transactional data
- Converting business requirements into SQL solutions
- Extracting actionable insights for decision-making

---

## ⭐ Repository Highlights

✔ Business-focused SQL analysis  
✔ 8 real-world analytical queries  
✔ Multi-table joins and aggregations  
✔ Practical reporting scenarios  
✔ Beginner-friendly and recruiter-ready SQL project
