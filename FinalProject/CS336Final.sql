USE proj2014;

CREATE TABLE User(username char(20) primary key,
passwordUser char(20) NOT NULL,
isCustomer boolean NOT NULL,
bio char(100),
profilePicUrl char(100),
INDEX idx_username (username)) ENGINE = InnoDB;

CREATE TABLE Moderator(	username char(20) primary key, 
CONSTRAINT fk_mod foreign key (username) references User(username) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = InnoDB;

CREATE TABLE Admin(	username char(20) primary key,
CONSTRAINT fk_admin foreign key (username) references User(username) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = InnoDB;

CREATE TABLE Sales_Staff(	username char(20) primary key,
CONSTRAINT fk_sales_staff foreign key (username) references User(username) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = InnoDB;

CREATE TABLE Message(	
messageID int(11) primary key,
fromUser char(20),
toUser char(20),
content char(100) NOT NULL,
dateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_message_1 foreign key (fromUser) references User(username) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_message_2 foreign key (toUser) references User(username) ON DELETE CASCADE ON UPDATE CASCADE)ENGINE = InnoDB; # dateTime format: 1430-03142014 (time-date)

CREATE TABLE Advertisement(	
AD_ID int AUTO_INCREMENT NOT NULL,
companyName char(30) NOT NULL,
description char(100) NOT NULL,
dateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
keywords char(100),
primary key (AD_ID))  ENGINE = InnoDB;

CREATE TABLE Sale_Item(	
AD_ID int,
description char(100) NOT NULL,
price real NOT NULL,
primary key (AD_ID, description),
CONSTRAINT fk_sale_item foreign key (AD_ID) references Advertisement(AD_ID) ON DELETE CASCADE ON UPDATE CASCADE,
check(price >= 0),
INDEX idx_desc (description))ENGINE = InnoDB;



CREATE TABLE Buys(	
purchase_ID int AUTO_INCREMENT NOT NULL primary key,
AD_ID int NOT NULL, 
username char(20) NOT NULL,
dateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
description char(100) NOT NULL,
CONSTRAINT fk_buys_1 foreign key (description) references Sale_Item(description) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_buys_2 foreign key (AD_ID) references Advertisement(AD_ID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_buys_3 foreign key (username) references User (username) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB;

CREATE TABLE Topic(	topicName char(20) primary key)ENGINE = InnoDB;


CREATE TABLE Moderates(	username char(20), 
topic_name char(20),
primary key (username, topic_name),
CONSTRAINT fk_moderates_1 foreign key (username) references Moderator(username) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_moderates_2 foreign key (topic_name) references Topic(topicName) ON DELETE CASCADE ON UPDATE CASCADE)ENGINE = InnoDB;

CREATE TABLE Administrates(	username char(20),
topic_name char(20),
primary key (username, topic_name),
CONSTRAINT fk_administrates_1 foreign key (username) references Admin(username) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_administrates_2 foreign key (topic_name) references Topic(topicName) ON DELETE CASCADE ON UPDATE CASCADE)ENGINE = InnoDB;



CREATE TABLE Thread(	
threadID int primary key AUTO_INCREMENT, 
topicName char(20) NOT NULL,
CONSTRAINT fk_thread foreign key (topicName) references Topic(topicName)ON DELETE CASCADE ON UPDATE CASCADE,
votes int DEFAULT '0',
description char(100)) ENGINE = InnoDB;


CREATE TABLE Post(	
postID int primary key AUTO_INCREMENT,  # merged Posts table with Post by adding username of user who posted.
username char(20) NOT NULL,
threadID int NOT NULL, 
parentPostID int, #will be null for first post in a thread, but points to upper level
votes int NOT NULL DEFAULT '0',
content char(200) NOT NULL,
CONSTRAINT fk_post_2 foreign key (threadID) references Thread(threadID)ON DELETE CASCADE ON UPDATE CASCADE,
dateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP) ENGINE = InnoDB;











