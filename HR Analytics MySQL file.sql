Create Database HR_DATA;

select * from hr_analytics;

-- 1)Average Attrition Rate for all Departments
SELECT Department,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 
             AS Attrition_Rate
FROM hr_analytics
GROUP BY Department;

-- 2)Average Hourly Rate of Male Research Scientist
Select avg(HourlyRate) as Avg_Hourly_Rate
from hr_analytics
where JobRole ="Research Scientist" and Gender ="Male";

-- 3)Attrition Rate Vs Monthly Income Stats
SELECT MonthlyIncome,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 
       AS AttritionRate
FROM hr_analytics
GROUP BY MonthlyIncome;

-- 4)Average Working Years for Each Department
SELECT Department, AVG(YearsAtCompany) AS AvgWorkingYears
FROM hr_analytics
GROUP BY Department;

-- 5)Job Role Vs Work-Life Balance
SELECT JobRole, AVG(WorkLifeBalance) AS AvgWorkLifeBalance
FROM hr_analytics
GROUP BY JobRole;

-- 6)Attrition Rate Vs Years Since Last Promotion Relation
SELECT YearsSinceLastPromotion,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 
       AS AttritionRate
FROM hr_analytics
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion desc;

-- =================================================================================================
-- ** EMP Having max and Min salary working in different dept who received less than 13% hike
Select Department,
max(MonthlyIncome),
min(MonthlyIncome)
from hr_analytics
where PercentSalaryHike<13
group by Department;

-- ===============================================================================================
-- ** Avg MonthlyIncome Of All emp who worked more than 7years whose educationfield  is Marketing
Select avg(MonthlyIncome) from hr_analytics
WHERE YearsAtCompany>7
and EducationField ="Marketing"
group by EducationField;

-- ================================================================================================
-- ** Total Num OF Male And Female Emp under Attrition whose marital status is married
--     and having recieved promotion in the last 3 yrs
select Gender,count(EmpID) from hr_analytics
where MaritalStatus ="Married"
and YearsSinceLastPromotion = 3
and Attrition= "Yes"
group by Gender;

-- ================================================================================================
-- ** Emp with max performance rating but no promotion since last 5 yrs & above
select * from hr_analytics
where PerformanceRating = (select max(PerformanceRating) from hr_analytics)
and YearsSinceLastPromotion >=5
and Attrition="Yes";

-- ================================================================================================
-- ** Who has max and min percentage salary hike
SELECT YearsAtCompany,PerformanceRating,YearsSinceLastPromotion,
max(PercentSalaryHike),
min(PercentSalaryHike)
from hr_analytics
group by YearsAtCompany,PerformanceRating,YearsSinceLastPromotion
order by max(PercentSalaryHike) desc,min(PercentSalaryHike) asc;
-- ====================================================================================================
-- **Emp Working overtime but given min salary and are more than of 5 Yrs with company
SELECT * from hr_analytics
where OverTime ="Yes"
and PercentSalaryHike =(SELECT min(PercentSalaryHike) FROM hr_analytics)
AND YearsAtCompany >5
AND Attrition ="Yes";

-- ================================================================================================
-- **Emp Working overtime but given max salary and are less than of 5 Yrs with company
-- (Extra Ordinary performance)
SELECT * from hr_analytics
where OverTime ="Yes"
and PercentSalaryHike =(SELECT max(PercentSalaryHike) FROM hr_analytics)
AND YearsAtCompany <5;

-- ================================================================================================
-- **Emp not Working overtime but given max salary and are less then of 5 yrs with company
SELECT * from hr_analytics
where OverTime ="No"
and PercentSalaryHike =(SELECT max(PercentSalaryHike) FROM hr_analytics)
AND YearsAtCompany <5
AND Attrition ="No";

-- ================================================================================================
