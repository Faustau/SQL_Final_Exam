-- 1.	LT: Pasirinkite visus darbuotojus: parašykite SQL užklausą, kuri gautų visus darbuotojų įrašus iš Employees lentelės.
--      EN: Select all employees: write a SQL query that will retrieve all employee records from the Employees table.
SELECT * FROM employees;

-- 2.	LT: Pasirinkite tam tikrus stulpelius: parodykite visus vardus ir pavardes iš Employees lentelės.
--      EN: Select specific columns: show all first and last names from the Employees table.

SELECT FirstName, LastName FROM employees;

-- 3.	LT: Filtruokite pagal skyrius: gaukite darbuotojų sąrašą, kurie dirba HR skyriuje (department lentelė).
--      EN: Filter by department: get a list of employees who work in the HR department (department table).
SELECT * 
FROM departments AS d
JOIN employees AS e
	ON d.DepartmentID = e.DepartmentID
WHERE DepartmentName = 'HR';

-- 4.	LT: Surikiuokite darbuotojus: gaukite darbuotojų sąrašą, surikiuotą pagal jų įdarbinimo datą didėjimo tvarka.
--      EN: Sort employees: Get a list of employees sorted by their hire date in ascending order.

SELECT *
FROM employees
ORDER BY HireDate ASC;

-- 5.	LT: Suskaičiuokite darbuotojus: raskite kiek iš viso įmonėje dirba darbuotojų.
--      EN: Count employees: find the total number of employees in the company.

SELECT COUNT(EmployeeID) FROM employees;

-- 6.	LT:Sujunkite darbuotojus su skyriais: išveskite bendrą darbuotojų sąrašą, šalia kiekvieno darbuotojo nurodant skyrių kuriame dirba.
--      EN: Associate employees with departments: display a general list of employees, indicating the department they work in next to each employee.

SELECT EmployeeID, FirstName, LastName, DepartmentName
FROM employees AS e
JOIN departments AS d
	ON d.DepartmentID = e.DepartmentID;

-- 7.	LT: Apskaičiuokite vidutinį atlyginimą: suraskite koks yra vidutinis atlyginimas įmonėje tarp visų darbuotojų.
--      EN: Calculate the average salary: find the average salary in the company among all employees.

SELECT AVG(SalaryAmount) AS Vidutinis_atlyginimas FROM salaries;

-- 8.	LT: Išfiltruokite ir suskaičiuokite: raskite kiek darbuotojų dirba IT skyriuje.
--      EN: Filter and count: find how many employees work in the IT department.

SELECT COUNT(*) AS IT_darbuotoju_sk
FROM employees AS e
LEFT JOIN departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE DepartmentName = 'IT';

-- 9.	LT: Išrinkite unikalias reikšmes: gaukite unikalių siūlomų darbo pozicijų sąrašą iš jobpositions lentelės.
--      EN: Extract unique values: Get a list of unique job positions offered from the jobpositions table.

SELECT DISTINCT PositionTitle FROM jobpositions;

-- 10.	LT: Išrinkite pagal datos rėžį: gaukite darbuotojus, kurie buvo nusamdyti tarp 2020-02-01 ir 2020-11-01.
--      EN: Select by date range: get employees who were hired between 2020-02-01 and 2020-11-01.

SELECT *
FROM employees
WHERE HireDate BETWEEN '2020-02-01' AND '2020-11-01';

-- 11.	LT: Darbuotojų amžius: gaukite kiekvieno darbuotojo amžių pagal tai kada jie yra gimę.
--      EN: Employee Age: Get the age of each employee based on when they were born.

SELECT 
    EmployeeID, 
    FirstName, 
    LastName, 
    DateOfBirth,
    TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) AS Age
FROM employees;

-- 12.	LT: Darbuotojų el. pašto adresų sąrašas: gaukite visų darbuotojų el. pašto adresų sąrašą abėcėline tvarka.
--      EN: Employee Email Address List: Get a list of all employee email addresses in alphabetical order.

SELECT Email
FROM employees
ORDER BY Email ASC;

-- 13.	LT: Darbuotojų skaičius pagal skyrių: suraskite kiek kiekviename skyriuje dirba darbuotojų.
--      EN: Number of employees by department: find how many employees work in each department.

SELECT 
	DepartmentName,
	COUNT(*) AS kiekis 
FROM employees AS e
JOIN departments AS d
	ON d.DepartmentID = e.DepartmentID
GROUP BY DepartmentName;

-- 14.	LT: Darbštus darbuotojas: išrinkite visus darbuotojus, kurie turi daugiau nei 3 įgūdžius (skills).
--      EN: Hard worker: select all workers who have more than 3 skills.

SELECT *
FROM employees AS e
JOIN employeeskills AS es
	ON e.EmployeeID = es.EmployeeID
WHERE EmployeeSkillID IN (
    SELECT SkillID
    FROM employeeskills
    GROUP BY SkillID
    HAVING COUNT(EmployeeSkillID) >= 3);
    
-- 15.	LT: Vidutinė papildomos naudos kaina: apskaičiuokite vidutines papildomų naudų išmokų (benefits lentelė) išlaidas darbuotojams.
--      EN: Average cost of fringe benefits: calculate the average cost of fringe benefits (benefits table) for employees

SELECT AVG(cost) FROM benefits;

-- 16.	LT: Jaunausias ir vyriausias darbuotojai: suraskite jaunausią ir vyriausią darbuotoją įmonėje.
--      EN: Youngest and oldest employees: Find the youngest and oldest employee in the company.

SELECT *
FROM employees
ORDER BY DateOfBirth DESC
LIMIT 1;

SELECT *
FROM employees
ORDER BY DateOfBirth ASC
LIMIT 1;

-- 17.	LT: Skyrius su daugiausiai darbuotojų: suraskite kuriame skyriuje dirba daugiausiai darbuotojų.
--      EN: Department with the most employees: Find which department has the most employees.

SELECT DepartmentName, COUNT(*)
FROM  employees AS e
JOIN departments AS d
	ON e.DepartmentID = d.DepartmentID
GROUP BY DepartmentName;

-- 18.	LT: Tekstinė paieška: suraskite visus darbuotojus su žodžiu “excellent” jų darbo atsiliepime (performancereviews lentelė).
--      EN: Text search: find all employees with the word “excellent” in their performance review (performancereviews table). 

SELECT *
FROM performancereviews
WHERE ReviewText LIKE '%excellent%';

-- 19.	LT: Darbuotojų telefono numeriai: išveskite visų darbuotojų ID su jų telefono numeriais.
--      EN: Employee Phone Numbers: Output all employee IDs with their phone numbers.

SELECT EmployeeID, phone
FROM employees;

-- 20.	LT: Darbuotojų samdymo mėnesis: suraskite kurį mėnesį buvo nusamdyta daugiausiai darbuotojų.
--      EN: Employee hiring month: find which month saw the most employees hired.

SELECT 
	CASE
		WHEN HireDate LIKE '%-01-%' THEN 'Sausis'
		WHEN HireDate LIKE '%-02-%' THEN 'Vasaris'
        WHEN HireDate LIKE '%-03-%' THEN 'Kovas'
        WHEN HireDate LIKE '%-04-%' THEN 'Balandis'
        WHEN HireDate LIKE '%-05-%' THEN 'Gegužė'
        WHEN HireDate LIKE '%-06-%' THEN 'Birželis'
        WHEN HireDate LIKE '%-07-%' THEN 'Liepa'
        WHEN HireDate LIKE '%-08-%' THEN 'Rugpjūtis'
        WHEN HireDate LIKE '%-09-%' THEN 'Rugsėjis'
        WHEN HireDate LIKE '%-10-%' THEN 'Spalis'
        WHEN HireDate LIKE '%-11-%' THEN 'Lapkritis'
        WHEN HireDate LIKE '%-12-%' THEN 'Gruodis'
	END AS Gimimo_menuo,
    COUNT(*) AS Kiekis
FROM employees
GROUP BY Gimimo_menuo;

-- OR

SELECT 
        month(Hiredate) AS Hire_month,
        COUNT(employeeid) AS number_of_employee
FROM employees
GROUP BY Hire_month
HAVING number_of_employee>1;

-- 21.	LT: Darbuotojų įgūdžiai: išveskite visus darbuotojus, kurie turi įgūdį “Communication”.
--      EN: Employee skills: display all employees who have the skill “Communication”.

SELECT *
FROM employees AS e
JOIN employeeskills AS es
	ON e.EmployeeID = es.EmployeeID
JOIN skills AS s
	ON es.SkillID = s.SkillID
WHERE SKillName LIKE 'Communication';

-- 22.	LT: Sub-užklausos: suraskite kuris darbuotojas įmonėje uždirba daugiausiai ir išveskite visą jo informaciją.
--      EN: Sub-queries: find which employee in the company earns the most and output all their information.

SELECT *
FROM employees AS e
JOIN salaries AS s
	ON e.EmployeeID = s.EmployeeID
ORDER BY SalaryAmount DESC
LIMIT 1;

-- 23.	LT: Grupavimas ir agregacija: apskaičiuokite visas įmonės išmokų (benefits lentelė) išlaidas.
--      EN: Grouping and aggregation: calculate all company benefits costs (benefits table).

SELECT SUM(cost) AS Islaidos FROM benefits;

-- 24.	LT: Įrašų atnaujinimas: atnaujinkite telefono numerį darbuotojo, kurio id yra 1.
--      EN: Record update: update the phone number of the employee with id 1.

UPDATE employees 
SET Phone = '666-666-6666'
WHERE EmployeeID = 1;

-- 25.	LT: Atostogų užklausos: išveskite sąrašą atostogų prašymų (leaverequests), kurie laukia patvirtinimo.
--      EN: Leave requests: Display a list of leave requests that are awaiting approval.

SELECT *
FROM LeaveRequests
WHERE LeaveType = 'Vacation' AND Status = 'Pending';

-- 26.	LT: Darbo atsiliepimas: išveskite darbuotojus, kurie darbo atsiliepime yra gavę 5 balus.
--      EN: Performance feedback: Display employees who have received a 5 rating on their performance feedback.

SELECT *
FROM performancereviews
WHERE rating = '5';

-- 27.	LT: Papildomų naudų registracijos: išveskite visus darbuotojus, kurie yra užsiregistravę į “Health Insurance” papildomą naudą (benefits lentelė).
--      EN: Benefits Enrollment: List all employees who are enrolled in the “Health Insurance” benefits (benefits table).

SELECT *
FROM employees AS e
JOIN employeebenefits AS eb
	ON e.EmployeeID = eb.EmployeeID
JOIN benefits AS b
	ON eb.BenefitID = b.BenefitID
WHERE BenefitName LIKE '%Health Insurance%';

-- 28.	LT: Atlyginimų pakėlimas: parodykite kaip atrodytų atlyginimai darbuotojų, dirbančių “Finance” skyriuje, jeigu jų atlyginimus pakeltume 10 %.
--      EN: Salary increase: Show what the salaries of employees working in the Finance department would look like if we increased their salaries by 10%.

SELECT 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName, 
    d.DepartmentName,
    s.SalaryAmount AS CurrentSalary,
    s.SalaryAmount * 1.10 AS NewSalary
FROM employees AS e
JOIN departments AS d 
	ON e.DepartmentID = d.DepartmentID
JOIN salaries AS s 
	ON e.EmployeeID = s.EmployeeID
WHERE d.DepartmentName = 'Finance';

-- 29.	LT: Efektyviausi darbuotojai: raskite 5 darbuotojus, kurie turi didžiausią darbo vertinimo (performance lentelė) reitingą.
--      EN: Most effective employees: find the 5 employees who have the highest job evaluation (performance table) rating.

SELECT *
FROM performancereviews
ORDER BY Rating DESC
LIMIT 5;

-- 30.	LT: Atostogų užklausų istorija: gaukite visą atostogų užklausų istoriją (leaverequests lentelė) darbuotojo, kurio id yra 1.
--      EN: Leave Request History: Get the complete leave request history (leaverequests table) for the employee with id 1.

SELECT *
FROM leaverequests
WHERE EmployeeID = 1;

-- 31.	LT: Atlyginimų diapozono analizė: nustatykite atlyginimo diapazoną (minimalų ir maksimalų) kiekvienai darbo pozicijai.
--      EN: Salary range analysis: determine the salary range (minimum and maximum) for each job position.

SELECT DISTINCT DepartmentName, max(SalaryAmount) as max_salary, min(SalaryAmount) as min_salary
FROM employees AS e
JOIN salaries AS s
	ON e.EmployeeID = s.EmployeeID
JOIN departments AS d
	ON e.DepartmentID = d.DepartmentID
GROUP BY DepartmentName;

-- 32.	LT: Darbo atsiliepimo istorija: gaukite visą istoriją apie darbo atsiliepimus (performancereviews lentelė), darbuotojo, kurio id yra 2.
--      EN: Performance Review History: Get the complete history of performance reviews (performancereviews table) for employee with id 2.

SELECT *
FROM performancereviews
WHERE EmployeeID = 2;

-- 33.	LT: Papildomos naudos kaina vienam darbuotojui: apskaičiuokite bendras papildomų naudų išmokų išlaidas vienam darbuotojui (benefits lentelė).
--      EN: Cost of fringe benefits per employee: calculate the total cost of fringe benefits per employee (benefits table).

SELECT FirstName, LastName, sum(cost) AS benefits
FROM employeebenefits
JOIN employees
	ON employeebenefits.EmployeeID = employees.EmployeeID
JOIN benefits
	ON employeebenefits.BenefitID = benefits.BenefitID
GROUP BY FirstName, LastName;

-- 34.	LT: Geriausi įgūdžiai pagal skyrių: išvardykite dažniausiai pasitaikančius įgūdžius kiekviename skyriuje.
--      EN: Top skills by department: List the most common skills in each department.

SELECT DepartmentName, SkillName, count(SkillName) AS kiekis
FROM employeeskills
JOIN skills
	ON employeeskills.SkillID = skills.SkillID
JOIN employees
	ON employeeskills.EmployeeID = employees.EmployeeID
JOIN departments
	ON employees.DepartmentID = departments.DepartmentID
GROUP BY DepartmentName, SkillName;

-- 35.	LT: Atlyginimo augimas: apskaičiuokite procentinį atlyginimo padidėjimą kiekvienam darbuotojui, lyginant su praėjusiais metais.
--      EN: Salary growth: calculate the percentage salary increase for each employee compared to the previous year.

WITH Salaries2022 AS (
	SELECT
		EmployeeID,
        MAX(SalaryAmount) AS Salary2022
	FROM
		salaries
	WHERE
		YEAR(SalaryStartDate) = 2022
	GROUP BY 
		EmployeeID),
Salaries2023 AS (
	SELECT
		EmployeeID,
        MAX(SalaryAmount) AS Salary2023
	FROM
		salaries
	WHERE
		YEAR(SalaryStartDate) = 2023
	GROUP BY 
		EmployeeID)
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    s22.Salary2022,
    s23.Salary2023,
    ((s23.Salary2023 - s22.Salary2022) / s22.Salary2022) * 100 AS PercentageIncrease
FROM
    employees AS e
JOIN
    Salaries2022 AS s22 ON e.EmployeeID = s22.EmployeeID
JOIN
    Salaries2023 AS s23 ON e.EmployeeID = s23.EmployeeID
ORDER BY
    EmployeeID ASC;

-- 36.	LT: Darbuotojų išlaikymas: raskite darbuotojus, kurie įmonėje dirba daugiau nei 5 metai ir kuriems per tą laiką nebuvo pakeltas atlyginimas.
--      EN: Employee retention: find employees who have been with the company for more than 5 years and who have not received a salary increase during that time.

WITH EmployeeTenure AS (
    SELECT
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.HireDate,
        DATEDIFF(CURDATE(), e.HireDate) AS TenureDays
    FROM
        employees AS e
    WHERE
        e.HireDate <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
),
SalaryRecords AS (
    SELECT
        s.EmployeeID,
        COUNT(*) AS SalaryChangeCount,
        MIN(s.SalaryStartDate) AS FirstSalaryDate,
        MAX(s.SalaryAmount) AS MaxSalary,
        MIN(s.SalaryAmount) AS MinSalary
    FROM
        salaries AS s
    GROUP BY
        s.EmployeeID
),
NoSalaryIncrease AS (
    SELECT
        sr.EmployeeID
    FROM
        SalaryRecords AS sr
    WHERE
        sr.MaxSalary = sr.MinSalary
)
SELECT
    et.EmployeeID,
    et.FirstName,
    et.LastName,
    et.HireDate,
    et.TenureDays
FROM
    EmployeeTenure AS et
JOIN NoSalaryIncrease AS nsi 
    ON et.EmployeeID = nsi.EmployeeID
ORDER BY
    et.EmployeeID;

-- 37.	LT: Darbuotojų atlyginimų analizė: suraskite kiekvieno darbuotojo atlygį (atlyginimas (salaries lentelė) + 
--          išmokos už papildomas naudas (benefits lentelė)) ir surikiuokite darbuotojus pagal bendrą atlyginimą mažėjimo tvarka.
--      EN: Employee salary analysis: find each employee's compensation (salary (salaries table) + 
--          fringe benefits (benefits table)) and sort employees by total salary in descending order.

WITH EmployeeSalary AS (
    SELECT
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        COALESCE(MAX(s.SalaryAmount), 0) AS SalaryAmount
    FROM
        employees AS e
    LEFT JOIN salaries AS s 
        ON e.EmployeeID = s.EmployeeID
    GROUP BY
        e.EmployeeID, e.FirstName, e.LastName
),
EmployeeBenefits AS (
    SELECT
        eb.EmployeeID,
        SUM(b.Cost) AS TotalBenefits
    FROM
        employeebenefits eb
    JOIN
        benefits b ON eb.BenefitID = b.BenefitID
    GROUP BY
        eb.EmployeeID
)
SELECT
    es.EmployeeID,
    es.FirstName,
    es.LastName,
    es.SalaryAmount,
    COALESCE(eb.TotalBenefits, 0) AS TotalBenefits,
    es.SalaryAmount + COALESCE(eb.TotalBenefits, 0) AS TotalCompensation
FROM
    EmployeeSalary AS es
LEFT JOIN EmployeeBenefits AS eb 
    ON es.EmployeeID = eb.EmployeeID
ORDER BY
    TotalCompensation DESC;

-- 38.	LT: Darbuotojų darbo atsiliepimų tendencijos: išveskite kiekvieno darbuotojo vardą ir pavardę, 
--          nurodant ar jo darbo atsiliepimas (performancereviews lentelė) pagerėjo ar sumažėjo.
--      EN: Employee performance review trends: output each employee's first and last name, 
--          indicating whether their performance review (performancereviews table) has improved or decreased.

WITH Palyginimas AS (
    SELECT
        pr.employeeID,
        pr.rating,
        LAG(pr.rating) OVER (PARTITION BY pr.employeeID ORDER BY pr.reviewID) AS PreviousScore
    FROM
        performancereviews AS pr
)
SELECT
    e.FirstName,
    e.LastName,
    CASE
        WHEN rc.rating > rc.PreviousScore THEN 'Pagerėjo'
        WHEN rc.rating < rc.PreviousScore THEN 'Sumažėjo'
        ELSE 'Nepakito'
    END AS Perziura
FROM
    Palyginimas AS rc
JOIN
    Employees AS e ON rc.employeeID = e.employeeID
WHERE
    rc.PreviousScore IS NOT NULL;