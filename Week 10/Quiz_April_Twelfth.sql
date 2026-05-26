CREATE TABLE Question_TwentyNine (
    row_one VARCHAR(5) NOT NULL,
    row_two NUMBER NOT NULL
);

DROP TABLE Question_TwentyNine;

INSERT INTO Question_TwentyNine VALUES ('abc', 123);
INSERT INTO Question_TwentyNine VALUES ('def', 456);

SELECT * FROM Question_TwentyNine;

-- alter the table to add a new column with a default
ALTER TABLE Question_TwentyNine
ADD Salary DECIMAL(10,2) DEFAULT 0.00; -- add Salary column

-- check if the defaults were applied to the existing rows
SELECT * FROM Question_TwentyNine;

-- add another row to see if the default was applied
INSERT INTO Question_TwentyNine (row_one, row_two, Salary) VALUES ('def', 456, 5);
-- see if default was applied
SELECT * FROM Question_TwentyNine;