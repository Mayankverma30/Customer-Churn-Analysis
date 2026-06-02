USE mydatabase;
select * from telco_customer_churn_table limit 5;

#Q.1 What Is the Overall Customer Churn Rate?
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS churn_rate_percentage
FROM telco_customer_churn_table;



#Q.2 Which Contract Type Has the Highest Churn?
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM telco_customer_churn_table
GROUP BY Contract
ORDER BY churn_rate DESC;


#Q.3 Which Payment Method Has Highest Churn?
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM telco_customer_churn_table
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;


#Q.4 Does Tenure Affect Churn?
SELECT Churn,
    ROUND(AVG(tenure), 2) AS avg_tenure
FROM telco_customer_churn_table
GROUP BY Churn;



#Q.5 Does Monthly Charge Affect Churn?
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge
FROM telco_customer_churn_table
GROUP BY Churn;


#Q.6 Which Internet Service Has Highest Churn?
SELECT 
    InternetService,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM telco_customer_churn_table
GROUP BY InternetService
ORDER BY churn_rate DESC;


#Q.7 Does Tech Support Reduce Churn?
SELECT 
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM telco_customer_churn_table
GROUP BY TechSupport
ORDER BY churn_rate DESC;


#Q.8 Which Customer Segment Causes Highest Revenue Loss?
SELECT Contract,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END),2) AS Monthly_revenue_loss
FROM telco_customer_churn_table
GROUP BY Contract
ORDER BY Monthly_revenue_loss DESC;


#Q.9 Are Senior Citizens More Likely to Churn?
SELECT 
    SeniorCitizen,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM telco_customer_churn_table
GROUP BY SeniorCitizen
ORDER BY churn_rate DESC;


#Q.10 Which Combination of Features Creates Highest Churn Risk?
SELECT 
    Contract, InternetService, PaymentMethod, COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM telco_customer_churn_table
GROUP BY Contract, InternetService, PaymentMethod
HAVING COUNT(*) >= 150
ORDER BY churn_rate DESC;


#Q.11. Which Customer Groups Should the Company Target First for Retention?
SELECT 
    Contract, tenure, InternetService, PaymentMethod,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM telco_customer_churn_table
GROUP BY Contract, tenure, InternetService, PaymentMethod
HAVING COUNT(*) > 50
ORDER BY churn_rate DESC;



#Q.12. What Is Total Revenue Lost Due to Churn?
SELECT ROUND(SUM(TotalCharges), 2) AS Total_revenue_lost
FROM telco_customer_churn_table
WHERE Churn = 'Yes';
