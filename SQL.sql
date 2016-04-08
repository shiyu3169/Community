DROP DATABASE IF EXISTS Community;
CREATE DATABASE Community;
USE Community;


/* User Table */
DROP TABLE IF EXISTS Users;
CREATE TABLE Users(
	UserID	INT PRIMARY KEY AUTO_INCREMENT,
    UserName 	VARCHAR(50) NOT NULL UNIQUE,
    
    User_Password	VARCHAR(512) NOT NULL, -- in SHA3-512
    User_EMail	VARCHAR(63) NOT NULL UNIQUE,
    
    -- User_RegisterationIpAddress	VARCHAR(45) NOT NULL, -- Maxium length of IPv6 is 45
    User_LoginIpAddress	VARCHAR(45) NOT NULL,    
    
    User_RegisterationTime	DATETIME NOT NULL,
	User_LastLoginTime	DATETIME NOT NULL,
    User_LastPostTime	DATETIME,
    
    User_IsAdministrator	BOOLEAN NOT NULL,
    User_IsBanned	BOOLEAN NOT NULL    
);
DROP PROCEDURE IF EXISTS create_user;
DELIMITER //
CREATE PROCEDURE create_user (
    Given_UserName 	VARCHAR(50),    
    Given_User_Password	VARCHAR(512), -- in SHA3-512
    Given_User_EMail	VARCHAR(63),
    Given_User_LoginIpAddress	VARCHAR(45),        
    Given_User_IsAdministrator	BOOLEAN,
    Given_User_IsBanned	BOOLEAN,
    Given_User_RegisterationTime	DATETIME,
	Given_User_LastLoginTime	DATETIME
    
    -- OUT Out_RegisterationTime DATE,
    -- OUT Out_RegisterationTime DATE,
)
BEGIN
	INSERT INTO Users(
		UserName,
        User_Password,
        User_EMail,
        User_LoginIpAddress,
        User_IsAdministrator,
        User_IsBanned,
		User_RegisterationTime,
		User_LastLoginTime

    ) VALUES (
		Given_UserName,
        Given_User_Password,
        Given_User_EMail,
        Given_User_LoginIpAddress,
        Given_User_IsAdministrator,
        Given_User_IsBanned,
		Given_User_RegisterationTime,
		Given_User_LastLoginTime
	);

END //
CALL create_user("admin", "admin", "admin@admin.org", "127.0.0.1", TRUE, FALSE, NOW(), NOW()) //
DELIMITER ;
DROP PROCEDURE IF EXISTS delete_user;
DELIMITER //
CREATE PROCEDURE delete_user (
	Given_UserName 	VARCHAR(50)
)
BEGIN
	
END//
DELIMITER ;
/* Forums Table */
DROP TABLE IF EXISTS Forums;
CREATE TABLE Forums (
	ForumID	INT PRIMARY KEY AUTO_INCREMENT,
    ParentID	INT,	-- foreign key to ForumID
    ForumName	VARCHAR(50) UNIQUE, -- Forum can be identified by name
    
    Forum_Owner	VARCHAR(50), -- foreign key to Users(Username) to speed up access
    Forum_Catagory	VARCHAR(63),
    Forum_Description VARCHAR(255),
    
    Forum_CreationTime	DATETIME NOT NULL,
    Forum_LastPostTime	DATETIME,
    
    Forum_IsVerified	BOOLEAN,
    CONSTRAINT Forum_fk_Forum
		FOREIGN KEY (ParentID) REFERENCES Forums(ForumID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Forum_fk_User
		FOREIGN KEY (Forum_Owner) REFERENCES Users(UserName)
        ON UPDATE CASCADE ON DELETE SET NULL
);
/* Thread Table */
DROP TABLE IF EXISTS Threads;
CREATE TABLE Threads (
	ThreadID	INT PRIMARY KEY AUTO_INCREMENT,
    ForumID	INT, -- foreign key to Forums(ForumID)
    Thread_Title	VARCHAR(255),
    Thread_Author	VARCHAR(50), -- foreign key to Users(UserName) to speed up access
    Thread_LastUpdator	VARCHAR(50),	-- the last replier or administortor who update it, foreign key to Users(UserName) to speed up access
    
    Thread_CreationTime	DATETIME,
    Thread_LastPostTime	DATETIME,
    
    Thread_IsSticky	BOOLEAN,
    Thread_IsDeleted	BOOLEAN,
    
    CONSTRAINT Thread_fk_Forum
		FOREIGN KEY (ForumID) REFERENCES Forums(ForumID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Thread_Author_fk_User
		FOREIGN KEY (Thread_Author) REFERENCES Users(UserName)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Thread_LastUpdator_fk_User
		FOREIGN KEY (Thread_Author) REFERENCES Users(UserName)
        ON UPDATE CASCADE ON DELETE SET NULL        
);

/* Posts Table */
DROP TABLE IF EXISTS Posts;
CREATE TABLE Posts (
	PostID	INT PRIMARY KEY AUTO_INCREMENT,
    ThreadID	INT, -- foreign key to Threads(ThreadID)
    ReplyToPost	INT, -- foreign key to Post(PostID)
    
    Post_Author	VARCHAR(50),
    Post_LastModifier	VARCHAR(50),
    
    Post_Content	LONGTEXT,
    
    Post_CreationTime	DATETIME NOT NULL,
    Post_LastModificationTime	DATETIME,
    
    Post_IsDeleted	BOOLEAN,
    
    CONSTRAINT Post_fk_Thread
		FOREIGN KEY (ThreadID) REFERENCES Threads(ThreadID)
		ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Post_fk_Post
		FOREIGN KEY (ReplyToPost) REFERENCES Posts(PostID)
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT Post_Author_fk_User
		FOREIGN KEY (Post_Author) REFERENCES Users(UserName)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT Post_LastModifier_fk_User
		FOREIGN KEY (Post_LastModifier) REFERENCES Users(UserName)
        ON UPDATE CASCADE ON DELETE CASCADE
);
/* FavoriteForums Table */
DROP TABLE IF EXISTS FavoriteForums;
CREATE TABLE FavoriteForums (
	UserID	INT,
    ForumID	INT,
    CONSTRAINT FavoriteForum_fk_User
		FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FavoriteForum_fk_Fourm
		FOREIGN KEY (ForumID) REFERENCES Forums(ForumID)
		ON UPDATE CASCADE ON DELETE CASCADE
);
