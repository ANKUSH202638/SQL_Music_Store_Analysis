/*	Question Set 1 - Easy*/

/*1. Who is the senior most employee based on job title?*/
  
SELECT 
    *
FROM
    employee
ORDER BY levels DESC
LIMIT 1

/*2. Which countries have the most Invoices?*/

SELECT 
    COUNT(invoice_id) AS count, billing_country
FROM
    invoice
GROUP BY billing_country
ORDER BY count DESC
LIMIT 1

/*3. What are top 3 values of total invoice?*/

SELECT 
    *
FROM
    invoice
ORDER BY total DESC
LIMIT 3


/*4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
  Write a query that returns one city that has the highest sum of invoice totals. 
  Return both the city name & sum of all invoice totals
*/

SELECT 
    ROUND(SUM(total), 2) AS invoice_totals, billing_city
FROM
    invoice
GROUP BY billing_city
ORDER BY invoice_totals DESC 

/*
Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent the
most money
*/

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    customer.city,
    customer.country,
    ROUND(SUM(invoice.total), 2) AS spent_money
FROM
    invoice
        JOIN
    customer ON invoice.customer_id = customer.customer_id
GROUP BY customer.customer_id, customer.first_name , customer.last_name , customer.city , customer.country
ORDER BY spent_money DESC
LIMIT 1



/*Question Set 2 – Moderate*/

/*
Write query to return the email, first name, last name, & Genre of all Rock Music
listeners. Return your list ordered alphabetically by email starting with A
*/

SELECT DISTINCT
    customer.first_name,
    customer.Last_Name,
    customer.email,
    genre.name
FROM
    customer
        JOIN
    invoice ON customer.customer_id = invoice.customer_id
        JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
        JOIN
    track ON invoice_line.track_id = track.track_id
        JOIN
    genre ON track.genre_id = genre.genre_id
WHERE
    genre.name = 'Rock'
ORDER BY customer.email


/*Let's invite the artists who have written the most rock music in our dataset. Write a
query that returns the Artist name and total track count of the top 10 rock bands*/

SELECT 
    artist.name, COUNT(track.album_id) AS track_count
FROM
    artist
        JOIN
    album2 ON artist.artist_id = album2.album_id
        JOIN
    track ON album2.album_id = track.album_id
        JOIN
    genre ON track.genre_id = genre.genre_id
WHERE
    genre.name = 'Rock'
GROUP BY artist.name
ORDER BY track_count DESC

/*
Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first
*/

SELECT 
    name, milliseconds
FROM
    track
WHERE
    milliseconds > (SELECT 
            AVG(milliseconds) AS song_length
        FROM
            track)
ORDER BY milliseconds


/*
Find how much amount spent by each customer on artists? Write a query to 
return customer name, artist name and total spent
*/

SELECT 
    CONCAT(customer.first_name,
            ' ',
            customer.last_name) AS customer_name,
    artist.name AS artist_name,
    ROUND(SUM(invoice_line.quantity * invoice_line.unit_price ), 2) AS spent_amount
FROM
    customer
        JOIN
    invoice ON invoice.customer_id = customer.customer_id
        JOIN
    invoice_line ON invoice_line.invoice_id = invoice.invoice_id
        JOIN
    track ON track.track_id = invoice_line.track_id
        JOIN
    album2 ON track.album_id = album2.album_id
        JOIN
    artist ON artist.artist_id = album2.artist_id
GROUP BY customer_name , artist_name
ORDER BY spent_amount DESC

