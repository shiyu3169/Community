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
DROP FUNCTION IF EXISTS create_user;
DELIMITER //
CREATE FUNCTION create_user (
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
RETURNS INT
BEGIN
	DECLARE result INT;
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
    RETURN LAST_INSERT_ID();

END //
SELECT (create_user("admin", "admin", "admin@admin.org", "127.0.0.1", TRUE, FALSE, NOW(), NOW())) //
-- SELECT (create_forums("admin", "admin", "admin@admin.org", "127.0.0.1", TRUE, FALSE, NOW(), NOW())) //
DELIMITER ;
DROP PROCEDURE IF EXISTS delete_user;
DELIMITER //
CREATE PROCEDURE delete_user (
	Given_UserName 	VARCHAR(50)
)
BEGIN
	DELETE FROM Users WHERE UserName = Given_UserName;
END//
DROP FUNCTION IF EXISTS user_login_validation//
CREATE FUNCTION user_login_validation(
	Given_UserName VARCHAR(50),
    Given_User_Password VARCHAR(512))
RETURNS BOOLEAN
BEGIN
	RETURN EXISTS(SELECT * FROM Users 
		WHERE UserName = Given_UserName AND User_Password = Given_User_Password);
END//
DELIMITER ;
SELECT user_login_validation("admin","admin");
CALL delete_user("admin");
SELECT user_login_validation("admin","admin");

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
DROP FUNCTION IF EXISTS create_forum;
DELIMITER //
CREATE FUNCTION create_forum (
	-- ForumID	INT,
    Given_ParentID	INT,	-- foreign key to ForumID
    Given_ForumName	VARCHAR(50), -- Forum can be identified by name
    
    Given_Forum_Owner	VARCHAR(50), -- foreign key to Users(Username) to speed up access
    Given_Forum_Catagory	VARCHAR(63),
    Given_Forum_Description VARCHAR(255),
    
    Given_Forum_CreationTime	DATETIME,
    -- Given_Forum_LastPostTime	DATETIME,
    
    Given_Forum_IsVerified	BOOLEAN
)
RETURNS INT
BEGIN
	INSERT INTO Forums(
		ParentID,	-- foreign key to ForumID
		ForumName, -- Forum can be identified by name
    
		Forum_Owner, -- foreign key to Users(Username) to speed up access
		Forum_Catagory,
		Forum_Description,
    
		Forum_CreationTime,
		-- Forum_LastPostTime,
    
		Forum_IsVerified

    ) VALUES (
		Given_ParentID,	-- foreign key to ForumID
		Given_ForumName, -- Forum can be identified by name
    
		Given_Forum_Owner, -- foreign key to Users(Username) to speed up access
		Given_Forum_Catagory,
		Given_Forum_Description,
    
		Given_Forum_CreationTime,
		-- Given_Forum_LastPostTime,
    
		Given_Forum_IsVerified
	);
    RETURN LAST_INSERT_ID();
END//
DELIMITER ;
SELECT create_user("admin", "admin", "admin@admin.org", "127.0.0.1", TRUE, FALSE, NOW(), NOW());
SELECT create_forum(NULL,	
		"Root", 
		"admin", 
		"Forum_Catagory",
		"Forum_Description",
		NOW(),
		TRUE);
SELECT create_forum(1,	
		"Cats", 
		"admin", 
		"Forum_Catagory",
		"Forum_Description",
		NOW(),
		TRUE);
SELECT create_forum(1,	
		"Hello Kitty", 
		"admin", 
		"Forum_Catagory",
		"Forum_Description",
		NOW(),
		TRUE);
SELECT create_forum(1,	
		"Big Face Cat", 
		"admin", 
		"Forum_Catagory",
		"Forum_Description",
		NOW(),
		TRUE);   
SELECT create_forum(1,	
		"Garfield", 
		"admin", 
		"Forum_Catagory",
		"Forum_Description",
		NOW(),
		TRUE);
SELECT create_forum(1,	
		"Doraemon", 
		"admin", 
		"Forum_Catagory",
		"Forum_Description",
		NOW(),
		TRUE);
DELIMITER //
DROP PROCEDURE IF EXISTS search_forum_by_name//
CREATE PROCEDURE search_forum_by_name(
	Given_ForumName VARCHAR(50)
)
BEGIN
	SELECT * FROM Forums WHERE ForumName LIKE concat('%',Given_ForumName,'%');
END//
CALL search_forum_by_name('Cat')//
CALL search_forum_by_name('Doraemon')//
DELIMITER ;
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
DELIMITER //
DROP FUNCTION IF EXISTS create_thread//
CREATE FUNCTION create_thread(
    Given_ForumID	INT, -- foreign key to Forums(ForumID)
    Given_Thread_Title	VARCHAR(255),
    Given_Thread_Author	VARCHAR(50), -- foreign key to Users(UserName) to speed up access
    Given_Thread_LastUpdator	VARCHAR(50),	-- the last replier or administortor who update it, foreign key to Users(UserName) to speed up access
    
    Given_Thread_CreationTime	DATETIME,
    Given_Thread_LastPostTime	DATETIME,
    
    Given_Thread_IsSticky	BOOLEAN,
    Given_Thread_IsDeleted	BOOLEAN)
RETURNS INT
BEGIN
	INSERT INTO Threads(
		ForumID,
		Thread_Title,
		Thread_Author,
		Thread_LastUpdator,
    
		Thread_CreationTime,
		Thread_LastPostTime,
    
		Thread_IsSticky,
		Thread_IsDeleted
    ) VALUES (
		Given_ForumID,
		Given_Thread_Title,
		Given_Thread_Author,
		Given_Thread_LastUpdator,
    
		Given_Thread_CreationTime,
		Given_Thread_LastPostTime,
    
		Given_Thread_IsSticky,
		Given_Thread_IsDeleted
	);
    RETURN LAST_INSERT_ID();
END//
DELIMITER ;
SELECT create_thread(
		1,
		"Is Hello Kitty cat?",
		"admin",
		"admin",
    
		NOW(),
		NOW(),
    
		FALSE,
		FALSE);
SELECT create_thread(
		2,
		"Is Hello Kitty cat?",
		"admin",
		"admin",
    
		NOW(),
		NOW(),
    
		FALSE,
		FALSE);
SELECT create_thread(
		3,
		"Is Hello Kitty cat?",
		"admin",
		"admin",
    
		NOW(),
		NOW(),
    
		FALSE,
		FALSE);
SELECT create_thread(
		3,
		"Is Hello Kitty cat?",
		"admin",
		"admin",
    
		NOW(),
		NOW(),
    
		FALSE,
		FALSE);

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