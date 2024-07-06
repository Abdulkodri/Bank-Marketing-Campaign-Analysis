CREATE DataBase BankMarkCamp;

-- Create a cleaned version of the dataset
CREATE TABLE cleaned_bank_marketing  ( 
occupation VARCHAR(100),
 age INT, 
 education_level VARCHAR(100), 
 marital_status VARCHAR(100), 
 communication_channel VARCHAR(50), 
 call_month VARCHAR(255), 
 call_day INT, 
 call_duration INT, 
 call_frequency INT, 
 previous_campaign_outcome VARCHAR(100), 
 conversion_status VARCHAR(255) ) ;
 
 -- Insert data into the table
 INSERT INTO cleaned_bank_marketing (
 occupation, 
 age, 
 education_level, 
 marital_status, 
 communication_channel, 
 call_month, 
 call_day, 
 call_duration, 
 call_frequency, 
 previous_campaign_outcome, 
 conversion_status)
 Select occupation, 
 age, 
 education_level, 
 marital_status, 
 communication_channel, 
 call_month, 
 call_day, 
 call_duration, 
 call_frequency, 
 previous_campaign_outcome, 
 conversion_status From dataset;
 
 Describe cleaned_bank_marketing;
-- Total number of customers in each age group
SELECT age, COUNT(*) AS total_customers
FROM cleaned_bank_marketing
GROUP BY age
ORDER BY total_customers DESC;

-- Conversion rate by age group
SELECT age, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) AS converted_customers,
       (SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS conversion_rate
FROM cleaned_bank_marketing
GROUP BY age
ORDER BY conversion_rate DESC;

-- Conversion rate by communication channel
SELECT communication_channel, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) AS converted_customers,
       (SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS conversion_rate
FROM cleaned_bank_marketing
GROUP BY communication_channel
ORDER BY conversion_rate DESC;

-- Average call duration for successful conversions
SELECT AVG(call_duration) AS avg_call_duration
FROM cleaned_bank_marketing
WHERE conversion_status = 'converted';

-- Conversion rate by previous campaign outcome
SELECT previous_campaign_outcome, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) AS converted_customers,
       (SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS conversion_rate
FROM cleaned_bank_marketing
GROUP BY previous_campaign_outcome
ORDER BY conversion_rate DESC;

-- Call frequency impact on conversion rate
SELECT call_frequency, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) AS converted_customers,
       (SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS conversion_rate
FROM cleaned_bank_marketing
GROUP BY call_frequency
ORDER BY conversion_rate DESC;

--  Conversion rate by marital status
SELECT marital_status, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) AS converted_customers,
       (SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS conversion_rate
FROM cleaned_bank_marketing
GROUP BY marital_status
ORDER BY conversion_rate DESC;

-- Conversion rate by education level
SELECT education_level, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) AS converted_customers,
       (SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS conversion_rate
FROM cleaned_bank_marketing
GROUP BY education_level
ORDER BY conversion_rate DESC;

-- Monthly conversion trends
SELECT call_month, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) AS converted_customers,
       (SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS conversion_rate
FROM cleaned_bank_marketing
GROUP BY call_month
ORDER BY FIELD(call_month, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

--  Most common occupations among converted customers
SELECT occupation, COUNT(*) AS converted_customers
FROM cleaned_bank_marketing
WHERE conversion_status = 'converted'
GROUP BY occupation
ORDER BY converted_customers DESC;

