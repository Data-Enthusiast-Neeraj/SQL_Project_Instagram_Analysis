-- Drop the database if it exists
   --DROP DATABASE IF EXISTS "Project Instagram";

-- Create the database
   --CREATE DATABASE "SQL Project Instagram";

-- use to the database
   -- USE "SQL Project Instagram";

--Table 1- User Entity
    CREATE TABLE   Users (
    UserID  SERIAL  PRIMARY KEY,    -- Unique identifier for each user
    Username  VARCHAR(50)  NOT NULL  UNIQUE,    -- Chosen username (must be unique)
    Email   VARCHAR(255)  NOT NULL UNIQUE, -- Email address (must be unique)
    Full_Name  VARCHAR(100), -- Full name of the user
    Bio  TEXT, -- Brief description or bio
    Registration_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP );                 -- Date of registration with default to current timestamp



-- Table 2: Post Entity
CREATE TABLE  Posts (
    PostID  SERIAL PRIMARY KEY, -- Unique identifier for each post
    UserID   INT   NOT NULL, -- User who created the post
    Caption  TEXT, -- Text accompanying the post
    Image_URL  TEXT   NOT NULL, -- URL of the image or video content
    Location   VARCHAR(100), -- Tagged location
    Post_Date  TIMESTAMP  DEFAULT   CURRENT_TIMESTAMP, -- Date of post creation
    FOREIGN KEY (UserID) REFERENCES  Users(UserID) ON DELETE CASCADE ); -- Foreign key referencing Users table


-- Table 3: Comment
CREATE TABLE   Comments (
    CommentID SERIAL PRIMARY KEY, -- Unique identifier for each comment
    PostID INT NOT NULL, -- The post being commented on
    UserID INT NOT NULL, -- The user who posted the comment
    Text TEXT NOT NULL, -- The text of the comment
    Comment_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date when the comment was posted
    FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE, -- Foreign key referencing Posts table
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ); -- Foreign key referencing Users table




-- Table 4: Like Entity
CREATE TABLE   Likes (
    LikeID SERIAL PRIMARY KEY, -- Unique identifier for each like
    PostID INT NOT NULL, -- The post being liked
    UserID INT NOT NULL, -- The user who liked the post
    Like_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date when the like was registered
    FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE, -- Foreign key referencing Posts table
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE );
 -- Foreign key referencing Users table








-- Table 5: Followers Entity

CREATE TABLE Followers (
    FollowerID SERIAL PRIMARY KEY, -- Unique identifier for each follower relationship
    FollowingUserID INT NOT NULL, -- The user who is being followed
    FollowerUserID INT NOT NULL, -- The user who is following
    Follow_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date when the following relationship was initiated
    FOREIGN KEY (FollowingUserID) REFERENCES Users(UserID) ON DELETE CASCADE, -- References Users table for the followed user
    FOREIGN KEY (FollowerUserID) REFERENCES Users(UserID) ON DELETE CASCADE )-- References Users table for the follower
    




-- Table 6: Hashtag Entity
CREATE TABLE   Hashtags (
    HashtagID SERIAL PRIMARY KEY, -- Unique identifier for each hashtag
    Tag VARCHAR(100) NOT NULL UNIQUE ) ; -- The actual text of the hashtag 
 



-- Table 7: PostHashtag Entity
CREATE TABLE   PostHashtags (
    PostHashtagID SERIAL PRIMARY KEY, -- Unique identifier for each association
    PostID INT NOT NULL, -- The post associated with the hashtag
    HashtagID INT NOT NULL, -- The hashtag associated with the post
    FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE, -- References Posts table
    FOREIGN KEY (HashtagID) REFERENCES Hashtags(HashtagID) ON DELETE CASCADE, -- References Hashtags table
  UNIQUE   (PostID, HashtagID) ); -- Ensure a post cannot have the same hashtag multiple times



