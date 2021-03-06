DROP DATABASE IF EXISTS Community;
CREATE DATABASE Community;
USE Community;


/* User Table */
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    UserName VARCHAR(50) PRIMARY KEY,
    User_Password VARCHAR(512) NOT NULL,
    User_EMail VARCHAR(63) NOT NULL UNIQUE,
    User_LoginIpAddress VARCHAR(45) NOT NULL,
    User_RegisterationTime DATETIME NOT NULL,
    User_LastLoginTime DATETIME NOT NULL,
    User_LastPostTime DATETIME,
    User_IsAdministrator BOOLEAN NOT NULL,
    User_IsBanned BOOLEAN NOT NULL,
    User_Gender CHAR(1),
    User_Autobiography LONGTEXT,
    User_DateOfBirth DATE,
    User_NumberOfNewMessages INT NOT NULL
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
	Given_User_LastLoginTime	DATETIME,

    Given_User_Gender CHAR(1),
    Given_User_Autobiography LONGTEXT,
	Given_User_DateOfBirth	DATE,
    
    Given_User_NumberOfNewMessages INT
    -- OUT Out_RegisterationTime DATE,
    -- OUT Out_RegisterationTime DATE,
)
RETURNS VARCHAR(50)
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
		User_LastLoginTime,
		User_Gender,
		User_Autobiography,
		User_DateOfBirth,
		User_NumberOfNewMessages
    ) VALUES (
		Given_UserName,
        Given_User_Password,
        Given_User_EMail,
        Given_User_LoginIpAddress,
        Given_User_IsAdministrator,
        Given_User_IsBanned,
		Given_User_RegisterationTime,
		Given_User_LastLoginTime,
		Given_User_Gender,
		Given_User_Autobiography,
        Given_User_DateOfBirth,
        Given_User_NumberOfNewMessages
	);
    RETURN Given_UserName;

END //
SELECT 
    (CREATE_USER('admin',
            'admin',
            'admin@admin.org',
            '127.0.0.1',
            TRUE,
            FALSE,
            NOW(),
            NOW(),
            NULL,
            NULL,
            NULL,
            0))//
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
DROP PROCEDURE IF EXISTS update_user //
CREATE PROCEDURE update_user (
	Old_UserName 	VARCHAR(50),
	New_UserName VARCHAR(50),
    New_User_Password VARCHAR(512),
    New_User_EMail VARCHAR(63),
    New_User_IsAdministrator BOOLEAN,
    New_User_IsBanned BOOLEAN,
    New_User_Gender CHAR(1),
    New_User_Autobiography LONGTEXT,
    New_User_DateOfBirth DATE
)
BEGIN
	UPDATE Users SET 
		UserName = New_UserName,
		User_Password = New_User_Password,
		User_EMail = New_User_EMail,
		User_IsAdministrator = New_User_IsAdministrator,
		User_IsBanned = New_User_IsBanned,
		User_Gender = New_User_Gender,
		User_Autobiography = New_User_Autobiography,
		User_DateOfBirth = New_User_DateOfBirth
		WHERE UserName = Old_UserName LIMIT 1;
END//
DROP FUNCTION IF EXISTS user_login_validation//
CREATE FUNCTION user_login_validation(
	Given_UserName VARCHAR(50),
    Given_User_Password VARCHAR(512))
RETURNS BOOLEAN
BEGIN
	UPDATE Users SET User_LastLoginTime = NOW()
		WHERE UserName = Given_UserName AND User_Password = Given_User_Password AND User_IsBanned=FALSE LIMIT 1;
	RETURN EXISTS(SELECT * FROM Users 
		WHERE UserName = Given_UserName AND User_Password = Given_User_Password  AND User_IsBanned = FALSE);
END//
DELIMITER ;
SELECT USER_LOGIN_VALIDATION('admin', 'admin');
CALL delete_user("admin");
SELECT USER_LOGIN_VALIDATION('admin', 'admin');
DELIMITER //
DROP PROCEDURE IF EXISTS get_user_by_name//
CREATE PROCEDURE get_user_by_name (
	Given_UserName VARCHAR(50)
)
BEGIN
	SELECT * FROM Users WHERE UserName = Given_UserName;
END//
DELIMITER;
CALL get_user_by_name("admin");
/* Forums Table */
DROP TABLE IF EXISTS Forums;
DELIMITER //
CREATE TABLE Forums (
    ForumID INT PRIMARY KEY AUTO_INCREMENT,
    ParentID INT,
    ForumName VARCHAR(50) UNIQUE,
    Forum_Owner VARCHAR(50),
    Forum_Category VARCHAR(63),
    Forum_Description VARCHAR(255),
    Forum_CreationTime DATETIME NOT NULL,
    Forum_LastPostTime DATETIME,
    Forum_IsVerified BOOLEAN,
    CONSTRAINT Forum_fk_Forum FOREIGN KEY (ParentID)
        REFERENCES Forums (ForumID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Forum_fk_User FOREIGN KEY (Forum_Owner)
        REFERENCES Users (UserName)
        ON UPDATE CASCADE ON DELETE CASCADE
)//
DROP FUNCTION IF EXISTS create_forum//
DELIMITER //
CREATE FUNCTION create_forum (
	-- ForumID	INT,
    Given_ParentID	INT,	-- foreign key to ForumID
    Given_ForumName	VARCHAR(50), -- Forum can be identified by name
    
    Given_Forum_Owner	VARCHAR(50), -- foreign key to Users(Username) to speed up access
    Given_Forum_Category	VARCHAR(63),
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
		Forum_Category,
		Forum_Description,
    
		Forum_CreationTime,
		-- Forum_LastPostTime,
    
		Forum_IsVerified

    ) VALUES (
		Given_ParentID,	-- foreign key to ForumID
		Given_ForumName, -- Forum can be identified by name
    
		Given_Forum_Owner, -- foreign key to Users(Username) to speed up access
		Given_Forum_Category,
		Given_Forum_Description,
    
		Given_Forum_CreationTime,
		-- Given_Forum_LastPostTime,
    
		Given_Forum_IsVerified
	);
    RETURN LAST_INSERT_ID();
END//
DELIMITER ;
SELECT 
    CREATE_USER('admin',
            'admin',
            'admin@admin.org',
            '127.0.0.1',
            TRUE,
            FALSE,
            NOW(),
            NOW(),
            NULL,
            NULL,
            NULL,
            0);
SELECT 
    CREATE_FORUM(NULL,
            'Root',
            'admin',
            'Forum_Category',
            'Forum_Description',
            NOW(),
            TRUE);
SELECT 
    CREATE_FORUM(1,
            'Cats',
            'admin',
            'Forum_Category',
            'Forum_Description',
            NOW(),
            TRUE);
SELECT 
    CREATE_FORUM(1,
            'Hello Kitty',
            'admin',
            'Forum_Category',
            'Forum_Description',
            NOW(),
            TRUE);
SELECT 
    CREATE_FORUM(1,
            'Big Face Cat',
            'admin',
            'Forum_Category',
            'Forum_Description',
            NOW(),
            TRUE);
SELECT 
    CREATE_FORUM(1,
            'Garfield',
            'admin',
            'Forum_Category',
            'Forum_Description',
            NOW(),
            TRUE);
SELECT 
    CREATE_FORUM(1,
            'Doraemon',
            'admin',
            'Forum_Category',
            'Forum_Description',
            NOW(),
            TRUE);
DELIMITER //
DROP PROCEDURE IF EXISTS update_forum//
CREATE PROCEDURE update_forum (
	Given_ForumID	INT,
    Given_ParentID	INT,	-- foreign key to ForumID
    Given_ForumName	VARCHAR(50), -- Forum can be identified by name
    
    Given_Forum_Owner	VARCHAR(50), -- foreign key to Users(Username) to speed up access
    Given_Forum_Category	VARCHAR(63),
    Given_Forum_Description VARCHAR(255),
    
    -- Given_Forum_CreationTime	DATETIME,
    -- Given_Forum_LastPostTime	DATETIME,
    
    Given_Forum_IsVerified	BOOLEAN
)
BEGIN
	UPDATE Forums SET
			ForumID = Given_ForumID,
			ParentID = Given_ParentID,	-- foreign key to ForumID
			ForumName = Given_ForumName, -- Forum can be identified by name
			
			Forum_Owner = Given_Forum_Owner, -- foreign key to Users(Username) to speed up access
			Forum_Category = Given_Forum_Category,
			Forum_Description = Given_Forum_Description,
			
			-- Given_Forum_CreationTime	DATETIME,
			-- Given_Forum_LastPostTime	DATETIME,
			
			Forum_IsVerified = Given_Forum_IsVerified
		WHERE ForumID = Given_ForumID;
		
END//
CALL update_forum(1,
    NULL,	-- foreign key to ForumID
    "Given_ForumName	VARCHAR(50)", -- Forum can be identified by name
    
    "admin", -- foreign key to Users(Username) to speed up access
    "Given_Forum_Category	VARCHAR(63)",
    "Given_Forum_Description VARCHAR(255)",
    
    -- Given_Forum_CreationTime	DATETIME,
    -- Given_Forum_LastPostTime	DATETIME,
    
    TRUE)//

DROP PROCEDURE IF EXISTS search_forum_by_name //
CREATE PROCEDURE search_forum_by_name(
	Given_ForumName VARCHAR(50)
)
BEGIN
	SELECT * FROM Forums WHERE ForumName LIKE concat('%',Given_ForumName,'%');
END//
CALL search_forum_by_name('Cat')//
CALL search_forum_by_name('Doraemon')//
DROP PROCEDURE IF EXISTS get_forum_by_id//
CREATE PROCEDURE get_forum_by_id(
	Given_ForumID VARCHAR(50)
)
BEGIN
	SELECT * FROM Forums WHERE ForumID = Given_ForumID LIMIT 1;
END// 
DELIMITER ;
CALL get_forum_by_id(3);
DELIMITER //
DROP PROCEDURE IF EXISTS get_all_forums//
CREATE PROCEDURE get_all_forums()
BEGIN
	SELECT * FROM Forums;
END//
DROP PROCEDURE IF EXISTS get_child_forums//
CREATE PROCEDURE get_child_forums(
	Given_ParentID INT)
BEGIN
	SELECT * FROM Forums WHERE ParentID = Given_ParentID;
END//
DELIMITER ;
DROP PROCEDURE IF EXISTS delete_forum;
DELIMITER //
CREATE PROCEDURE delete_forum (
	Given_ForumID INT
)
BEGIN
	DELETE FROM Forums WHERE ForumID = Given_ForumID;
END//
/* Thread Table */
DELIMITER ;
DROP TABLE IF EXISTS Threads;
CREATE TABLE Threads (
    ThreadID INT PRIMARY KEY AUTO_INCREMENT,
    ForumID INT,
    Thread_Title VARCHAR(255),
    Thread_Author VARCHAR(50),
    Thread_LastUpdator VARCHAR(50),
    Thread_CreationTime DATETIME,
    Thread_LastUpdateTime DATETIME,
    Thread_IsSticky BOOLEAN,
    Thread_IsDeleted BOOLEAN,
    Thread_NumberOfViews INT NOT NULL,
    CONSTRAINT Thread_fk_Forum FOREIGN KEY (ForumID)
        REFERENCES Forums (ForumID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Thread_Author_fk_User FOREIGN KEY (Thread_Author)
        REFERENCES Users (UserName)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Thread_LastUpdator_fk_User FOREIGN KEY (Thread_Author)
        REFERENCES Users (UserName)
        ON UPDATE CASCADE ON DELETE CASCADE
);

DELIMITER //
DROP FUNCTION IF EXISTS create_thread//
CREATE FUNCTION create_thread(
    Given_ForumID	INT, -- foreign key to Forums(ForumID)
    Given_Thread_Title	VARCHAR(255),
    Given_Thread_Author	VARCHAR(50), -- foreign key to Users(UserName) to speed up access
    Given_Thread_LastUpdator	VARCHAR(50),	-- the last replier or administortor who update it, foreign key to Users(UserName) to speed up access
    
    Given_Thread_CreationTime	DATETIME,
    Given_Thread_LastUpdateTime	DATETIME,
    
    Given_Thread_IsSticky	BOOLEAN,
    Given_Thread_IsDeleted	BOOLEAN
    -- Given_Thread_NumberOfViews	INT
)
RETURNS INT
BEGIN
	INSERT INTO Threads(
		ForumID,
		Thread_Title,
		Thread_Author,
		Thread_LastUpdator,
    
		Thread_CreationTime,
		Thread_LastUpdateTime,
    
		Thread_IsSticky,
		Thread_IsDeleted,
        Thread_NumberOfViews
    ) VALUES (
		Given_ForumID,
		Given_Thread_Title,
		Given_Thread_Author,
		Given_Thread_LastUpdator,
    
		Given_Thread_CreationTime,
		Given_Thread_LastUpdateTime,
    
		Given_Thread_IsSticky,
		Given_Thread_IsDeleted,
        0
	);
    RETURN LAST_INSERT_ID();
END//
DELIMITER ;
SELECT 
    CREATE_THREAD(1,
            'Is Hello Kitty cat?',
            'admin',
            'admin',
            NOW(),
            NOW(),
            FALSE,
            FALSE);
SELECT 
    CREATE_THREAD(2,
            'Is Hello Kitty cat?',
            'admin',
            'admin',
            NOW(),
            NOW(),
            FALSE,
            FALSE);
SELECT 
    CREATE_THREAD(3,
            'Is Hello Kitty cat?',
            'admin',
            'admin',
            NOW(),
            NOW(),
            FALSE,
            FALSE);
SELECT 
    CREATE_THREAD(3,
            'Is Hello Kitty cat?',
            'admin',
            'admin',
            NOW(),
            NOW(),
            FALSE,
            FALSE);
DELIMITER //
DROP PROCEDURE IF EXISTS get_thread_list_by_forumID//
CREATE PROCEDURE get_thread_list_by_forumID(
	Given_ForumID INT
)
BEGIN
	SELECT * FROM Threads WHERE ForumID = Given_ForumID AND Thread_IsDeleted = FALSE ORDER BY Thread_IsSticky;
END//
DELIMITER ;
CALL get_thread_list_by_forumID(3);
/* Posts Table */
DROP TABLE IF EXISTS Posts;
CREATE TABLE Posts (
    PostID INT PRIMARY KEY AUTO_INCREMENT,
    ThreadID INT,
    ReplyToPost INT,
    Post_Author VARCHAR(50),
    Post_Content LONGTEXT,
    Post_CreationTime DATETIME NOT NULL,
    Post_LastModificationTime DATETIME,
    Post_IsDeleted BOOLEAN,
    CONSTRAINT Post_fk_Thread FOREIGN KEY (ThreadID)
        REFERENCES Threads (ThreadID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Post_fk_Post FOREIGN KEY (ReplyToPost)
        REFERENCES Posts (PostID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Post_Author_fk_User FOREIGN KEY (Post_Author)
        REFERENCES Users (UserName)
        ON UPDATE CASCADE ON DELETE CASCADE
);
DELIMITER //
DROP FUNCTION IF EXISTS create_post//
CREATE FUNCTION create_post (
    Given_ThreadID	INT, -- foreign key to Threads(ThreadID)
    Given_ReplyToPost	INT, -- foreign key to Post(PostID)
    
    Given_Post_Author	VARCHAR(50),
    -- Given_Post_LastModifier	VARCHAR(50),
    
    Given_Post_Content	LONGTEXT,
    
    Given_Post_CreationTime	DATETIME,
    Given_Post_LastModificationTime	DATETIME,
    
    Given_Post_IsDeleted	BOOLEAN
)
RETURNS INT
BEGIN
		INSERT INTO Posts(
			ThreadID, -- foreign key to Threads(ThreadID)
			ReplyToPost, -- foreign key to Post(PostID)
			
			Post_Author,
			-- Post_LastModifier,
			
			Post_Content,
			
			Post_CreationTime,
			Post_LastModificationTime,
			
			Post_IsDeleted
        ) VALUES (
			Given_ThreadID, -- foreign key to Threads(ThreadID)
			Given_ReplyToPost, -- foreign key to Post(PostID)
			
			Given_Post_Author,
			-- Given_Post_LastModifier,
			
			Given_Post_Content,
			
			Given_Post_CreationTime,
			Given_Post_LastModificationTime,
			
			Given_Post_IsDeleted
        );
        RETURN LAST_INSERT_ID();
END//

SELECT 
    CREATE_POST(1,
            NULL,
            'admin',
            'Yes!!!! It is!!!',
            NOW(),
            NOW(),
            FALSE)
//
DROP TRIGGER IF EXISTS update_information_after_post_inserted //
CREATE TRIGGER update_information_after_post_inserted
	AFTER INSERT ON Posts
    FOR EACH ROW
BEGIN
	UPDATE Users
		SET User_LastPostTime = NOW() WHERE UserName = NEW.Post_Author;
	UPDATE Forums
		SET Forum_LastPostTime = NOW() WHERE ForumID = 
			(SELECT ForumID FROM Threads WHERE Threads.ThreadID = NEW.ThreadID LIMIT 1);
	UPDATE Threads
		SET Thread_LastUpdateTime = NOW(),
			Thread_LastUpdator = NEW.Post_Author
            WHERE Threads.ThreadID = NEW.ThreadID;
END //
DROP PROCEDURE IF EXISTS update_post//
CREATE PROCEDURE update_post (
	Given_PostID	INT,
    -- Given_Post_LastModifier	VARCHAR(50),    
    Given_Post_Content	LONGTEXT,    
    Given_Post_LastModificationTime	DATETIME,    
    Given_Post_IsDeleted	BOOLEAN
)
BEGIN
	UPDATE Posts SET
		-- Post_LastModifier = Given_Post_LastModifier,    
		Post_Content = Given_Post_Content,    
		Post_LastModificationTime = Given_Post_LastModificationTime,    
		Post_IsDeleted = Given_Post_IsDeleted
		WHERE PostID = Given_PostID;
		
END//
DROP PROCEDURE IF EXISTS get_thread_by_id//
CREATE PROCEDURE get_thread_by_id(
	Given_ThreadID INT
)
BEGIN
	UPDATE Threads SET Thread_NumberOFViews = Thread_NumberOFViews + 1;
	SELECT * FROM Threads WHERE ThreadID = Given_ThreadID LIMIT 1;
END//
DROP PROCEDURE IF EXISTS get_post_list_by_threadID//
CREATE PROCEDURE get_post_list_by_threadID(
	Given_ThreadID INT
)
BEGIN
	SELECT * FROM Posts WHERE ThreadID = Given_ThreadID AND Post_IsDeleted = FALSE;
END//
DELIMITER ;
CALL get_post_list_by_threadID(1);
DELIMITER //
DROP PROCEDURE IF EXISTS get_post_by_id//
CREATE PROCEDURE get_post_by_id(
	Given_PostID INT
)
BEGIN
	SELECT * FROM Posts WHERE PostID = Given_PostID LIMIT 1;
END//

DROP TRIGGER IF EXISTS delete_thread_after_all_its_posts_have_been_deleted//
CREATE TRIGGER delete_thread_after_all_its_posts_have_been_deleted
	AFTER UPDATE ON Posts
    FOR EACH ROW
BEGIN
	IF NOT EXISTS (SELECT * FROM Posts WHERE ThreadID = NEW.ThreadID AND Post_IsDeleted = FALSE) THEN
    BEGIN
		UPDATE Threads SET Thread_IsDeleted = TRUE
			 WHERE ThreadID = NEW.ThreadID;
    END;
    END IF;
END//
DELIMITER ;
/* FavoriteForums Table */
DROP TABLE IF EXISTS FavoriteForums;
CREATE TABLE FavoriteForums (
    FavoriteForumID INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(50),
    ForumID INT,
    CONSTRAINT FavoriteForum_fk_User FOREIGN KEY (UserName)
        REFERENCES Users (UserName)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FavoriteForum_fk_Fourm FOREIGN KEY (ForumID)
        REFERENCES Forums (ForumID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
DROP PROCEDURE IF EXISTS get_FavoriteForums_by_UserName;
DELIMITER //
CREATE PROCEDURE get_FavoriteForums_by_UserName (
	Given_UserName VARCHAR(50))
BEGIN
	SELECT * FROM FavoriteForums WHERE UserName = Given_UserName;
END//
DELIMITER ;
DROP TABLE IF EXISTS User_Friends;
CREATE TABLE User_Friends (
    FriendID INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(50),
    Friend_UserName VARCHAR(50),
    CONSTRAINT User_Friends_UserName_fk_Users FOREIGN KEY (UserName)
        REFERENCES Users (UserName),
    CONSTRAINT User_Friends_Friend_UserName_fk_Users FOREIGN KEY (Friend_UserName)
        REFERENCES Users (UserName)
);
DROP TABLE IF EXISTS User_Messages;
CREATE TABLE User_Messages (
	MessageID INT AUTO_INCREMENT PRIMARY KEY,
    Sender VARCHAR(50),
    Recipient VARCHAR(50),
    Message_Title VARCHAR(255),
    Message_Content LONGTEXT,
    Message_IsRead BOOLEAN,
    CONSTRAINT User_Messages_Sender_fk_Users FOREIGN KEY (Sender)
        REFERENCES Users (UserName),
    CONSTRAINT User_Messages_Recipient_fk_Users FOREIGN KEY (Recipient)
        REFERENCES Users (UserName)
);
DROP PROCEDURE IF EXISTS get_recent_threads_updated_by_user;
DELIMITER //
CREATE PROCEDURE get_recent_threads_updated_by_user (
	Given_UserName VARCHAR(50)
)
BEGIN
	SELECT DISTINCT * FROM Posts 
		NATURAL JOIN Threads WHERE Posts.Post_Author = Given_UserName
			GROUP BY Posts.ThreadID
            ORDER BY Post_CreationTime LIMIT 10;
END//
DROP FUNCTION IF EXISTS is_forum_favorite_with_user//
CREATE FUNCTION is_forum_favorite_with_user
(
	Given_ForumID INT,
    Given_UserName VARCHAR(50)
)
RETURNS BOOLEAN
BEGIN
	RETURN EXISTS (SELECT * FROM FavoriteForums WHERE UserName = Given_UserName AND ForumID = Given_ForumID LIMIT 1);
END//
DROP FUNCTION IF EXISTS add_forum_favorite_with_user//
CREATE FUNCTION add_forum_favorite_with_user
(
	Given_ForumID INT,
    Given_UserName VARCHAR(50)
)
RETURNS INT
BEGIN
	INSERT INTO FavoriteForums (ForumID, UserName) 
		VALUES (Given_ForumID, Given_UserName);
	RETURN LAST_INSERT_ID();
END//
DROP PROCEDURE IF EXISTS remove_forum_favorite_with_user//
CREATE PROCEDURE remove_forum_favorite_with_user
(
	Given_ForumID INT,
    Given_UserName VARCHAR(50)
)
BEGIN
	DELETE FROM FavoriteForums 
		WHERE ForumID = Given_ForumID AND UserName = Given_UserName;
END//
DELIMITER ;