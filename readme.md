# Telecom Customer Churn Analysis

An end-to-end data analytics project where I analysed customer churn for a telecom company using **Python, SQL, and Power BI**. The goal was to identify the factors associated with customer churn, quantify the revenue lost due to churn, and present the insights through an interactive dashboard.

[Dashboard](dashboard/dashboardBI.png)

## Dataset Used

* IBM Telco Customer Churn Dataset
* 7,043 customer records
* Customer demographics, subscribed services, contract details, payment methods, tenure, monthly charges, and churn status


### Data Cleaning (Python)

* Cleaned and validated the dataset using Pandas.
* Converted `TotalCharges` from text to numeric.
* Handled 11 blank values by replacing them with `0` after verifying they belonged to new customers with zero tenure.
* Created new features including:

  * Churn Flag
  * Tenure Bucket
  * NumServices

### Business Analysis (SQL Server)

Used SQL to answer business questions such as:

* Which contract type has the highest churn?
* Which payment method loses the most customers?
* How much monthly revenue is lost due to churn?
* How does churn vary with tenure?
* Does technical support reduce churn?
* Do customers with more subscribed services churn less?

### Dashboard (Power BI)

Built an interactive dashboard with 5 KPI's-

* Total Customers
* Churn Rate
* Total Monthly Recurring Revenue
* Monthly Recurring Revenue Lost due to Churn
* Average Customer Tenure

Added slicers for:

* Contract Type
* Internet Service
* Payment Method
* Tenure Bucket

## Key Insights

* Overall churn rate: **26.54%**
* Lost monthly revenue: **$139K**
* Month-to-month customers had significantly higher churn than customers on long-term contracts.
* Customers in their first year showed the highest churn.
* Customers without technical support churned much more frequently.
* Electronic-check users had the highest churn among all payment methods.
* Customers subscribed to multiple services generally had lower churn.

## Business Recommendations

* Encourage month-to-month customers to switch to longer-term contracts.
* Improve onboarding for new customers.
* Promote technical support among high-risk customers.
* Encourage automatic payment methods.
* Offer bundled services to increase customer retention.

## Repository Structure

Customer Churn Analysis
├── dashboard
├── data
├── notebook
├── sql
└── README.md

## Tools Used

* Python (Pandas)
* SQL
* Power BI
* DAX
* Jupyter Notebook
