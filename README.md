# 🦠 COVID-19 Data Exploration & Advanced SQL Portfolio Project

## 📋 Project Overview
This project performs an extensive exploratory data analysis on global COVID-19 data (`coviddeaths` and `covidvaccinations`) using **MySQL**. It demonstrates advanced SQL querying techniques to uncover insights regarding infection rates, mortality percentages, continent-level impacts, and rolling vaccination progress worldwide.

---

## 🛠️ Tech Stack & SQL Concepts Used
* **Database Management System:** MySQL
* **Advanced SQL Features:**
  * **Aggregate Functions & Grouping:** `SUM()`, `MAX()`, `GROUP BY`
  * **Data Type Conversion:** `CAST(... AS SIGNED)`, `NULLIF`
  * **Window Functions:** `SUM() OVER (PARTITION BY ... ORDER BY ...)`
  * **Advanced Data Structures:** Common Table Expressions (**CTEs**), **Temporary Tables**, and **Views** for data visualization preparation.

---

## 🔍 Key Business & Epidemiological Questions Explored

1. **Death Percentage by Country:** Analyzes the likelihood of dying if you contract COVID-19 in specific regions (e.g., matching '%state%').
2. **Infection Rate vs. Population:** Evaluates what percentage of a country's total population contracted the virus.
3. **Peak Infection & Mortality Rankings:** Identifies countries and continents with the highest infection rates and absolute death counts per population.
4. **Global Aggregations:** Computes daily global totals for new cases, total deaths, and worldwide death percentages over time.
5. **Rolling Vaccination Progress:** Tracks cumulative vaccination figures per location using partitioning and window functions.

---

## 📁 File Structure
* [`CovidData.sql`](./CovidData.sql) — Contains the full end-to-end MySQL script, ranging from initial exploratory queries to CTEs, Temporary Tables, and View creations.

---

## 🚀 How to Run the Script
1. Clone or download this repository.
2. Import the raw datasets (`coviddeaths` and `covidvaccinations`) into your local MySQL environment under a schema named `portfoliproject`.
3. Execute the script sections sequentially inside your MySQL workbench to review query outputs, temporary tables, and stored views.
