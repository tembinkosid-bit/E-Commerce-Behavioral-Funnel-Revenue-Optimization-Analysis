# 🛒 E-Commerce Behavioral Funnel & Revenue Optimization Analysis

<img width="978" height="545" alt="dashboard_overview" src="https://github.com/user-attachments/assets/bc60fa48-e9dc-440a-bdab-6489025f979b" />


## 📌 Project Overview

This project analyzes user behavior across a large-scale e-commerce platform to identify **conversion bottlenecks, revenue drivers, and growth opportunities**.

Using a combination of **Python, SQL, and Power BI**, the analysis transforms raw event-level data into actionable business insights aligned with real-world analytics practices used by companies like Amazon and Shopify.

---

## 🎯 Business Problem

Despite high user activity and product views, the platform experiences relatively low conversion rates.

The key objective of this project is to answer:

* Where do users drop off in the purchase journey?
* Which products and categories drive revenue?
* How can the platform increase conversions and recover lost revenue?

---

## 🧱 Data Pipeline Architecture

```
Raw Event Data → Python (Cleaning & Validation)
              → SQL (Data Modeling & Aggregation)
              → Power BI (Visualization & Insights)
```

---

## 🗂️ Data Model

The project is built on three primary analytical tables:

### 1. `daily_metrics`

Aggregated daily platform performance

* total_views
* total_carts
* total_purchases
* revenue

---

### 2. `product_fact`

Product and category-level performance

* product_id
* category_id
* brand
* avg_price
* total_views
* total_carts
* total_purchases
* revenue

---

### 3. `session_fact`

Session-level user behavior

* user_session
* user_id
* total_views
* total_carts
* total_purchases
* revenue
* session_duration

---

### 4. `session_classification` *(Derived Table)*

Behavior segmentation

* Browsing
* Cart Abandonment
* Converting

---

## 🔍 Key Analyses Performed

### 1. Funnel Conversion Analysis

* View → Cart → Purchase funnel
* Conversion rates at each stage
* Identification of major drop-off points

---

### 2. Session Behavior Analysis

Sessions were classified into:

* Browsing Sessions (~88%)
* Cart Abandonment Sessions (~6%)
* Converting Sessions (~6%)

This revealed that most users explore but do not proceed to purchase.

---

### 3. Product & Category Performance

* Top-performing products by revenue
* Revenue contribution by category
* Identification of high-traffic, low-conversion categories

---

### 4. Revenue Concentration

* Analysis of revenue distribution across products
* Identification of Pareto (80/20) patterns
* Highlighting dependency on top-performing products

---

### 5. Cart Abandonment Analysis

* Quantified high-intent users who failed to convert
* Estimated recoverable revenue opportunities

---

## 📊 Power BI Dashboard

The Power BI dashboard is structured into three main views:

### 📈 Platform Overview

* Revenue trends
* Traffic vs purchases
* Funnel conversion visualization

### 🏷️ Product & Category Insights

* Top products by revenue
* Category performance
* Revenue vs engagement analysis

### 👤 User Behavior

* Session type distribution
* Engagement metrics
* Cart abandonment patterns

---

## 💡 Key Insights

* The platform is **traffic-heavy but conversion-light**
* Majority of users remain in **browsing stage (~88%)**
* Conversion is strong once purchase intent is established
* Significant revenue is lost through **cart abandonment**
* Revenue is concentrated among a small set of products

---

## 🚀 Business Recommendations

### 1. Improve Product Discovery

* Enhance search and recommendation systems
* Promote trending and best-selling items

### 2. Recover Cart Abandonment

* Implement reminder emails and targeted discounts
* Simplify checkout experience

### 3. Optimize High-Traffic Categories

* Improve pricing, descriptions, and product trust signals

### 4. Prioritize Top Products

* Ensure availability and visibility of high-revenue items

### 5. Enhance Product Pages

* Add reviews, ratings, and high-quality visuals
* Improve product information clarity

---

## 🛠️ Tools & Technologies

* **Python** — Data cleaning and validation
* **SQL** — Data modeling and analytical queries
* **Power BI** — Data visualization and dashboarding

---

## 📁 Repository Structure

```
ecommerce-analytics/
│
├── data/
│   ├── raw/              
│   └── processed/
│
├── sql/
│   ├── 01_dtype_conversions.sql
│   ├── 02_data_cleaning_and_transformations.sql
│   ├── 03_session_fact_table.sql
│   ├── 04_session_classification.sql
│   
│
├── powerbi/
│   └── ecommerce_dashboard.pbix
│
├── python/
│   └── ecommerce_dataset.ipynb
│
├── images/              
│   └── dashboard_preview.png
│
├── README.md

```

---

## 📎 Portfolio Links

* GitHub Portfolio: https://github.com/tembinkosid-bit/Data-Analytics-Portfolio
* LinkedIn: https://www.linkedin.com/in/tembinkosi-vikani-dube

---

## 🧠 Final Note

This project demonstrates how raw behavioral data can be transformed into **strategic business insights**.

It reflects real-world analytics workflows where data is not just analyzed, but used to **drive decisions, optimize performance, and unlock revenue growth**.
