# 🎬🛒 OTT vs Shopping Behaviour in India — SQL Analysis

![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-blue)
![SQL](https://img.shields.io/badge/Language-SQL-orange)
![Status](https://img.shields.io/badge/Status-Completed-green)

## 📌 Project Overview

This project analyzes whether OTT viewing habits correlate with 
e-commerce shopping behaviour across Indian cities using SQL.

The core business question:
> *"Can what a person watches on OTT predict what they buy online?"*

This is a real problem companies like **Amazon** (which owns both 
Prime Video and Amazon Shopping) actively work on for targeted 
marketing and product recommendations.

---

## 📂 Dataset

| Table | Rows | Description |

| `ott_views` | 10,000 | User viewing data across Netflix, Prime Video, Hotstar, SonyLIV, Zee5 |
| `ecom_orders` | 10,000 | E-commerce orders across 10 Indian cities |

### ott_views columns:
`view_id, user_id, age, gender, city, state, platform, genre,`
`watch_minutes, rating, device, view_date`

### ecom_orders columns:
`order_id, user_id, age, gender, city, state, category, product,`
`quantity, unit_price, discount_pct, final_price, total_amount,`
`payment_method, order_date, rating`

---

## 🛠️ Tools Used
- **Database:** PostgreSQL 18
- **GUI:** pgAdmin
- **Language:** SQL

---

## 📊 Analysis — 13 Business Questions

### 🟢 Easy
| # | Question | Concepts |

| 1 | Total views per platform | COUNT, GROUP BY |
| 2 | Genre with highest avg watch time | AVG, ROUND |
| 3 | City with highest total revenue | SUM |
| 4 | Total orders by gender | COUNT |
| 5 | Most used device and avg rating | Multiple aggregations |
| 6 | Top 5 most ordered products | LIMIT |

### 🟡 Medium
| # | Question | Concepts |
|---|---|---|
| 7 | Category revenue % of total | Subquery |
| 8 | Payment method for high value orders | WHERE filter |
| 9 | Users active on both OTT and ecom | JOIN, DISTINCT |
| 10 | Total spend by genre watched | JOIN, GROUP BY |

### 🔴 Advanced
| # | Question | Concepts |
|---|---|---|
| 11 | Rank cities by revenue | RANK() Window Function |
| 12 | Segment orders by value | CASE WHEN |
| 13 | Month-wise revenue trend | TO_CHAR, DATE functions |

---

## 🔑 Key Findings

- 📺 **SonyLIV** leads in total views (2,051) but all platforms are fairly even
- 😱 **Horror** viewers watch the longest (avg 133 mins)
- 🏙️ **Chennai** generates highest revenue (₹35.3L); Delhi ranks last
- 🛒 **Action genre** viewers are the biggest spenders (₹1.42Cr total)
- 🏠 **Home & Kitchen + Electronics** = 50% of all revenue
- 💳 **Debit Card & COD** tie as most popular for high-value orders (>₹5000)
- 📅 Revenue is **consistent year-round** — no strong seasonal trend

---

## 💡 SQL Concepts Covered
```
✅ SELECT, WHERE, GROUP BY, ORDER BY
✅ COUNT, SUM, AVG, ROUND
✅ INNER JOIN across two tables
✅ Subqueries
✅ CASE WHEN (customer segmentation)
✅ RANK() Window Function
✅ CTE — WITH clause
✅ DATE functions — TO_CHAR
✅ DISTINCT
✅ LIMIT
```

---

## 🚀 How to Run

1. Install **PostgreSQL** and **pgAdmin**
2. Create a new database (e.g. `project_db`)
3. Run the CREATE TABLE statements from `queries.sql`
4. Import `ott_views.csv` and `ecom_orders.csv`
5. Execute queries from `queries.sql`

---

## 📁 Repository Structure
```
📁 ott-ecommerce-sql-analysis/
   📄 README.md          — project documentation
   📄 queries.sql        — all 13 analysis queries with insights
   📄 ott_views.csv      — OTT viewing dataset
   📄 ecom_orders.csv    — e-commerce orders dataset
```

---

## 👤 Author
Nithya Kattimani  
