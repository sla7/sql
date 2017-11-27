create table projectdraft.customer
  (Customer_id INT IDENTITY(1,1) NOT NULL,
  First_name varchar(15),
  Last_Name VARCHAR(15),
  primary key (Customer_id));


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

create table projectdraft.orders
  (Orders_id INT IDENTITY(300,1) NOT NULL,
  Order_date DATETIME,
  Paymentstatus VARCHAR(15),
  Billing_address VARCHAR(30),
  total VARCHAR(15),
  Customer_id INT,
  PRIMARY KEY (orders_id),
  FOREIGN KEY (Customer_id) REFERENCES projectdraft.customer);

create table projectdraft.payment_type
  (
  Payment_type_id INT IDENTITY(400,1) NOT NULL,
  Payment_type    VARCHAR(15),
  PRIMARY KEY (Payment_type_id)
  );

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

create table projectdraft.orderpayment
  (Order_id INT,
  Payment_id INT,
  Payment_status VARCHAR(15)
  FOREIGN KEY (Order_id) REFERENCES projectdraft.orders,
  FOREIGN KEY (Payment_id) REFERENCES projectdraft.paymentmethod);

create table projectdraft.product_type
  (Prodtype_id INT IDENTITY(700,1) NOT NULL,
  Prodtype_name VARCHAR(15)
  PRIMARY KEY (Prodtype_id)
  );

create table projectdraft.artist
  (Artist_id INT IDENTITY(800,1) NOT NULL,
  Artist_name VARCHAR(15)
  PRIMARY KEY (Artist_id)
  )

create TABLE projectdraft.album
  (Album_id INT IDENTITY(900,1) NOT NULL,
  Album_name VARCHAR(15),
  Album_realease_year VARCHAR(15),
  Prodtype_id INT,
  Artist_id INT,
  Album_price VARCHAR(15),
  PRIMARY KEY (Album_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist,
  FOREIGN KEY (Prodtype_id) REFERENCES projectdraft.product_type);
  
create table projectdraft.track
  (Track_id INT IDENTITY(1000,1) NOT NULL,
  Track_name VARCHAR(15),
  Album_id VARCHAR(15),
  Artist_id INT,
  Prodtype_id VARCHAR(15),
  Track_price VARCHAR(15),
  PRIMARY KEY (Track_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist);

create table projectdraft.merchandise
  (Merch_id INT IDENTITY(1100,1) NOT NULL,
  Merchandise_name VARCHAR(15),
  Prodtype_id VARCHAR(15),
  Artist_id INT,
  PRIMARY KEY (Merch_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist);

create table projectdraft.ticket
  (Ticket_id INT IDENTITY(1200,1) NOT NULL,
  Event_name VARCHAR(15),
  Event_date Date,
  Event_Location VARCHAR(15),
  Ticket_price VARCHAR(15),
  Prodtype_id INT,
  Artist_id INT,
  PRIMARY KEY (Ticket_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist,
  FOREIGN KEY (Prodtype_id) REFERENCES projectdraft.product_type
  )

create table projectdraft.inventory
  (Inventory_id INT IDENTITY(1300,1) NOT NULL,
  Sku_id VARCHAR(15),
  Category INT,
  Product_id INT,
  Prodtype_id INT,
  Returnable VARCHAR(15),
  PRIMARY KEY (Inventory_id),
  FOREIGN KEY (Product_id) REFERENCES projectdraft.artist,
  FOREIGN KEY (Product_id) REFERENCES projectdraft.track,
  FOREIGN KEY (Product_id) REFERENCES projectdraft.merchandise,
  FOREIGN KEY (Product_id) REFERENCES projectdraft.ticket,
  FOREIGN KEY (Prodtype_id) REFERENCES projectdraft.product_type,
  FOREIGN KEY (Prodtype_id) REFERENCES projectdraft.album
  )

create table projectdraft.order_line
(
  Order_Line_id   INT IDENTITY(1400,1) NOT NULL,
  Order_id        INT,
  Quantity        VARCHAR(15),
  Unit_price      VARCHAR(15),
  Sku_id          VARCHAR(15),
  Item_name       VARCHAR(15),
  Purchase_date   VARCHAR(15),
  Returnable_date VARCHAR(15),
  PRIMARY KEY (Order_Line_id),
  FOREIGN KEY (Order_id) REFERENCES projectdraft.orders
)

insert into projectdraft.customer VALUES ('Steven','La');
insert into projectdraft.billinginfo values ('Steven', '1560 shumaker','sanjose','ca','95131', 1);
insert into projectdraft.shipping_address_info values (1, '3975 freedom cicle','n/a','Santa Clara', 'CA', '95131', '408-503-0289');
insert into projectdraft.orders VALUES (getdate(), 'paid', '1666 Foxy', '99.99', 1);
insert into projectdraft.payment_type values ('VISA');
insert into projectdraft.paymentmethod VALUES (1, 400 ,'4352-5423-6675-4404','Steven La','2200/1/20','234');
insert into projectdraft.orderpayment VALUES (300, 500, 'PAID');
insert into projectdraft.product_type VALUES ('Digital');
insert into projectdraft.product_type VALUES ('Merch');
insert into projectdraft.product_type VALUES ('Tickets');
insert into projectdraft.product_type VALUES ('Album');
INSERT into projectdraft.artist VALUES ('Drake');
insert into projectdraft.album VALUES ('Thank Me Later', 2010, 700, 800, 9.99);
insert into projectdraft.track VALUES ('Fireworks',900, 800, 700, 0.99);
insert into projectdraft.merchandise VALUES ('Drake T-SHIRT', 701, 800 );
INSERT into projectdraft.ticket VALUES ('Drake Concert', '2018/01/20', 'SAP Center', 59.99, 702, 800);
