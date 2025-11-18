-- create database 
drop database bookstore_exam;
create database bookstore;
use bookstore;
-- creating tables
create table books(
Book_ID serial primary key,
Title varchar(100),
Author varchar(100),
Genre varchar(50),
Published_Year int,
Price numeric(10,2),
Stock int);

desc books;

select * from books;

create table customers(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(15),
City varchar(10),
Country varchar(150));

desc customers;

select * from customers;


create table orders(
Order_ID serial primary key,
Customer_ID int references customers (customer_ID),
Book_ID int references books (Book_ID),
Order_Date date,
Quantity int,
Total_Amount numeric(10,2));

desc orders;

select * from orders;


--QUERIES--
-- 1) Retrieve all books in the "Fiction" genre
select * from books where Genre = "Fiction";

-- 2) Find books published after the year 1950
select Title, Published_Year  from books where Published_Year > 1950;

-- 3) List all customers from the Canada
select * from customers where country="Canada";

-- 4) Show orders placed in November 2023

select * from orders where order_date between "2023-11-01" and "2023-11-30";

-- 5) Retrieve the total stock of books available
select sum(stock) as Total_stock from books;

-- 6) Find the details of the most expensive book
select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book

select name, quantity from customers inner join orders using (customer_id) where quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20

select * from orders where Total_amount>20;

-- 9) List all genres available in the Books table

select distinct(genre) from books;

-- 10) Find the book with the lowest stock

select title, stock  from books  order  by stock limit 1 ;

-- 11) Calculate the total revenue generated from all orders

select sum(total_amount) as Revenue from orders;

-- 12)  Retrieve the total number of books sold for each genre

SELECT 
    SUM(quantity) AS 'total_no_books', genre
FROM
    orders
        INNER JOIN
    books USING (book_id)
GROUP BY genre;

-- 13)Find the average price of books in the "Fantasy" genre

select avg(price) as "avg_price",genre from books where genre="Fantasy";

--  14)List customers who have placed at least 2 orders

SELECT 
    customer_id, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY customer_id
HAVING order_count >= 2;

-- 15) Find the most frequently ordered book
select book_id, count(order_id) as order_count ,
    title as book_name from orders inner join  books using (book_id)
group by book_id 
    order by order_count desc limit 1;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre 

select * from books where genre= 'Fantasy' order by price desc limit 3;

-- 17) Retrieve the total quantity of books sold by each author

select sum(quantity) as total_quantity , 
    author from books inner join orders using(book_id) 
    group by author;

-- 18) List the cities where customers who spent over $30 are located

select distinct(city) , total_amount from orders 
    inner join customers using(customer_id)
    where total_amount>30;

-- 19)  Find the customer who spent the most on orders

select customer_id , name , sum(total_amount) as total_spent
from orders inner join customers using(customer_id)
    group by customer_id, name 
order by total_spent  desc limit 1 ;

-- 20) Calculate the stock remaining after fulfilling all orders

SELECT 
    book_id,
    title,
    stock,
    COALESCE(SUM(quantity), 0) AS order_quantity,
    stock - COALESCE(SUM(quantity), 0) AS remaining_quantity
FROM
    books
        LEFT JOIN
    orders USING (book_id)
GROUP BY book_id
ORDER BY book_id;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------




