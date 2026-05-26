-- Problem 41 (brought up by group member, Monika Sakariya)
SELECT p.ProdNo, p.ProdName, p.ProdPrice, SUM(ol.Qty) as total
FROM Product p
    JOIN OrdLine ol ON p.ProdNo = ol.ProdNo
    JOIN OrderTbl o ON ol.OrdNo = o.OrdNo
WHERE o.OrdState = 'CO'
    AND o.OrdDate BETWEEN DATE '2021-01-01' AND DATE '2021-01-31' 
GROUP BY p.ProdNo, p.ProdName, p.ProdPrice
ORDER BY p.ProdNo;
/*
Observation 1: 
-- always make sure that in your JOIN ON statements that the column 
-- names are the same.
*/


-- Problem 10
/* Note: Professor said it is sometimes sufficient to copy and paste problem:
"List the order number, order date, and customer number of orders placed after 
January 23, 2021, shipped to Washington recipients."
*/
SELECT OrdNo, OrdDate, CustNo
FROM OrderTbl
--WHERE OrdState = 'WA' AND OrdDate > '23-JAN-21';
WHERE OrdState = 'WA' AND OrdDate > DATE '2021-01-23';
-- "should the order date be inclusive or exclusive?"
/*
Observation 2:
-- can use either DATE keyword followed by only numbers and dashes 
-- or no DATE keyword with JAN instead of 01
*/


-- Problem 32 (brought up by Joshua Taylor in class)
/*
List the employee number and the name (first and last) of the first- and 
second-level subordinates of the employee named Thomas Johnson. To distinguish 
the level of subordinates, include a computed column with the subordinate level 
(1 or 2).
*/
-- level 1 subordinates
SELECT EmpNo, EmpFirstName, EmpLastName, 1 "subordinate level"
FROM Employee 
WHERE SupEmpNo = 'E9884325'
UNION
-- level 2 subordinates
SELECT EmpNo, EmpFirstName, EmpLastName, 2 "subordinate level"
FROM Employee
WHERE SupEmpNo IN (
SELECT EmpNo "subordinate level"
FROM Employee
WHERE SupEmpNo = 'E9884325'
);
/*
-- another way
*/
SELECT e1.EmpNo, e1.EmpFirstName, e1.EmpLastName, 1 "subordinate level"
FROM Employee e0
JOIN Employee e1 ON e1.SupEmpNo = e0.EmpNo
WHERE e0.EmpFirstName = 'Thomas'
UNION
SELECT e2.EmpNo, e2.EmpFirstName, e2.EmpLastName, 2 "subordinate level"
FROM Employee e0
JOIN Employee e1 ON e1.SupEmpNo = e0.EmpNo
JOIN Employee e2 ON e2.SupEmpNo = e1.EmpNo;
/* 
Observation 3:
-- "subordinate level" is not a column name. it is a literal value 
-- being assigned as an alias (i.e. a temporary name for a column or table,
-- and in this case, it is a temporary name for a column) to indicate 
-- hierarchy depth.
*/


/*
Observation 4:
-- Upon reading chapter four in the textbook, I learned that the ORDER BY
-- statement's purpose is to set a specific order for the rows and that it 
-- is not used to order the columns. I knew the SELECT statement ordered the 
-- columns, but I believe that, subconsciously, I deceievd myself into thinking
-- ORDER BY could order the columns.
*/


-- Problem 47 query completed with the help of AI:
-- level 1 superior (direct boss)
SELECT EmpNo,
       EmpFirstName,
       EmpLastName,
       1 AS "Superior Level"
FROM Employee
WHERE EmpNo = (
    SELECT SupEmpNo
    FROM Employee
    WHERE EmpFirstName = 'Joe'
      AND EmpLastName  = 'Jenkins'
)
UNION
-- level 2 superior (boss of direct boss)
SELECT EmpNo,
       EmpFirstName,
       EmpLastName,
       2 AS "Superior Level"
FROM Employee
WHERE EmpNo = (
    SELECT SupEmpNo
    FROM Employee
    WHERE EmpNo = (
        SELECT SupEmpNo
        FROM Employee
        WHERE EmpFirstName = 'Joe'
          AND EmpLastName  = 'Jenkins'
    )
);
/*
Observation 5:
-- What I need to get better at is using the UNION keyword, not only that, but I
-- need to be able to save the values appertaining to the superior level 
-- employees in to a variable (e.g. WHERE EmpNo = (SELECT...FROM...WHERE...AND)).
-- That is the essence of an embedded query.
*/

