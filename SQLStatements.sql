

--List the order number for each order placed by customer number 170 on 11/20/2021. 
SELECT INVOICE_NUM
FROM INVOICES
WHERE CUST_ID = 170 AND INVOICE_DATE = '2021-11-20';


--List the number and name of each customer represented by sales rep 30 or sales rep 45.
SELECT CUST_ID, FIRST_NAME, LAST_NAME
FROM CUSTOMER3
WHERE REP_ID IN (30, 45);


--List the item ID and description of each item that is not in category HRS. 
SELECT ITEM_ID, DESCRIPTION
FROM ITEM2
WHERE CATEGORY NOT IN ('HRS');


--List the item ID, description, and number of units on hand for each item that has between 10 and 30 units on hand, including both 10 and 30. Provide two alternate SQL statements to 
--produce the same results.
SELECT ITEM_ID, DESCRIPTION, ON_HAND
FROM ITEM2
WHERE ON_HAND BETWEEN 10 AND 30;

SELECT ITEM_ID, DESCRIPTION, ON_HAND
FROM ITEM2
WHERE ON_HAND >= 10 AND ON_HAND <= 30;


--List the item ID, description, and on-hand value (units on hand * unit price) for each item where on-hand value is less than $1,000. Assign the name VALUE_AVAIL to the computed column.

SELECT I.ITEM_ID, DESCRIPTION, VALUE_AVAIL
FROM ITEM2 AS I JOIN (SELECT (ON_HAND * PRICE) AS VALUE_AVAIL, ITEM_ID 
				  FROM ITEM2) AS V 
	ON I.ITEM_ID = V.ITEM_ID
WHERE VALUE_AVAIL < 1000;


--Use the IN operator to list the item ID and description of each item in category CAT or DOG. 
SELECT ITEM_ID, DESCRIPTION
FROM ITEM2
WHERE CATEGORY IN ('CAT', 'DOG');


--Find the ID, first name, and last name of each customer whose first name begins with the letter “A.” 
SELECT CUST_ID, FIRST_NAME, LAST_NAME
FROM CUSTOMER3
WHERE FIRST_NAME LIKE 'A%';


--How many customers have balances that are more than their credit limits? 
SELECT COUNT (*)
FROM CUSTOMER3
WHERE BALANCE > CREDIT_LIMIT;


--Find the total of the balances for all customers represented by sales rep 30 with balances that are less than their credit limits. 
SELECT SUM (BALANCE)
FROM CUSTOMER3
WHERE REP_ID = 30 AND BALANCE < CREDIT_LIMIT;


--List the item ID, description, and VALUE_AVAIL of each item whose number of units on hand is more than the average number of units on hand for all items. (Hint: Use a subquery.)
SELECT I.ITEM_ID, DESCRIPTION, VALUE_AVAIL
FROM ITEM2 AS I JOIN (SELECT (ON_HAND * PRICE) AS VALUE_AVAIL, ITEM_ID
				  FROM ITEM2) AS V 
	ON I.ITEM_ID = V.ITEM_ID
WHERE ON_HAND > (SELECT AVG (ON_HAND)
				  FROM ITEM2);


--What is the price of the most expensive item in the database?
SELECT ITEM_ID, DESCRIPTION, PRICE
FROM ITEM2 
WHERE PRICE >= ALL (SELECT PRICE 
				  FROM ITEM2);


--What is the item ID, description, and price of the least expensive item in the database? (Hint: Use a subquery.)
SELECT ITEM_ID, DESCRIPTION, PRICE
FROM ITEM2 
WHERE PRICE <= ALL (SELECT PRICE 
				  FROM ITEM2);

 

--List the average of the balances of all customers for each sales rep. Order and group the results by sales rep ID.
SELECT AVG (BALANCE), REP_ID
FROM CUSTOMER3
GROUP BY REP_ID
ORDER BY REP_ID;


--List the item ID and description of all items that are in the DOG or CAT category and contain the word “Small” in the description.
SELECT ITEM_ID, DESCRIPTION
FROM ITEM2 
WHERE CATEGORY IN ('DOG','CAT') AND DESCRIPTION LIKE ('%Small%');


--Scooby’s Pet Supplies is considering discounting the price of all items by 10 percent. List the item ID, description, and discounted price for all items. Use DISCOUNTED_PRICE as the name for 
--the computed column.
SELECT ITEM_ID, DESCRIPTION, (PRICE - (PRICE * 0.1)) AS DISCOUNTED_PRICE
FROM ITEM2 

--For each invoice, list the invoice number and invoice date along with the ID, first name, and last name of the customer for which the invoice was created.
SELECT INVOICE_NUM, INVOICE_DATE, I.CUST_ID, FIRST_NAME, LAST_NAME
FROM INVOICES AS I JOIN CUSTOMER3 AS C
	ON I.CUST_ID = C.CUST_ID

--For each invoice, list the invoice number, invoice date, item ID, quantity ordered, and quoted price for each invoice line that makes up the invoice. 
SELECT I.INVOICE_NUM, INVOICE_DATE, ITEM_ID, QUANTITY, QUOTED_PRICE
FROM INVOICES AS I JOIN INVOICE_LINE AS IL
	ON I.INVOICE_NUM = IL.INVOICE_NUM 


--Use the IN operator to find the ID, first name, and last name of each customer for which an invoice was created on November 15, 2021.

SELECT I.CUST_ID, FIRST_NAME, LAST_NAME
FROM INVOICES AS I JOIN CUSTOMER3 AS C
	ON I.CUST_ID = C.CUST_ID
WHERE INVOICE_DATE LIKE '2021-11-15';


--For each invoice, list the invoice number, invoice date, item ID, description, and category for each item that makes up the invoice.
SELECT I.INVOICE_NUM, INVOICE_DATE, IT.ITEM_ID, DESCRIPTION, CATEGORY
FROM INVOICES AS I JOIN  INVOICE_LINE AS IL
	ON I.INVOICE_NUM  = IL.INVOICE_NUM 
	JOIN ITEM2 AS IT
	ON IT.ITEM_ID = IL.ITEM_ID;


--Use a subquery to find the sales rep ID, first name, and last name of each sales rep who represents at least one customer with a credit limit of $500. List each sales rep only once in the 
--results.

SELECT REP_ID, FIRST_NAME, LAST_NAME
FROM SALES_REP
WHERE REP_ID IN (SELECT REP_ID
				FROM CUSTOMER3
				WHERE CREDIT_LIMIT = 500);

--Repeat Exercise 5, but this time do not use a subquery.
SELECT S.REP_ID, S.FIRST_NAME, S.LAST_NAME
FROM SALES_REP AS S JOIN CUSTOMER3 AS C
	ON S.REP_ID = C.REP_ID
WHERE CREDIT_LIMIT = 500;


--Find the ID, first name, and last name of each customer that currently has an invoice on file for Dog Feeding Station.
SELECT CUST_ID, FIRST_NAME, LAST_NAME
FROM CUSTOMER AS C JOIN INVOICES AS I
	ON C.CUST_ID = I.CUST_ID
	JOIN ITEM2 AS IT
	ON 
WHERE CREDIT_LIMIT = 500;

