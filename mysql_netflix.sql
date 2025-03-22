show databases;
use bigdata;
show tables;
select * from netflix_users; -- showing the table
describe netflix_users;   -- details about the table
select count(*) from netflix_users;--  no of the rows


-- Basic User Information
-- 1.	How many total users are in the dataset?
SELECT COUNT(*) AS Total_Users FROM netflix_users;

-- 2.	List all unique subscription plans.
SELECT DISTINCT Subscription_Type FROM netflix_users;

-- 3.	Count how many users are in each subscription plan.
SELECT Subscription_Type, COUNT(*) AS User_Count FROM netflix_users GROUP BY Subscription_Type;

-- 4.	Find all users who joined in the last 6 months.
SELECT * FROM netflix_users WHERE Last_Login >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 5.	Show a list of users who have never watched any content.
SELECT * FROM netflix_users WHERE Watch_Time_Hours=0;


-- User Activity Analysis
-- 6.	Find the 5 users who have watched the most content.
SELECT * FROM netflix_users ORDER BY Watch_Time_Hours DESC LIMIT 5;


-- 7.	Show a list of users who have cancelled their subscriptions.
select Name, Subscription_Type from netflix_users where Subscription_Type = 'Premium';

-- 8.	Find the average watch time per user.
select name,avg(Watch_Time_Hours) as avg_time from netflix_users group by name;

-- 9.	List all unique movie genres watched by users.
SELECT DISTINCT Favorite_Genre FROM netflix_users;

-- 10.	Find the least-watched genre.
select favorite_genre, sum(watch_time_hours) as total_watch_time from netflix_users  
group by favorite_genre  order by total_watch_time asc limit 1;


-- Subscription & Revenue
-- 11.	Find the total revenue from active subscriptions.
select sum(case  when subscription_type = 'basic' then 8.99 
when subscription_type = 'standard' then 13.99  when subscription_type = 'premium' then 17.99  end) as total_revenue  from netflix_users;  

-- 12.	Count how many users joined in each month. 
SELECT DATE_FORMAT(max(Last_Login), '%Y-%m') AS Month, COUNT(User_ID) AS User_Count FROM netflix_users
GROUP BY Last_Login
ORDER BY Month desc;

-- 13.	List all users who have a watch time greater than the average watch time 
SELECT * 
FROM netflix_users 
WHERE Watch_Time_Hours > (SELECT AVG(Watch_Time_Hours) FROM netflix_users);

-- 14.	Find the user with the longest watch time in each country.
SELECT n.Country, n.User_ID, n.Name, n.Watch_Time_Hours AS Longest_Watch_Time
FROM netflix_users n
JOIN (
    SELECT Country, MAX(Watch_Time_Hours) AS Max_Watch_Time
    FROM netflix_users
    GROUP BY Country
) m ON n.Country = m.Country AND n.Watch_Time_Hours = m.Max_Watch_Time;

-- 15.	Find the total watch time for each country.  ==>Nived.15
SELECT Country, SUM(Watch_Time_Hours) AS Total_Watch_Time FROM netflix_users GROUP BY Country;

-- Content Preferences
-- 16.	Find the most-watched Favorite_Genre in movie or series.==>Swetha.16
SELECT Favorite_Genre, COUNT(*) AS Watch_Count FROM netflix_users 
GROUP BY Favorite_Genre ORDER BY Watch_Count DESC LIMIT 1;

-- 17.	Find the least-watched Favorite_Genre in movie or series.==>Swetha.17
SELECT Favorite_Genre, COUNT(*) AS Watch_Count FROM netflix_users 
GROUP BY Favorite_Genre ORDER BY Watch_Count LIMIT 1;


-- 18.	Count how many users prefer action movies.==>Swetha.18
SELECT COUNT(*) AS Action_User_Count
FROM netflix_users  where Favorite_Genre = 'Action';

-- 19.	Show the top 3 most binge-watched shows.==>
SELECT Favorite_Genre, SUM(Watch_Time_Hours) AS Total_Watch_Hours
FROM netflix_users
GROUP BY Favorite_Genre
ORDER BY Total_Watch_Hours DESC
LIMIT 3;   -- ROhith 19


-- 20. Find the most common time of day users watch Netflix
SELECT Watch_Time_Hours, COUNT(*) AS watch_count
FROM netflix_users
GROUP BY Watch_Time_Hours
ORDER BY watch_count DESC
LIMIT 1;

-- 21.	Show the top 3 regions with the most Netflix users.==> rohith.21
SELECT Country, COUNT(*) AS User_Count FROM netflix_users
GROUP BY Country ORDER BY User_Count DESC LIMIT 3;

