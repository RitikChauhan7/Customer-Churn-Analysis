select * from dbo.Customers

-- Q1. What is the overall churn rate?
-- Business use: baseline KPI for leadership reporting.
SELECT
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 2) AS churn_rate_pct
FROM customers;


-- Q2. Which contract type has the highest churn rate?
-- Business use: identify whether contract length is a retention lever.
SELECT
    Contract,
    COUNT(*) AS customers,
    SUM(ChurnFlag) AS churned,
    ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- Q3. How does churn rate change with tenure (customer lifetime stage)?
-- Business use: pinpoint the highest-risk window for intervention.
SELECT
    TenureBucket,
    COUNT(*) AS customers,
    SUM(ChurnFlag) AS churned,
    ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY TenureBucket
ORDER BY
    CASE TenureBucket
        WHEN '0-1 yr' THEN 1 
        WHEN '1-2 yr' THEN 2
        WHEN '2-4 yr' THEN 3 
        ELSE 4 
        END;

-- Q4. How much monthly recurring revenue (MRR) is at risk from churned customers?
-- Business use: converts churn from a % into a dollar figure leadership cares about.
SELECT
    ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN MonthlyCharges ELSE 0 END), 2) AS mrr_lost_from_churn,
    ROUND(SUM(MonthlyCharges), 2) AS total_mrr,
    ROUND(100.0 * SUM(CASE WHEN ChurnFlag = 1 THEN MonthlyCharges ELSE 0 END)
          / SUM(MonthlyCharges), 2) AS pct_mrr_at_risk
FROM customers;
 
 
-- Q5. Does having tech support reduce churn?
-- Business use: tests a specific retention hypothesis (bundle tech support?).
SELECT
    TechSupport,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY TechSupport
ORDER BY churn_rate_pct DESC;
 
 
-- Q6. Which payment method has the highest churn rate?
-- Business use: electronic check is a known churn flag in this dataset —
-- worth checking if billing friction correlates with attrition.
SELECT
    PaymentMethod,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;
 
 
-- Q7. Top 5 highest-value customers currently at risk (churn-flagged) —
-- Business use: this is the exact list a retention team would call first.
SELECT TOP 5
    customerID, Contract, tenure, MonthlyCharges, TotalCharges, NumServices
FROM customers
WHERE ChurnFlag = 1
ORDER BY MonthlyCharges DESC;
 
 
-- Q8. Does number of subscribed services correlate with churn?
-- Business use: tests whether "stickiness" via bundling reduces churn.
SELECT
    NumServices,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY NumServices
ORDER BY NumServices;

-- Q9. Churn by Internet Service type
SELECT InternetService, COUNT(*) AS customers,
    ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;

-- Q10. Average tenure & spend — churned vs retained
SELECT ChurnFlag, 
    AVG(tenure) AS avg_tenure, 
    AVG(MonthlyCharges) AS avg_monthly_charge
FROM customers
GROUP BY ChurnFlag;

-- Q11. Combined effect: Contract × NumServices
SELECT Contract, NumServices, COUNT(*) AS customers,
    ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY Contract, NumServices
ORDER BY Contract, NumServices;