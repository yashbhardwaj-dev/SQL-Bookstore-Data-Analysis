USE Bookstore;

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE Genre = "Fiction";

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE Published_Year > 1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE Country = "Canada";

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_Date BETWEEN "2023-11-01" AND "2023-11-30";

-- 5) Retrieve the total stock of books available:
SELECT SUM(Stock) AS Total_Stock
FROM Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders
WHERE Quantity >1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE Total_Amount > 20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT(Genre) FROM Books;

-- 10) Find the book with the lowest stock:
SELECT * FROM Books
ORDER BY Stock
LIMIT 10;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) AS Revenue FROM Orders;

-- Advance Questions : 
SELECT * FROM Orders;
SELECT * FROM Customers;
SELECT * FROM Books;
-- 1) Retrieve the total number of books sold for each genre:
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Books AS b
JOIN Orders o
ON b.Book_ID = o.Order_ID
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(Price) AS Average_Price, Genre
FROM Books
WHERE Genre = "Fantasy";

-- 3) List customers who have placed at least 2 orders:
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT (c.Customer_ID), c.Name, o.Quantity
FROM Customers AS c
JOIN Orders AS o
ON c.Customer_ID = o.Order_ID
HAVING Quantity > 1;


SELECT c.Customer_id, c.Name, COUNT(o.Order_ID) AS Order_Count
FROM Orders AS o
JOIN Customers AS c
ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(Order_ID) >= 2;

-- 4) Find the most frequently ordered book:
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) AS ORDER_COUNT
FROM Orders AS o
JOIN Books AS b
ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY ORDER_COUNT DESC
LIMIT 1;

-- SELECT b.Book_ID, b.Title, b.Genre, o.Order_Date
-- FROM Books AS b
-- JOIN Orders AS o
-- ON b.Book_ID = o.Order_ID
-- ORDER BY o.Order_Date DESC;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT * FROM Books
WHERE Genre = "Fantasy"
ORDER BY Price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Books AS b
JOIN Orders AS o
ON b.Book_id = o.Order_ID
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT DISTINCT c.City, o.Total_Amount
FROM Customers AS c
JOIN Orders AS o
ON c.Customer_ID = o.Order_ID
WHERE o.Total_Amount > 30;

-- 8) Find the customer who spent the most on orders:
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS Total_Spend
FROM Customers AS c
JOIN Orders AS o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spend DESC
LIMIT 10;

-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT b.Book_ID, b.Title, b.Stock, COALESCE(SUM(o.Quantity),0) AS Order_Quantity,
       b.Stock - COALESCE(SUM(o.Quantity),0) AS Remaining_Quantity
FROM Books AS b
LEFT JOIN Orders AS o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;

SELECT b.Book_ID, b.Title, b.Stock, SUM(o.Quantity) - b.Stock AS Remaining_Quantity
FROM Books AS b
LEFT JOIN Orders AS o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;