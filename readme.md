# Telecom Customer Churn Analysis and Prediction

Analysis and prediction of customer churn for a telecom company using **Python, SQL Server, Machine learning, and Power BI**.

The project covers data cleaning, exploratory analysis, SQL-based business analysis, churn prediction, and an interactive dashboard designed to help identify high-risk customer segments and revenue at risk.

[Customer Churn Dashboard](dashboard/dashboardBI.png)

## Project Overview

The dataset contains information on **7,043 telecom customers**, including their demographics, subscribed services, contract type, payment method, tenure, monthly charges, and churn status.

The analysis found that:

* **26.54% of customers churned**
* Churned customers represented approximately **$139K in monthly recurring revenue**
* Nearly **30.5% of total monthly revenue** was associated with customers who had already churned

The objective was to understand:

* Which customer groups are most likely to churn?
* What factors appear to influence customer churn?
* How much revenue is associated with churned customers?
* Can customer churn be predicted using machine learning?
* What actions could help improve customer retention?

## Dataset

The project uses the **IBM Telco Customer Churn dataset**.

Although the dataset represents a fictional telecom company, it contains realistic customer behaviour, pricing relationships, churn patterns etc.

## Project Workflow

### 1. Data Cleaning and Feature Engineering

The dataset was cleaned and prepared using **Python and Pandas**.

One important issue was found in the `TotalCharges` column:

* The column was stored as text instead of a numeric datatype
* It contained 11 blank values that were not detected through standard null checks
* All 11 records belonged to customers with zero months of tenure

Since these customers were new sign-ups who had not yet been billed, their `TotalCharges` values were set to `0` instead of dropping or averaging the records.

Additional features created for analysis included:

* **Tenure bucket:** 0–1 year, 1–2 years, 2–4 years, and 4+ years
* **Churn flag:** Numeric representation of customer churn
* **Service count:** Total number of add-on services subscribed to by each customer

### 2. SQL Business Analysis

More than 10 SQL queries were written in **SQL Server** to answer business-focused questions related to:

* Churn by contract type
* Churn by customer tenure
* Churn by payment method
* Revenue associated with churned customers
* Impact of technical support
* Customer service-bundling behaviour
* Churned and retained customer profiles

### 3. Predictive Modelling

Built Logistic Regression and Random Forest models to predict churn. Logistic Regression achieved a **ROC-AUC of 0.84**. **VIF analysis** revealed multicollinearity involving tenure, monthly charges, and total charges, so used **Random Forest** as a non-linear benchmark. Both models highlighted tenure, monthly charges, and contract type as key predictors.

### 4. Power BI Dashboard

Created an interactive Power BI dashboard  to present the findings in a business-friendly format.

The dashboard includes five main KPIs and slicers for:

* Contract type
* Internet service
* Payment method
* Tenure bucket

It also allows users to identify churned customers associated with greater revenue value.

## Key Findings

| Business Metric                        |             Finding |
| -------------------------------------- | ------------------: |
| Overall churn rate                     |              26.54% |
| Monthly revenue at risk                | Approximately $139K |
| Percentage monthly revenue at risk     |               30.5% |
| Month-to-month contract churn rate     |               42.7% |
| Two-year contract churn rate           |                2.8% |
| Customers in their first year          |         47.4% churn |
| Customers with 4+ years of tenure      |          9.5% churn |
| Customers without tech support         |         41.6% churn |
| Customers with tech support            |         15.2% churn |
| Electronic-check customers             |         45.3% churn |
| Customers with one subscribed service  |         45.8% churn |
| Customers with six subscribed services |          5.3% churn |


Fiber-optic internet customers also showed a higher churn rate than DSL customers, despite paying more for the higher-tier service. This may indicate possible concerns related to pricing, service expectations, or customer experience.

## Business Recommendations

### 1. Encourage longer-term contracts

Month-to-month customers have the highest churn rate. The company can offer small discounts or benefits to encourage them to switch to one-year or two-year contracts.

### 2. Focus on new customers

Customers in their first year are more likely to leave. The company should improve onboarding and regularly check whether new customers are facing any problems.

### 3. Provide better technical support

Customers without technical support churn more. The company can offer free trials or discounted technical-support plans to high-risk customers.

### 4. Promote automatic payment methods

Customers paying through electronic checks have a higher churn rate. The company can encourage them to use automatic bank transfers or card payments by offering small rewards.

### 5. Create service bundles

Customers using more services tend to churn less. The company can offer discounted bundles that combine internet, phone, security, and technical support services.

### 6. Improve the fiber-optic experience

Fiber-optic customers have a higher churn rate than DSL customers. The company should collect customer feedback and check whether pricing, service quality, or technical issues are causing dissatisfaction.

### 7. Contact high-risk customers early

The churn prediction model can identify customers who are more likely to leave. The company should contact these customers early and offer suitable discounts, support, or personalised plans.

### 8. Prioritise high-value customers

Customers with high monthly charges create a larger revenue loss when they leave. The company should give greater priority to high-value customers who also have a high churn probability.

## Repository Structure

Customer-Churn-Analysis/
│
├── dashboard/
│   ├── dashboard.pbix
│   └── dashboard-screenshot.png
│
├── data/
│   ├── rawdataset.csv
│   └── cleaneddataset.csv
│
├── notebook/
│   ├── eda.ipynb
│   └── churn_model.ipynb
│
├── sql_queries.sql
└── README.md

## Tools and Technologies

* **Python**
* **Pandas**
* **Scikit-learn**
* **SQL Server**
* **SQL Server Management Studio**
* **Power BI**
* **DAX**
* **Logistic Regression**
* **Random Forest**
* **Variance Inflation Factor analysis**
* **Jupyter Notebook**

## Skills Demonstrated

* Data cleaning and validation
* Exploratory data analysis
* Feature engineering
* SQL business analysis
* KPI development
* Data visualisation
* Churn prediction
* Model evaluation
* Multicollinearity diagnosis
* Business recommendation development
* Communicating analytical results through dashboards

## Conclusion

The analysis shows that telecom churn is strongly associated with short customer tenure, month-to-month contracts, higher monthly charges, limited service adoption, lack of technical support, and electronic-check payments.

