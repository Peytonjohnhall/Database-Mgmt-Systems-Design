/* Peyton Hall */

-- DROP TABLE OrdLine;
-- DROP TABLE OrderTbl;
-- DROP TABLE Product;
-- DROP TABLE Employee;
-- DROP TABLE Customer;

-- Problem 3
SELECT ProdMfg, ProdName, ProdNo, ProdQOH, ProdPrice, ProdNextShipDate 
FROM Product WHERE ProdPrice > 50;

-- Problem 13
/*
My attempt:
SELECT CustNo, CustFirstName, CustLastName, CustBal FROM Customer
WHERE CustState = 'WA' AND 
*/
/* Help from ChatGPT: */
SELECT c.CustNo, c.CustFirstName, c.CustLastName, c.CustBal
FROM Customer c
JOIN OrderTbl o
     ON c.CustNo = o.CustNo -- ensures they placed one or more order
WHERE c.CustState = 'WA'
  AND o.OrdDate >= DATE '2021-02-01' -- year, month, day
  AND o.OrdDate <  DATE '2021-03-01' -- year, month, day
GROUP BY c.CustNo, c.CustFirstName, c.CustLastName, c.CustBal; -- removes duplicate rows

-- Problem 17
SELECT c.CustNo, c.CustFirstName, c.CustLastName, o.OrdNo, o.OrdDate, 
e.EmpNo, e.EmpFirstName, e.EmpLastName, p.ProdNo, p.ProdName, (ol.Qty * p.ProdPrice) AS OrderCost
FROM Customer c
JOIN OrderTbl o ON c.CustNo = o.CustNo
JOIN Employee e ON o.EmpNo = e.EmpNo
JOIN OrdLine ol ON o.OrdNo = ol.OrdNo
JOIN Product p ON ol.ProdNo = p.ProdNo
WHERE o.OrdDate = DATE '2021-01-23' -- year, month, day
    AND (ol.Qty * p.ProdPrice) > 150

-- Problem 19
SELECT AVG(CustBal) AS "Average Balance", CustCity, SUBSTR(CustZip, 1, 5) AS "Shortened Zip"
FROM Customer
WHERE CustState = 'WA'
GROUP BY CustCity, SUBSTR(CustZip, 1, 5); -- required or else error will occur

-- Problem 28
SELECT e.EmpNo, e.EmpFirstName, e.EmpLastName,
/* Used ChatGPT for the remainder of the query due to a lack of understanding 
of what "total amount of commissions" means and how to select that. */
        SUM( (ol.Qty * p.ProdPrice) * e.EmpCommRate ) AS TotalCommission
FROM Employee e
JOIN OrderTbl o  ON o.EmpNo = e.EmpNo
JOIN OrdLine ol  ON ol.OrdNo = o.OrdNo
JOIN Product p   ON p.ProdNo = ol.ProdNo
WHERE o.OrdDate >= DATE '2021-01-01' -- year, month, day
  AND o.OrdDate <  DATE '2021-02-01' -- year, month, day
GROUP BY e.EmpNo, e.EmpFirstName, e.EmpLastName

-- Problem 33
SELECT c.CustFirstName, c.CustLastName
FROM Customer c
     JOIN OrderTbl o ON o.CustNo = c.CustNo, -- join operator style (ANSI JOIN)
     Employee e
WHERE e.EmpNo = o.EmpNo
  AND e.EmpFirstName = 'Amy'
  AND e.EmpLastName  = 'Tang'
ORDER BY c.CustFirstName, c.CustLastName;

-- Problem 42
SELECT p.ProdNo, p.ProdName, p.ProdPrice
SUM(p.ProdPrice * ol.Qty) AS TotalOrderValue
FROM Product p
/* Received assistance from AI to write the join statements */
     JOIN OrdLine ol ON p.ProdNo = ol.ProdNo  -- need quantity
     JOIN OrderTbl o ON o.OrdNo = ol.OrdNo -- need order date
     JOIN Customer c ON o.CustNo = c.CustNo -- need colorado customers
WHERE c.CustState = 'CO'
  AND o.OrdDate BETWEEN DATE '2021-01-01' AND DATE '2021-01-31'
  AND o.EmpNo IS NOT NULL
GROUP BY p.ProdNo, p.ProdName, p.ProdPrice; -- compute total value per product

-- Problem 47
/* not sure how to do this one */

-- Problem 52
SELECT c.CustNo, c.CustFirstName, c.CustLastName,
    o.OrdNo, o.OrdDate,
    p.ProdNo, p.ProdName, p.ProdPrice
FROM OrderTbl o
     JOIN OrdLine ol ON o.OrdNo = ol.OrdNo
     JOIN Product p ON ol.ProdNo = p.ProdNo
     JOIN Customer c ON o.CustNo = c.CustNo
WHERE c.CustState = 'WA'
  AND p.ProdPrice > 100;
/* 
What was missing/ wrong:
- there were no aliases yet multiple tables being referenced
- missing join condition between Product and OrdLine
- join conditions between primary and foreign keys were written in 
  the WHERE clause instead of using explicit JOIN ... ON syntax
*/

-- Problem 55
SELECT c.CustNo, c.CustFirstName, c.CustLastName,
       ol.Qty, p.ProdPrice,
       (ol.Qty * p.ProdPrice) AS LineOrdAmt
FROM OrderTbl o
JOIN OrdLine ol ON o.OrdNo = ol.OrdNo
JOIN Product p ON ol.ProdNo = p.ProdNo
JOIN Customer c ON c.CustNo = o.CustNo
WHERE o.OrdDate BETWEEN DATE '2021-01-01' AND DATE '2021-01-31'
  AND (p.ProdName LIKE '%Ink Jet%' OR p.ProdName LIKE '%Laser%');
/*
What was changed:
- added aliases
- removed the aggregate function SUM()
- removed GROUP BY and HAVING to show intermediate (i.e. before GROUP BY 
  and aggregate functions are applied) rows
- replaced SUM(Qty) with individual Qty values
- replaced SUM(Qty*ProdPrice) with computed line amount (Qty*ProdPrice)
- kept joins and filters the same to preserve logic
*/