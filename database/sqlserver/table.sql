drop table Wood_Category;
drop table Wood_Product;
drop table Orders_Wood_Product;
drop table Orders;
drop table Shipping;
drop table Payment;
drop table Customer;
drop table Currency;
drop table State;
drop table Tracker;
drop table Status;
drop table Users;
drop table Permission;
drop table Config;
drop table Shipper;


CREATE TABLE Wood_Category (
       category_id          	INT PRIMARY KEY IDENTITY,
       name          		VARCHAR(100) NOT NULL,
       description     		VARCHAR(500) NOT NULL,
       url_path                	VARCHAR(1000) NULL,
       import_tax_rate		DECIMAL(5,2) NULL,       
       margin			DECIMAL(5,2),
       PRIMARY KEY (category_id)
);

CREATE TABLE Wood_Product (
       product_id          	INT PRIMARY KEY IDENTITY,
       category_id		INT NOT NULL,
       name                 	VARCHAR(100) NULL,
       description             	VARCHAR(2000) NULL,
       width			DECIMAL(5,2) NULL,
       length			DECIMAL(5,2) NULL,
       height			DECIMAL(5,2) NULL,
       base_price		DECIMAL(5,2),
       price			DECIMAL(5,2),
       for_sale			CHAR(1),
       shipping_cost		DECIMAL(5,2) NULL,
       image_name		VARCHAR(100),
       quantity			INT NOT NULL DEFAULT 0,
       vendor_id		VARCHAR(100) NULL,
       vendor_name		VARCHAR(100) NULL,
       vendor_desc		VARCHAR(500) NULL,
       vendor_width		INT NULL,
       vendor_length		INT NULL,
       vendor_height		INT NULL,
       vendor_price		DECIMAL(11,2),
       create_date		DATE,
       update_date		DATE NULL
);

CREATE TABLE Orders (
       order_id         INT PRIMARY KEY IDENTITY,
       customer_id		INT NOT NULL,
       payment_id		INT NOT NULL,
       product_type     VARCHAR(100) NOT NULL,
       amount			DECIMAL(9,2) NOT NULL,       
       comments         VARCHAR(300) NULL,
       status			CHAR(1),
       error_code		VARCHAR(25),
       error_message	VARCHAR(500),
       create_date		DATE NOT NULL,
       client_id		varchar(20), 
       confirm_no		varchar(100), 
       update_date		DATE
);


CREATE TABLE Orders_Wood_Product (
       order_id         INT NOT NULL,
       product_id		INT NOT NULL,
       quantity			INT NOT NULL,
       create_date		DATE NOT NULL
);


CREATE TABLE Shipper (
       vendor_id         	INT PRIMARY KEY IDENTITY,
       name	          	VARCHAR(100) NOT NULL,
       type            		VARCHAR(300) NOT NULL,
       cost			decimal(9,2) NOT NULL,
       create_date		DATE
);

CREATE TABLE Shipping (
       shipping_id         	INT PRIMARY KEY IDENTITY,
       vendor_id          	VARCHAR(100) NULL,
       tracking_id            	VARCHAR(300) NULL,
       order_id		INT NOT NULL,
       create_date		DATE,
);


CREATE TABLE Customer (
       customer_id         	INT PRIMARY KEY IDENTITY,
       first_name	        VARCHAR(32) NULL,
       last_name            	VARCHAR(32) NULL,
       email			VARCHAR(100) NOT NULL,
       contact_phone		VARCHAR(10),
       contact_fax		VARCHAR(10),
       bill_address1		VARCHAR(100) NOT NULL,
       bill_address2		VARCHAR(100) NOT NULL,
       bill_city		VARCHAR(26) NOT NULL,
       bill_state		VARCHAR(2) NOT NULL,
       bill_zip			CHAR(5) NOT NULL,
       bill_zip4		CHAR(4) NULL,
       bill_country		VARCHAR(100),
       ship_address1		VARCHAR(100) NOT NULL,
       ship_address2		VARCHAR(100) NOT NULL,
       ship_city		VARCHAR(26) NOT NULL,
       ship_state		VARCHAR(2) NOT NULL,
       ship_zip			CHAR(5) NOT NULL,
       ship_zip4		CHAR(4) NULL,
       ship_country		VARCHAR(100),
       create_date		DATE,
       update_date		DATE
);


CREATE TABLE Payment (
       payment_id          	INT PRIMARY KEY IDENTITY,
       card_holder_name         VARCHAR(64) NOT NULL,
       card_type		VARCHAR(10) NOT NULL,
       card_number		VARCHAR(20) NOT NULL,
       card_exp_date		DATE NOT NULL,
       card_cvv			VARCHAR(6),
       amount			DECIMAL(9,2) NOT NULL,
       vendor_conf_no   	VARCHAR(500),
       vendor_response   	VARCHAR(2000),
       create_date		DATE NOT NULL,
       update_date		DATE
);


CREATE TABLE Currency (
       type          	    	VARCHAR(10) NOT NULL,
       US          	    	DECIMAL(5,2) NOT NULL,
       other            	DECIMAL(11,2) NOT NULL,
       PRIMARY KEY (Type)
);

CREATE TABLE State (
       code          	    	VARCHAR(2) NOT NULL,
       name          	    	VARCHAR(25) NOT NULL,
       country            	VARCHAR(3) NOT NULL,
       tax_rate				DECIMAL(5,2) NOT NULL,
       PRIMARY KEY (code)
);

CREATE TABLE Status (
       code          	    	VARCHAR(2) NOT NULL,
       description     	    	VARCHAR(200) NOT NULL,
       ordering			int NOT NULL,
       PRIMARY KEY (code)
);

CREATE TABLE Tracker (
       id         		INT PRIMARY KEY IDENTITY,
       category_id		INT,
       product_id		INT,
       product_type     VARCHAR(100),
       client_id		varchar(20),   
       page				varchar(50),
       create_date		DATE NOT NULL default getdate()
);

CREATE TABLE Users (
       email          	    	VARCHAR(100) NOT NULL,
       passwd     	    		VARCHAR(100) NOT NULL,
       perm_id					VARCHAR(20),
       PRIMARY KEY (email)
);


CREATE TABLE Permission (
       perm_id          	    VARCHAR(20) NOT NULL,
       name     	    		VARCHAR(50) NOT NULL,
       PRIMARY KEY (perm_id)
);


CREATE TABLE OrderStatus (
       code          	    	VARCHAR(2) NOT NULL,
       description     	    	VARCHAR(200) NOT NULL,
       ordering			INT,
       PRIMARY KEY (code)
);

CREATE TABLE Config (
       cKey          	    	VARCHAR(50) NOT NULL,
       cValue     	    		VARCHAR(500) NOT NULL,
       PRIMARY KEY (cKey)
);


ALTER TABLE Wood_Product
       ADD  ( FOREIGN KEY (category_id)
                             REFERENCES Wood_Category ) ;

ALTER TABLE Orders
       ADD  ( FOREIGN KEY (customer_id)
                             REFERENCES Customer ) ,
       ADD  ( FOREIGN KEY (payment_id)
                             REFERENCES Payment ) ;

ALTER TABLE Shipping
       ADD  ( FOREIGN KEY (order_id)
                             REFERENCES Orders ) ,
       ADD  ( FOREIGN KEY (vendor_id)
                             REFERENCES Shipper ) ; 
                             
                             
ALTER TABLE Orders_Wood_Product
       ADD  ( FOREIGN KEY (product_id)
                             REFERENCES Wood_Product ), 
       ADD  ( FOREIGN KEY (order_id)
                             REFERENCES Orders ) ;
                             
ALTER TABLE Users
       ADD  ( FOREIGN KEY (perm_id)
                             REFERENCES Permission ) ;
                             
                             