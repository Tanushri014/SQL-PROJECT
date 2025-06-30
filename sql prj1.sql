/*EASY
Q1:who is the senior most employee based on job title?
--here we have to find senior employee based on job title so we will use levels 

--here we could have used birthdate of employee to find out senior most employee based on age if required 

--ORDER BY will sort data 
--desc -descending order
--limit will restrict the number of rows returned by query
*/

SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1

/*
Q2:which countries have the most invoices ?

--count(*) will count the total number of invoices per country
-- group by -Groups the results by country.
*/
SELECT 
    COUNT(*) AS invoice_count,
    billing_country
FROM 
    invoice
GROUP BY 
    billing_country
ORDER BY 
    invoice_count DESC;

/*
Q3:what are the top 3 values of total invoice
*/
SELECT 
    total
FROM 
    invoice
ORDER BY 
    total DESC
LIMIT 3;




/*
Q4:which city has the best customers?
we would like to throw a promotional music festival in the city we made the most money .
write a query that returns one city that has the highest sum of invoice totals .
return both city name and sum of all invoice totals
*/

SELECT 
    billing_city,
    SUM(total) AS total_money
FROM 
    invoice
GROUP BY 
    billing_city
ORDER BY 
    total_money DESC
LIMIT 1;


/*
Q5:who is the best customer?
the customer who has spent the most money will be decleared as the best customer.
write a query that returns the person who has spent the most money
*/
/*method 1

--step 1
*/
SELECT 
    customer_id,
    SUM(total) AS total_price
FROM 
    invoice
GROUP BY 
    customer_id
ORDER BY 
    total_price DESC
LIMIT 1;

-- Step 2
SELECT *
FROM customer
WHERE customer_id = 5;




/*method 2 using joins*/

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(invoice.total) AS total
FROM 
    customer
JOIN 
    invoice ON customer.customer_id = invoice.customer_id
GROUP BY 
    customer.customer_id, customer.first_name, customer.last_name
ORDER BY 
    total DESC
LIMIT 1;


/*
MEDIUM QUESTION 
Q1:write a query to return the email ,first name,last name & 
genre of all rock music listeners.
return your list ordered alphabetically by email starting with A

--use distinct two find out the unique values and delete duplicates

--here we have to perform join on 4 tables as per schema 

--we need information from customer and genre table but as there is no common column between them directly so we had to go through multiple tables 
*/

SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name ='Rock'
ORDER BY customer.email;




/*
Q2:lets invite the artists who have written the most rock music in our dataset .
write a query that returns the artist name and total track count of the top 10 rock bands 
*/
SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name='Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

--using subquery
*/

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;




