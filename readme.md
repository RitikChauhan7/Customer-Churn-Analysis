# Telecom Customer Churn Analysis & Prediction

An end-to-end data analytics and machine learning project on customer churn for a telecom company, using **Python, SQL, Power BI, XGBoost, and SHAP**. The goals were to identify the factors associated with churn, quantify the revenue lost to it, present the insights in an interactive dashboard, and build a model that predicts which individual customers are at risk and explains why.

[Dashboard](dashboard/dashboardBI.png)

## Dataset Used

* IBM Telco Customer Churn Dataset
* 7,043 customer records
* Customer demographics, subscribed services, contract details, payment methods, tenure, monthly charges, and churn status

## Business Context

* Overall churn rate: **26.54%** (1,869 of 7,043 customers)
* Monthly revenue lost to churn: **~$139K**, about **30.5%** of total monthly recurring revenue

## Approach

### 1. Data Cleaning (Python)

* Cleaned and validated the dataset using Pandas.
* Converted `TotalCharges` from text to numeric.
* Handled 11 blank values by replacing them with `0` after verifying they all belonged to new customers with zero tenure (not yet billed).
* Checked for duplicate rows and customer IDs, outliers, and inconsistent category labels.
* Created new features:
  * Churn Flag
  * Tenure Bucket
  * NumServices (count of subscribed add-on services)

### 2. Business Analysis (SQL Server)

Used SQL to answer business questions such as:

* Which contract type has the highest churn?
* Which payment method loses the most customers?
* How much monthly revenue is lost due to churn?
* How does churn vary with tenure?
* Does technical support reduce churn?
* Do customers with more subscribed services churn less?

### 3. Dashboard (Power BI)

Built an interactive dashboard with custom DAX measures and 5 KPIs:

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

### 4. Churn Prediction (XGBoost)

Built a classification model to predict the churn risk of individual customers.

* **Data preparation:** Dropped the customer ID and kept the churn flag out of the features to avoid target leakage. Text columns were passed to XGBoost as native categorical features, which avoids one-hot encoding. Data was split 80/20 into training and test sets, stratified so both keep the same 26.5% churn ratio.
* **Choosing the right metric:** Only 26.5% of customers churn, so a model that predicts "no churn" for everyone would already be 73% accurate. Accuracy was therefore not used as the main metric. The focus was **recall** (of all customers who actually churned, how many did the model catch) and **precision** (of all customers flagged as at risk, how many actually churned).
* **Handling class imbalance:** The default model caught only 55% of churners. Using `scale_pos_weight` (which treats a missed churner as a costlier mistake) and lowering the decision threshold from 0.5 to 0.35 raised recall to 76%, at the cost of more false alarms.
* **Hyperparameter tuning:** Used randomized search with 5-fold cross-validation, scored on PR-AUC, on the training data only. The best configuration reached a cross-validated PR-AUC of 0.668.

**Results on the held-out test set (1,409 customers, churn class):**

| Model | Recall | Precision | Churners missed | False alarms | PR-AUC |
|---|---|---|---|---|---|
| Default XGBoost | 0.55 | 0.61 | 168 | 131 | 0.626 |
| + class weighting | 0.64 | 0.53 | 135 | 213 | 0.616 |
| + threshold lowered to 0.35 | 0.76 | 0.51 | 89 | 276 | 0.616 (same model) |

Lowering the threshold or weighting the classes does not make the model better at ranking customers by risk; it moves the balance between catching more churners and raising more false alarms. Where to sit on that trade-off is a business decision: it depends on what a lost customer costs versus what an unnecessary retention offer costs.

### 5. Model Explainability (SHAP)

SHAP was used to open up the model and explain its predictions, both overall and for individual customers.

* **Overall:** the strongest drivers of predicted churn were contract type (by far the strongest), tenure, internet service type, monthly charges, and the absence of add-on services such as online security and tech support.
* **Direction:** newer customers, customers with higher monthly bills, senior citizens, and customers with fewer add-on services were pushed toward higher churn risk.
* **Individual customers:** SHAP breaks a single prediction down feature by feature. For example, a customer with a month-to-month contract, a $99 monthly bill, fiber optic internet, and 7 months of tenure was predicted at 99.6% churn risk and did churn. A customer with a one-year contract, a $21 bill, no internet service, and 69 months of tenure was predicted at near-zero risk and stayed.

The model independently reproduced the churn drivers found in the SQL analysis, which gives confidence that it learned real patterns rather than noise.

## Key Insights

* Overall churn rate: **26.54%**
* Lost monthly revenue: **$139K** (30.5% of total MRR)
* Month-to-month contracts churned at **42.7%** versus **2.8%** for two-year contracts.
* Customers in their first year showed the highest churn (47.4%).
* Customers without technical support churned much more often (41.6% vs. 15.2%).
* Electronic-check users had the highest churn among all payment methods (45.3%).
* Customers subscribed to more services generally had lower churn (45.8% with one service vs. 5.3% with six).
* Fiber optic customers churned the most among internet service types.
* The XGBoost model flags about 3 out of 4 actual churners on unseen customers, and SHAP confirms contract type and tenure as the leading drivers.

## Business Recommendations

* Encourage month-to-month customers to switch to longer-term contracts.
* Improve onboarding for new customers.
* Promote technical support among high-risk customers.
* Encourage automatic payment methods.
* Offer bundled services to increase customer retention.
* Score the active customer base regularly with the model and give the retention team a ranked outreach list, with SHAP explanations showing why each customer is flagged.

## Limitations

* The dataset is a teaching dataset from IBM, not real company data.
* The 0.35 decision threshold was explored on the test set, so the reported recall at that threshold is likely slightly optimistic. In production it should be chosen on a separate validation set using real cost figures for retention offers and lost customers.
* The model predicts who is at risk, not why a retention offer would work; the effect of any intervention would need to be tested separately.

## Repository Structure


Customer Churn Analysis
├── dashboard
├── data
├── notebook
├── sql
└── README.md


## Tools Used

* Python (Pandas, scikit-learn, Matplotlib)
* XGBoost
* SHAP
* SQL Server
* Power BI
* DAX
* Jupyter Notebook