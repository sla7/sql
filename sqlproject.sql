/* CUSTOMER */

CREATE TABLE projectdraft.customer(
  Customer_id int IDENTITY(1,1) NOT NULL UNIQUE,
  First_Name varchar(15),
  Last_Name VARCHAR(15),
  Email_Address varchar(50),
  Phone_Number varchar(50),
  Billing_ID varchar(5),
  Address_ID varchar(5),
  PRIMARY KEY (Customer_id),
);

INSERT INTO projectdraft.customer VALUES ('Steven','La','sla@gmail.com','408-123-4567',100,200);
INSERT INTO projectdraft.customer VALUES ('Ken','Ohata','kohata@gmail.com','408-123-4568',101,201);
INSERT INTO projectdraft.customer VALUES ('Andrew','Lee','alee@gmail.com','408-123-4569',102,202);
INSERT INTO projectdraft.customer VALUES ('Emily','Ho','eho@gmail.com','408-123-4560',103,203);
INSERT INTO projectdraft.customer VALUES ('Alice','James','ajames@gmail.com','408-123-4561',104,204);
INSERT INTO projectdraft.customer VALUES ('Will','Smith','wsmith@gmail.com','408-123-4562',105,205);



create table projectdraft.billinginfo
  (Billinginfo_id INT IDENTITY(100,1) NOT NULL,
  Billing_Name VARCHAR(15),
  Billing_Address VARCHAR(15),
  Billing_city VARCHAR(15),
  Billing_state VARCHAR(15),
  Billing_zip VARCHAR(15),
  Customer_id   INT,
  PRIMARY KEY (billinginfo_id),
  foreign key (Customer_id) references projectdraft.customer);

insert into projectdraft.billinginfo values ('Steven', '1560 shumaker','sanjose','ca','95131', 1);


create TABLE projectdraft.shipping_address_info
  (Address_id INT IDENTITY(200,1) NOT NULL,
  Customer_id INT,
  Address_line1 VARCHAR(40),
  Address_line2 VARCHAR(40),
  City VARCHAR(15),
  state VARCHAR(15),
  zipcode VARCHAR(15),
  Cust_phone VARCHAR(15),
  PRIMARY KEY (Address_id),
  FOREIGN KEY (Customer_id) references projectdraft.customer);

insert into projectdraft.shipping_address_info values (1, '3975 freedom circle','n/a','Santa Clara', 'CA', '95131', '408-503-0289')

create table projectdraft.orders
  (Orders_id INT IDENTITY(300,1) NOT NULL,
  Order_date DATETIME,
  Paymentstatus VARCHAR(15),
  Billing_address VARCHAR(30),
  total int,
  Customer_id INT,
  PRIMARY KEY (orders_id),
  FOREIGN KEY (Customer_id) REFERENCES projectdraft.customer);

insert into projectdraft.orders VALUES (getdate(), 'paid', '1666 Foxy', 45, 1)



create table projectdraft.payment_type
  (
  Payment_type_id INT IDENTITY(400,1) NOT NULL,
  Payment_type    VARCHAR(15),
  PRIMARY KEY (Payment_type_id)
  );

insert into projectdraft.payment_type values ('VISA')


create table projectdraft.paymentmethod
  (Payment_id INT IDENTITY(500,1) NOT NULL,
  Customer_id INT,
  Payment_type_id INT,
  Card_Number VARCHAR(19),
  NameOnCard VARCHAR(15),
  CardExp DATE,
  Card_CSV_code VARCHAR(15),
  PRIMARY KEY (Payment_id),
  FOREIGN KEY (Customer_id) REFERENCES projectdraft.customer,
  FOREIGN KEY (Payment_type_id) REFERENCES projectdraft.payment_type);

insert into projectdraft.paymentmethod VALUES (1, 400 ,'4352-5423-6675-4404','Steven La','2200/1/20','234')


create table projectdraft.orderpayment
  (Order_id INT,
  Payment_id INT,
  Payment_status VARCHAR(15)
  FOREIGN KEY (Order_id) REFERENCES projectdraft.orders,
  FOREIGN KEY (Payment_id) REFERENCES projectdraft.paymentmethod);

insert into projectdraft.orderpayment VALUES (300, 500, 'PAID')

create table projectdraft.product_type
  (Prodtype_id INT IDENTITY(700,1) NOT NULL,
  Prodtype_name VARCHAR(15)
  PRIMARY KEY (Prodtype_id)
  );

insert into projectdraft.product_type VALUES ('Digital Track')
insert into projectdraft.product_type VALUES ('Digital Album')
insert into projectdraft.product_type VALUES ('Physical Album')
insert into projectdraft.product_type VALUES ('Merch')
insert into projectdraft.product_type VALUES ('Tickets')




create table projectdraft.artist
  (Artist_id INT IDENTITY(800,1) NOT NULL,
  Artist_name VARCHAR(15)
  PRIMARY KEY (Artist_id)
  )

INSERT into projectdraft.artist VALUES ('Drake')

create TABLE projectdraft.album
  (Album_id VARCHAR(15),
  Album_name VARCHAR(15),
  Album_realease_year VARCHAR(15),
  Prodtype_id INT,
  Artist_id INT,
  Album_price INT,
  PRIMARY KEY (Album_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist,
  FOREIGN KEY (Prodtype_id) REFERENCES projectdraft.product_type);

insert into projectdraft.album VALUES ('A1','Thank Me Later', 2010, 703, 800, 9.99)

create table projectdraft.track
  (Track_id VARCHAR(15),
  Track_name VARCHAR(15),
  Album_id VARCHAR(15),
  Artist_id INT,
  Prodtype_id VARCHAR(15),
  Track_price INT,
  PRIMARY KEY (Track_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist);

insert into projectdraft.track VALUES ('T1','Fireworks',900, 800, 700, 0.99)

create table projectdraft.merchandise
  (Merch_id VARCHAR(15),
  Merchandise_name VARCHAR(15),
  Prodtype_id VARCHAR(15),
  Artist_id INT,
  Merch_price INT,
  PRIMARY KEY (Merch_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist);

insert into projectdraft.merchandise VALUES ('M1','Drake T-SHIRT', 701, 800, 29.99 )

create table projectdraft.ticket
  (Ticket_id VARCHAR(15),
  Event_name VARCHAR(15),
  Event_date Date,
  Event_Location VARCHAR(15),
  Ticket_price INT,
  Prodtype_id INT,
  Artist_id INT,
  PRIMARY KEY (Ticket_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist,
  FOREIGN KEY (Prodtype_id) REFERENCES projectdraft.product_type
  )

INSERT into projectdraft.ticket VALUES ('TICK1','Drake Concert', '2018/01/20', 'SAP Center', 59.99, 702, 800)

create table projectdraft.order_line
(
  Order_Line_id   INT IDENTITY(1400,1) NOT NULL,
  Order_id        INT,
  Quantity        VARCHAR(15),
  Sku_id          VARCHAR(15),
  Purchase_date   VARCHAR(15),
  Returnable_date VARCHAR(15),
  PRIMARY KEY (Order_Line_id),
  FOREIGN KEY (Order_id) REFERENCES projectdraft.orders,
  FOREIGN KEY (Sku_id) REFERENCES projectdraft.inventory(Sku_id)
)

INSERT INTO projectdraft.order_line VALUES (300, 5,'1300A1', GETDATE(), dateadd(day, 30, getdate()))

create table projectdraft.inventory
  (Inventory_id INT IDENTITY(1300,1) NOT NULL,
  Sku_id VARCHAR(15) UNIQUE ,
  Product_id VARCHAR(15),
  Prodtype_id INT,
  Returnable VARCHAR(15),
  PRIMARY KEY (Product_id),
  FOREIGN KEY (Prodtype_id) REFERENCES projectdraft.product_type
  )


delete from projectdraft.order_line
delete from projectdraft.inventory

select * from projectdraft.album

select * from projectdraft.inventory


INSERT INTO projectdraft.inventory (Product_id, Prodtype_id, Sku_id, Returnable)
SELECT projectdraft.album.Album_id, Prodtype_id, concat('A1-', Prodtype_id), 'NO'
FROM projectdraft.album

INSERT INTO projectdraft.inventory (Product_id, Prodtype_id, Sku_id, Returnable)
SELECT projectdraft.album.Album_id, Prodtype_id, concat('A1-', Prodtype_id), 'NO'
FROM projectdraft.album where Prodtype_id = 700
