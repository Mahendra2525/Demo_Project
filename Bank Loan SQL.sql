CREATE TABLE loan_data (
    id INT primary key,
    address_state VARCHAR(10),
    application_type VARCHAR(50),
    emp_length VARCHAR(20),
    emp_title VARCHAR(100),
    grade VARCHAR(5),
    home_ownership VARCHAR(20),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(50),
    next_payment_date DATE,
    member_id INT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(10),
    term VARCHAR(20),
    verification_status VARCHAR(50),
    annual_income DECIMAL(12,2),
    dti DECIMAL(10,2),
    installment DECIMAL(10,2),
    int_rate DECIMAL(5,2),
    loan_amount DECIMAL(12,2),
    total_acc INT,
    total_payment DECIMAL(12,2)
);

select * from loan_data ;

-- Q1.Total_Loan_App Count ID Details
select COUNT(id) AS Total_Loan_Application from loan_data

-- Perteculart Month Data Extract
select COUNT(id) AS Total_Loan_Application from loan_data
where EXTRACT(MONTH FROM issue_date) =12 
AND EXTRACT(YEAR FROM issue_date) = 2021 ;

-- Priveus Month Data Extract
select COUNT(id) AS PMTD_Total_Loan_Application from loan_data
where EXTRACT(MONTH FROM issue_date) =11
AND EXTRACT(YEAR FROM issue_date) = 2021 ;


-- Q2. Toatal Funded amount and Month Total Amount
select SUM(loan_amount) As Total_Funded_Amount From loan_data

select SUM(loan_amount) As MTD_Total_Funded_Amount From loan_data
Where EXTRACT(MONTH FROM issue_date) = 12
AND EXTRACT(YEAR FROM issue_date) = 2021

-- Total Fund Priveus Month and Year amount
select SUM(loan_amount) As PMTD_Total_Funded_Amount From loan_data
Where EXTRACT(MONTH FROM issue_date) = 11
AND EXTRACT(YEAR FROM issue_date) = 2021

-- Q3. Total Amount Received
select SUM(total_payment) AS Total_Amount_Received FROM loan_data

--
select SUM(total_payment) AS Total_Amount_Received FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
AND EXTRACT(YEAR FROM issue_date) = 2021

--
select SUM(total_payment) AS PMTD_Total_Amount_Received FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
AND EXTRACT(YEAR FROM issue_date) = 2021

-- Q4. Average Interest Rate
SELECT ROUND (AVG(int_rate) ,2)* 100 AS Avg_Interest_Rate FROM loan_data

--
SELECT ROUND (AVG(int_rate) ,4)* 100 AS Avg_Interest_Rate FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) =12
AND EXTRACT(YEAR FROM issue_date) = 2021
--
SELECT ROUND (AVG(int_rate) ,4)* 100 AS PMTD_Avg_Interest_Rate FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) =11
AND EXTRACT(YEAR FROM issue_date) = 2021

-- Q5. dti data sum value count
SELECT ROUND(AVG(dti),4) * 100 AS Avg_DTI From loan_data

--Month Avg total dti
SELECT ROUND(AVG(dti),4) * 100 AS MTD_Avg_DTI From loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
AND EXTRACT(YEAR FROM issue_date) =2021

--
SELECT ROUND(AVG(dti),4) * 100 AS PMTD_Avg_DTI From loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
AND EXTRACT(YEAR FROM issue_date) =2021

-- Q6. Loan status find out
SELECT loan_status FROM loan_data

-- Q7. Good loan Status check in percentage
Select
	(COUNT(CASE WHEN loan_status = 'Fully Paid'  OR loan_status = 'Current' THEN id END) * 100)
	/
	COUNT(id)AS Good_loan_percentage
FROM loan_data

-- Good loan Application status
Select COUNT(id) As Good_loan_Application from loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good loan Funded Amount
Select SUM(loan_amount) AS Good_Loan_Funded_Amount FROM loan_data
WHERE  loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good loan Recieved Amount
Select SUM(total_payment) AS Good_loan_Recieved_amount FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Q8. Bad loan Status find
Select
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0)
	/ COUNT(id) AS Bad_Loan_Percentage
FROM loan_data ;

-- Bad loan Application status
SELECT COUNT(id) AS Bad_loan_Application FROM loan_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Funded Amount
Select SUM(loan_amount) AS Bad_loan_Funded_Amount FROM loan_data
WHERE loan_status = 'Charged Off'

-- Bad loan Amount Recievded
Select SUM(total_payment) AS Bad_Loan_Amount_Recieved FROM loan_data
WHERE loan_status = 'Charged Off'

-- Q9. All Loan Status Check
SELECT
		loan_status,
		COUNT(id) AS Total_Loan_Application,
		SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount,
		AVG(int_rate *100) AS Interest_RAte,
		AVG(dti * 100) AS DTI
	FROM
	 	loan_data
	Group by
		loan_status

-- Month Total Amount
Select 	
		loan_status,
		SUM(total_payment) AS MTD_Total_Amount_Received,
		SUM(loan_amount) AS MTD_Total_Funded_Amoount
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) =12
Group by loan_status

-- Monthly Trands by Issue date
SELECT
		EXTRACT(MONTH FROM issue_date) AS month,
		COUNT(id) AS Total_Loan_Applications,
		SUM(loan_amount) AS Total_Funded_Amount,
		SUM(total_payment) AS Total_Received_Amount
FROM loan_data
GROUP BY EXTRACT(MONTH FROM issue_date)
ORDER BY EXTRACT(MONTH FROM issue_date);

-- Address State
SELECT
		address_state,
		COUNT(id) AS Total_loan_Application,
		SUM(loan_amount) AS Total_Funded_Amount,
		SUM(total_payment) AS Total_Received_Amount
From loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;

-- Loan Term in various term
Select
	  term,
	  COUNT(id) AS Total_Loan_Applications,
	  SUM(loan_amount) AS Total_Funded_Amount,
	  SUM(total_payment) AS Total_Received_Amount
FROM loan_data
GROUP BY term
ORDER BY term

-- Emp Length Count loan duration
SELECT
	  emp_length,
	  COUNT(id) AS Total_Loan_Applications,
	  SUM(loan_amount) AS Total_Funded_Amount,
	  SUM(total_payment) AS Total_Received_Amount
FROM loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC

-- Loan Purpose
Select 
	 purpose,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 Sum(total_payment) AS Total_Received_Amount
FROM loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC

-- Home Ownership
Select
	 home_ownership,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Received_Amount
FROM loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC

-- Grade
Select
	 home_ownership,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Received_Amount
FROM loan_data
WHERE grade = 'A' AND address_state = 'CA'
GROUP BY home_ownership
ORDER BY COUNT(id) DESC

	 