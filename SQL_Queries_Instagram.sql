-- Query
SELECT * from users;

--1 Query- Count the Total number of INSTAGRAM User
SELECT COUNT(*) FROM users;


--2. Query - Searching for Top 10 users , who have been using INSTAGRAM Plateform for the
longest time.

SELECT 
  username, 
  full_name 
from 
  users 
ORDER BY 
  registration_date 
limit 
  10;


3. Query-- Here's an SQL query for
--to determine the best day of the week to launch an advertisement campaign based on user
engagement data.

SELECT 
  EXTRACT(
    DOW 
    FROM 
      Registration_date
  ) AS day_of_week, 
  COUNT(*) AS total_registrations 
FROM 
  users 
GROUP BY 
  day_of_week 
ORDER BY 
  total_registrations DESC 
LIMIT 
  1;
--

SELECT 
  TO_CHAR(Registration_date, 'Day') AS day_name, 
  COUNT(*) AS total_registrations 
FROM 
  users 
GROUP BY 
  day_name 
ORDER BY 
  total_registrations DESC 
LIMIT 
  1;


--Ans. "MONDAY" is the best Day of the week to "launch an advertisement campaign" based
on user maximum users engagement data.

--

--
SELECT * FROM posts;
--
SELECT count(*) FROM posts;


/*4.To find the users who have never posted a single post,
I can use a LEFT JOIN query between the Users table and the Posts table, checking for
NULL values in the Posts.UserID column.
Here is the SQL query - */

SELECT 
  Users.UserID, 
  Users.full_name 
FROM 
  Users 
  LEFT JOIN Posts ON Users.UserID = Posts.UserID 
WHERE 
  Posts.UserID IS NULL;



/* 5.Query-- To count the total number of users who have never posted a single post, I can use
the following SQL query.
I have two tables: one for users (users) and one for posts (posts),
and each post has a userid that corresponds to the user's ID in the users table. */

SELECT 
  COUNT(*) 
FROM 
  users AS u 
  LEFT JOIN posts AS p ON u.userid = p.userid 
WHERE 
  p.postid IS NULL;


-- Ans. Total 20 users ,who have never posted a single post


--
--
SELECT * FROM comments;

-- Query- Total number of comments are commented by users
SELECT COUNT (*) FROM comments;

-- Ans. - There are a total of 139 comments on the post, contributed by various users.

/* 6. Query- To find which UserID has done the most comments in the Comments table,
we can use the COUNT() function along with the GROUP BY and ORDER BY clauses in
SQL.*/

SELECT 
  U.username, 
  cm.UserID, 
  COUNT(*) AS CommentCount 
FROM 
  Comments AS cm 
  INNER JOIN Users AS U ON U.userid = cm.userid 
GROUP BY 
  U.Username, 
  cm.UserID 
ORDER BY 
  CommentCount DESC;



-- 7.Query- getting top 5 user who comments most

SELECT 
  U.full_name, 
  cm.UserID, 
  COUNT(*) AS CommentCount 
FROM 
  Comments AS cm 
  INNER JOIN Users AS U ON U.userid = cm.userid 
GROUP BY 
  U.full_name, 
  cm.UserID 
ORDER BY 
  CommentCount DESC 
LIMIT 
  10;

-- Ans. Pihu Goyal is the user who has commented the most on any post.


/* 8. Query- To get the UserID and Username of users who never commented in the Comments
table,
I can use a query with a LEFT JOIN between the Users table and the Comments table,
followed by filtering with WHERE to check for NULL values in the Comments table.*/

SELECT 
  Users.UserID, 
  Users.full_name 
FROM 
  Users 
  LEFT JOIN Comments ON Users.UserID = Comments.UserID 
WHERE 
  Comments.UserID IS NULL;


/* 9.Query- To count the total number of users who never commented, I can wrap the previous
query in a COUNT() function
or use a similar query structure. Here's the SQL query*/

SELECT 
  COUNT(*) AS TotalUsers_WithoutComments 
FROM 
  Users 
  LEFT JOIN Comments ON Users.UserID = Comments.UserID 
WHERE 
  Comments.UserID IS NULL;


-- Ans. Total 32 users users who never commented a single commented


--
SELECT * FROM Likes;
--
SELECT COUNT(*) FROM Likes;


--10.Query- We have to find out which top 10 post got most number of likes

SELECT 
  PostID, 
  COUNT(*) AS like_count 
FROM 
  Likes 
GROUP BY 
  PostID 
ORDER BY 
  like_count DESC 
LIMIT 
  10;



-- 11.Query - "Identify users who have not liked a single post yet."
/*To identify users who have not liked a single post yet,
I can use a SQL query that leverages a LEFT JOIN to find users who don't have
corresponding entries in the Likes table.
Here's how you can do it:*/

SELECT 
  u.UserID, 
  u.UserName, 
  u.full_name 
FROM 
  Users AS u 
  LEFT JOIN Likes L ON u.UserID = L.UserID 
WHERE 
  L.LikeID IS NULL;


--12. Query To count the number of users who have never liked a single post, you can use a

SELECT 
  COUNT(*) 
FROM 
  Users AS u 
  LEFT JOIN Likes L ON u.UserID = L.UserID 
WHERE 
  L.LikeID IS NULL;

--
/*13. To identify which user's posted content has received the most likes, i can use the following
SQL query.
I have two tables: Posts for the posts and Likes for the likes associated with those posts.*/

SELECT 
  P.UserID, 
  U.Full_Name, 
  SUM(L.like_count) AS Total_Likes 
FROM 
  (
    SELECT 
      PostID, 
      COUNT(*) AS like_count 
    FROM 
      Likes 
    GROUP BY 
      PostID
  ) AS L 
  JOIN Posts AS P ON L.PostID = P.PostID 
  JOIN Users AS U ON P.UserID = U.UserID 
GROUP BY 
  P.UserID, 
  U.Full_Name 
ORDER BY 
  Total_Likes DESC 
LIMIT 
  1;



--


--
SELECT * FROM followers
--
SELECT COUNT(*) FROM followers
--

/*14.To find out which user has the maximum number of followers,
This query counts the number of times each FollowingUserID
appears in the followers table and then identifies the user with the highest count:*/

SELECT 
  FollowingUserID, 
  COUNT(*) AS FollowerCount 
FROM 
  followers 
GROUP BY 
  FollowingUserID 
ORDER BY 
  FollowerCount DESC 
LIMIT 
  10;



--
/*15. Qurey To determine which user has the maximum followers,
I can use an SQL query that counts followers for each FollowerUserID and then retrieves the
user with the highest count.
--I have a separate users table with UserID and UserName
Query to Include User Name*/

SELECT 
  u.full_name, 
  COUNT(f.FollowingUserID) AS follower_count 
FROM 
  followers AS f 
  JOIN users AS u ON f.followingUserID = u.UserID 
GROUP BY 
  f.FollowingUserID, 
  u.full_name 
ORDER BY 
  follower_count DESC 
LIMIT 
  10;



--Query16. 

SELECT DISTINCT(COUNT(*)) FROM hashtags


--
SELECT COUNT(*) from posthashtags

--

--QUERY
--
/*17. To identify the top 5 most commonly used hashtags,
I have a PostHashtags table associating posts with hashtags and a Hashtags table
containing hashtag details,
I can use the following query:*/

SELECT 
  H.Tag, 
  COUNT(PH.HashtagID) AS UsageCount 
FROM 
  PostHashtags AS PH 
  JOIN Hashtags AS H ON PH.HashtagID = H.HashtagID 
GROUP BY 
  H.Tag 
ORDER BY 
  UsageCount DESC 
LIMIT 
  5;


--USER ENGAGEMENT

--18-Query--To calculate the average number of posts per user

SELECT AVG(PostCount) AS AveragePostsPerUser
FROM (SELECT UserID, COUNT(PostID) AS PostCount
FROM Posts GROUP BY UserID
) AS UserPostCounts;


-- Q19.--BOAT and FAKE Account
/*Bots & Fake Accounts IN Task:
Identifying users (potential bots) who have liked every single posts on the site,
as this is not typically possible for a normal user*/


SELECT L.UserID
FROM Likes AS L
GROUP BY L.UserID
HAVING COUNT(L.PostID) = (SELECT COUNT(PostID) FROM Posts);
--

--19. Query-To calculate the number of comments, likes, and follows per user.

SELECT 
  U.UserID, 
  U.Full_Name, 
  COALESCE(CommentStats.CommentCount, 0) AS TotalComments, 
  COALESCE(LikeStats.LikeCount, 0) AS TotalLikes, 
  COALESCE(FollowStats.FollowCount, 0) AS TotalFollows 
FROM 
  Users AS U 
  LEFT JOIN (
    SELECT 
      UserID, 
      COUNT(CommentID) AS CommentCount 
    FROM 
      Comments 
    GROUP BY 
      UserID
  ) AS CommentStats ON U.UserID = CommentStats.UserID 
  LEFT JOIN (
    SELECT 
      UserID, 
      COUNT(LikeID) AS LikeCount 
    FROM 
      Likes 
    GROUP BY 
      UserID
  ) AS LikeStats ON U.UserID = LikeStats.UserID 
  LEFT JOIN (
    SELECT 
      FollowerUserID AS UserID, 
      COUNT(FollowingUserID) AS FollowCount 
    FROM 
      Followers 
    GROUP BY 
      FollowerUserID
  ) AS FollowStats ON U.UserID = FollowStats.UserID;



/*Q20.   To calculate user activity over time, such as comments, likes, and follows, grouped by
specific time periods (e.g., daily, weekly, or monthly) I have tables for Comments, Likes, and
Follower, each with a Date column indicating the time of the action.*/
--SQL Query: Daily User Activity



SELECT 
  ActivityDate, 
  SUM(TotalComments) AS TotalComments, 
  SUM(TotalLikes) AS TotalLikes, 
  SUM(TotalFollows) AS TotalFollows 
FROM 
  (
    SELECT 
      DATE(Comment_Date) AS ActivityDate, 
      COUNT(CommentID) AS TotalComments, 
      0 AS TotalLikes, 
      0 AS TotalFollows 
    FROM 
      Comments 
    GROUP BY 
      DATE(Comment_Date) 
    UNION ALL 
    SELECT 
      DATE(Like_Date) AS ActivityDate, 
      0 AS TotalComments, 
      COUNT(LikeID) AS TotalLikes, 
      0 AS TotalFollows 
    FROM 
      Likes 
    GROUP BY 
      DATE(Like_Date) 
    UNION ALL 
    SELECT 
      DATE(Follow_Date) AS ActivityDate, 
      0 AS TotalComments, 
      0 AS TotalLikes, 
      COUNT(FollowingUserID) AS TotalFollows 
    FROM 
      Followers 
    GROUP BY 
      DATE(Follow_Date)
  ) AS CombinedActivity 
GROUP BY 
  ActivityDate 
ORDER BY 
  ActivityDate ASC;
