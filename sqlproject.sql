/* CUSTOMER */

CREATE TABLE project.customer(
  Customer_id int IDENTITY(1,1) NOT NULL,
  First_Name varchar(15),
  Last_Name VARCHAR(15),
  Email_Address varchar(50),
  Phone_Number varchar(50),
  Billing_ID varchar(5),
  Address_ID varchar(5),
  PRIMARY KEY (Customer_id),
);

INSERT INTO project.customer VALUES ('Steven','La','sla@gmail.com','408-123-4567  ',100,200);
INSERT INTO project.customer VALUES ('Ken','Ohata','kohata@gmail.com','408-123-4568  ',101,201);
INSERT INTO project.customer VALUES ('Andrew','Lee','andrew.lee@comcast.com','408-956-8631',102,202);
INSERT INTO project.customer VALUES ('Emily','Ho','eho@gmail.com','408-123-4560  ',103,203);
INSERT INTO project.customer VALUES ('Alice','James','ajames@gmail.com','408-123-4561  ',104,204);
INSERT INTO project.customer VALUES ('Will','Smith','wsmith@gmail.com','408-123-4562  ',105,205);


CREATE TABLE project.billing_info(
  Billing_id int IDENTITY(100,1) NOT NULL,
  Billing_FName varchar(15),
  Billing_LName varchar(15),
  Billing_address varchar(50),
  Billing_city varchar(20),
  Billing_state varchar(2),
  Billing_zipcode varchar(15),
  Customer_id  int,
  PRIMARY KEY (Billing_id),
  FOREIGN KEY (Customer_id) REFERENCES project.customer(Customer_id)
);

INSERT INTO project.billing_info VALUES ('Steven','La','1560 Shumaker','San Jose','CA','95131',1);
INSERT INTO project.billing_info VALUES ('Ken','Ohata','200 Music Way','Irvine','CA','92602',2);
INSERT INTO project.billing_info VALUES ('Andrew','Lee','865 Sake Business Center','Milpitas','CA','95035',3);
INSERT INTO project.billing_info VALUES ('Emily','Ho','400 Music Way','Irvine','CA','92602',4);
INSERT INTO project.billing_info VALUES ('Alice','James','500 Music Way','Irvine','CA','92602',5);
INSERT INTO project.billing_info VALUES ('Will','Smith','600 Music Way','Irvine','CA','92602',6);


CREATE TABLE project.shipping_info(
  Address_id int IDENTITY(200,1) NOT NULL,
  First_Name varchar(15),
  Last_Name varchar(15),
  Address_line1 VARCHAR(40),
  Address_line2 VARCHAR(40),
  City VARCHAR(15),
  State VARCHAR(15),
  Zipcode VARCHAR(15),
  Phone_number VARCHAR(15),
  Customer_id int,
  PRIMARY KEY (Address_id),
  FOREIGN KEY (Customer_id) REFERENCES project.customer(Customer_id)
);

INSERT INTO project.shipping_info VALUES ('Steven','La','3975 Freedom Cicle',' ','Santa Clara','CA','95131','408-503-0289',1);
INSERT INTO project.shipping_info VALUES ('Ken','Ohata','200 Music Way',' ','Irvine','CA','92602','408-123-4568  ',2);
INSERT INTO project.shipping_info VALUES ('Andrew','Lee','865 Sake Business Center',' ','Milpitas','CA','95035','408-956-8631',3);
INSERT INTO project.shipping_info VALUES ('Emily','Ho','400 Music Way',' ','Irvine','CA','92602','408-123-4560  ',4);
INSERT INTO project.shipping_info VALUES ('Amy','James','100 Apple Way','Apt 605','Santa Clara','CA','95131','408-503-1111  ',5);
INSERT INTO project.shipping_info VALUES ('Cat','Smith','200 Apple Way',' ','Santa Clara','CA','95131','408-503-2222  ',6);



/* ORDERS */

CREATE TABLE project.orders(
  Order_id int IDENTITY(300,1) NOT NULL,
  Order_number int,
  Order_date date,
  Payment_status varchar(15),
  Customer_id int,
  Total float,
  PRIMARY KEY (order_id),
  FOREIGN KEY (Customer_id) REFERENCES project.customer
);

INSERT INTO project.orders VALUES (1,'12/04/2017','Paid',1,150.30);
INSERT INTO project.orders VALUES (2,'11/01/2017','Paid',1,51.99);
INSERT INTO project.orders VALUES (3,'09/10/2017','Paid',1,6.99);
INSERT INTO project.orders VALUES (4,'10/22/2017','Paid',2,0.99);
INSERT INTO project.orders VALUES (5,'11/15/2017','Refunded',3,-25.00);


/* ORDER LINE */

CREATE TABLE project.order_line(
  Order_Line_id int IDENTITY(1400,1) NOT NULL,
  Order_id int,
  Order_type varchar(15),
  Quantity int,
  Sku_id varchar(15),
  Purchase_date date,
  Returnable_date date,
  Original_Order_id int,
  PRIMARY KEY (Order_Line_id),
  FOREIGN KEY (Order_id) REFERENCES project.orders(Order_id),
  FOREIGN KEY (SKU_id) REFERENCES project.inventory(SKU_id)
);

INSERT INTO project.order_line VALUES (300,'Purchase', 2,'X1TICK12', '12/04/2017', NULL, NULL);
INSERT INTO project.order_line VALUES (301,'Purchase', 1,'X1M6', '11/01/2017', dateadd(day, 30, getdate()), NULL);
INSERT INTO project.order_line VALUES (301,'Purchase', 1,'X1M2', '11/01/2017', dateadd(day, 30, getdate()), NULL);
INSERT INTO project.order_line VALUES (301,'Purchase', 2,'X1A13', '11/01/2017', dateadd(day, 30, getdate()), NULL);
INSERT INTO project.order_line VALUES (302,'Purchase', 1,'X1A17', '09/10/2017', NULL, NULL);
INSERT INTO project.order_line VALUES (303,'Purchase', 1,'X1T4', '10/22/2017', NULL, NULL);
INSERT INTO project.order_line VALUES (304,'Return', 1,'X1M6', '11/15/2017', NULL, 301);



/* PAYMENT TYPE */

CREATE TABLE project.payment_type(
  Payment_type_id int IDENTITY(400,1) NOT NULL,
  Payment_type varchar(30),
  PRIMARY KEY (Payment_type_id)
);

INSERT INTO project.payment_type values ('American Express');
INSERT INTO project.payment_type values ('Discover');
INSERT INTO project.payment_type values ('Visa');


/* PAYMENT METHOD */

CREATE TABLE project.paymentmethod(
  Payment_id int IDENTITY(500,1) NOT NULL,
  Customer_id int,
  Payment_type_id int,
  Card_Number varchar(19),
  NameOnCard varchar(50),
  CardExp date,
  Card_CSV_code varchar(15),
  Billing_id int,
  PRIMARY KEY (Payment_id),
  FOREIGN KEY (Customer_id) REFERENCES project.customer(Customer_id),
  FOREIGN KEY (Payment_type_id) REFERENCES project.payment_type,
  FOREIGN KEY (Billing_id) REFERENCES project.billing_info(Billing_id)
);

INSERT INTO project.paymentmethod VALUES (1,400,'4352-5423-6675-4404','Steven La','01/20/2022','234',100);
INSERT INTO project.paymentmethod VALUES (2,400,'4352-5423-6675-3333','Ken Ohata','02/18/2019','200',101);
INSERT INTO project.paymentmethod VALUES (3,400,'4352-5423-6675-9304','
                                          Lee','08/05/2018','196',102);
INSERT INTO project.paymentmethod VALUES (4,400,'4352-5423-6675-2222','Emily Ho','04/10/2021','789',103);
INSERT INTO project.paymentmethod VALUES (5,400,'4352-5423-6675-4000','Alice James','05/07/2022','453',104);
INSERT INTO project.paymentmethod VALUES (6,400,'4352-5423-6675-5000','Will Smith','06/11/2019','567',105);


/* ORDER PAYMENT */

create table project.orderpayment(
  Order_id int,
  Payment_id int,
  Payment_status varchar(15)
  FOREIGN KEY (Order_id) REFERENCES project.orders,
  FOREIGN KEY (Payment_id) REFERENCES project.paymentmethod
);

INSERT INTO project.orderpayment VALUES (300, 500, 'PAID');
INSERT INTO project.orderpayment VALUES (301, 501, 'PAID');
INSERT INTO project.orderpayment VALUES (302, 502, 'PAID');
INSERT INTO project.orderpayment VALUES (303, 503, 'PAID');
INSERT INTO project.orderpayment VALUES (304, 504, 'PAID');
INSERT INTO project.orderpayment VALUES (305, 505, 'PAID');



/* PROD TYPE */

CREATE TABLE project.product_type (
  Prodtype_id int IDENTITY(700,1) NOT NULL,
  Prodtype_name varchar(15)
  PRIMARY KEY (Prodtype_id)
  );

INSERT INTO project.product_type VALUES ('Digital Track');
INSERT INTO project.product_type VALUES ('Digital Album');
INSERT INTO project.product_type VALUES ('Physical Album');
INSERT INTO project.product_type VALUES ('Merchandise');
INSERT INTO project.product_type VALUES ('Ticket');


/* ARTIST */

CREATE TABLE project.artist(
  Artist_id int IDENTITY(800,1) NOT NULL,
  Artist_name varchar(50)
  PRIMARY KEY (Artist_id)
  );

INSERT INTO project.artist VALUES ('Eminem');
INSERT INTO project.artist VALUES ('Kanye West');
INSERT INTO project.artist VALUES ('Linkin Park');
INSERT INTO project.artist VALUES ('Sam Smith');
INSERT INTO project.artist VALUES ('Adele');
INSERT INTO project.artist VALUES ('Drake');
INSERT INTO project.artist VALUES ('J. Cole');
INSERT INTO project.artist VALUES ('Chris Brown');
INSERT INTO project.artist VALUES ('Camila Cabello');
INSERT INTO project.artist VALUES ('Ed Sheeran');
INSERT INTO project.artist VALUES ('Maroon 5');
INSERT INTO project.artist VALUES ('Taylor Swift');
INSERT INTO project.artist VALUES ('Imagine Dragons');
INSERT INTO project.artist VALUES ('Charlie Puth');
INSERT INTO project.artist VALUES ('Quavo');
INSERT INTO project.artist VALUES ('Clean Bandit');
INSERT INTO project.artist VALUES ('The Weekend');
INSERT INTO project.artist VALUES ('Rihanna');
INSERT INTO project.artist VALUES ('Cardi B');
INSERT INTO project.artist VALUES ('Luke Bryan');
INSERT INTO project.artist VALUES ('Demi Lovato');
INSERT INTO project.artist VALUES ('98 Degrees');
INSERT INTO project.artist VALUES ('Seattle Symphony Orchestra');
INSERT INTO project.artist VALUES ('David Bowie');
INSERT INTO project.artist VALUES ('Frank Ocean');


CREATE TABLE project.track(
  Track_id varchar(15),
  Track_name varchar(50),
  Genre varchar(50),
  Label varchar(100),
  Album_id int,
  Artist_id int,
  Prodtype_id varchar(15),
  Track_price float,
  PRIMARY KEY (Track_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist(Artist_id)
);

INSERT INTO project.track VALUES ('T1','Lose Yourself','Hip Hop','Interscope',900, 800, 700, 0.79);
INSERT INTO project.track VALUES ('T2','Wolves','Hip Hop','Rock the World',901, 801, 700, 0.99);
INSERT INTO project.track VALUES ('T3','Numb','Rock','Warner Bros',902, 802, 700, 0.99);
INSERT INTO project.track VALUES ('T4','Too Good at Goodbyes','Capitol','Pop',903, 803, 700, 0.99);
INSERT INTO project.track VALUES ('T5','Hello','Pop','XI Recordings',904, 804, 700, 1.29);
INSERT INTO project.track VALUES ('T6','Fireworks','R&B','Young Money Entertainment',905, 805, 700, 1.29);
INSERT INTO project.track VALUES ('T7','In The Morning','Hip Hop','Columbia',906, 806, 700, 1.29);
INSERT INTO project.track VALUES ('T8','Havana','Pop','Epic Records',907, 808, 700, 1.29);
INSERT INTO project.track VALUES ('T9','Shape of You','Pop','Asylum Records',NULL, 809, 700, 1.29);


CREATE TABLE project.album(
  Album_id varchar(15),
  Album_name varchar(200),
  Album_realease_year int,
  Genre varchar(50),
  Label varchar(100),
  Prodtype_id int,
  Artist_id int,
  Album_price float,
  PRIMARY KEY (Album_id),
  FOREIGN KEY (Artist_id) REFERENCES project.artist(Artist_id),
  FOREIGN KEY (Prodtype_id) REFERENCES project.product_type(Prodtype_id)
);

INSERT INTO project.album VALUES ('A1','8 Mile', 2002, 'Hip Hop','Interscope', 701, 800, 6.99);
INSERT INTO project.album VALUES ('A2','The Life of Pablo', 2004, 'Hip Hop','Rock the World', 701, 801, 11.99);
INSERT INTO project.album VALUES ('A3','Meteora', 2003, 'Rock','Warner Bros', 701, 802, 7.99);
INSERT INTO project.album VALUES ('A4','The Thrill of It All', 2017, 'Pop','Capitol',701, 803, 9.99);
INSERT INTO project.album VALUES ('A5','25', 2015, 'Pop', 'XI Recordings',701, 804, 10.99);
INSERT INTO project.album VALUES ('A6','Thank Me Later', 2010, 'R&B','Young Money Entertainment', 701, 805, 6.99);
INSERT INTO project.album VALUES ('A7','Cole World', 2011, 'Hip Hop','Columbia', 701, 806, 11.99);
INSERT INTO project.album VALUES ('A8','8 Mile', 2002, 'Hip Hop', 'Interscope',702, 800, 6.99);
INSERT INTO project.album VALUES ('A9','The Life of Pablo', 2004, 'Hip Hop','Rock the World', 702, 801, 11.99);
INSERT INTO project.album VALUES ('A10','Meteora', 2003, 'Rock', 'Warner Bros',702, 802, 7.99);
INSERT INTO project.album VALUES ('A11','The Thrill of It All', 2017, 'Pop','Capitol', 702, 803, 9.99);
INSERT INTO project.album VALUES ('A12','25', 2015, 'Pop','XI Recordings', 702, 804, 10.99);
INSERT INTO project.album VALUES ('A13','Thank Me Later', 2010, 'R&B','Young Money Entertainment', 702, 805, 6.99);
INSERT INTO project.album VALUES ('A14','Cole World', 2011, 'Hip Hop','Columbia',702, 806, 11.99);
INSERT INTO project.album VALUES ('A15','Heartbreak On A Full Moon', 2017, 'Hip Hop','RCA Records', 701, 807, 16.99);
INSERT INTO project.album VALUES ('A16','What Makes You Country', 2017, 'Country','Capitol Nashville', 701, 818, 9.99);
INSERT INTO project.album VALUES ('A17','Nielson: Symphonies Nos. 3 & 4', 2017, 'Classical','Seattle Symphony Media',701, 822, 6.99);
INSERT INTO project.album VALUES ('A18','Atomic Blonde', 2017, 'Rock','Back Lot Music', 701, 823, 9.99);
INSERT INTO project.album VALUES ('A19','Blonde', 2017, 'R&B','Boys Dont Cry', 701, 824, 9.99);


CREATE TABLE project.merchandise(
  Merch_id varchar(15),
  Merchandise_name varchar(50),
  Prodtype_id int,
  Artist_id int,
  Merch_price float,
  PRIMARY KEY (Merch_id),
  FOREIGN KEY (Artist_id) REFERENCES project.artist(Artist_id),
  FOREIGN KEY (Prodtype_id) REFERENCES project.product_type(Prodtype_id)
);

INSERT INTO project.merchandise VALUES ('M1','Eminem Hoodie', 703, 800, 45.00);
INSERT INTO project.merchandise VALUES ('M2','Kanye Poster', 703, 801, 20.00);
INSERT INTO project.merchandise VALUES ('M3','Linkin Park Hat', 703, 802, 30.00);
INSERT INTO project.merchandise VALUES ('M4','Sam Smith Hoodie', 703, 803, 72.99);
INSERT INTO project.merchandise VALUES ('M5','Adele Bag', 703, 804, 40.00);
INSERT INTO project.merchandise VALUES ('M6','Drake Shirt', 703, 805, 15.00);
INSERT INTO project.merchandise VALUES ('M7','J. Cole Duffel', 703, 806, 65.00);
INSERT INTO project.merchandise VALUES ('M8','The Weekend Keychain', 703, 816, 8.00);
INSERT INTO project.merchandise VALUES ('M9','Cardi B Beanie', 703, 818, 20.00);
INSERT INTO project.merchandise VALUES ('M10','Rihanna Socks', 703, 817, 65.00);


CREATE TABLE project.ticket(
  Ticket_id varchar(15),
  Event_name varchar(100),
  Event_date date,
  Event_location varchar(50),
  Artist_id int,
  Prodtype_id int,
  Ticket_price int,
  PRIMARY KEY (Ticket_id),
  FOREIGN KEY (Artist_id) REFERENCES project.artist(Artist_id),
  FOREIGN KEY (Prodtype_id) REFERENCES project.product_type(Prodtype_id)
 );

INSERT INTO project.ticket VALUES ('TICK1','Eminem Concert', '08/20/2018', 'SAP Center',800,704,65.00);
INSERT INTO project.ticket VALUES ('TICK2','Kanye Concert', '09/25/2018', 'Oracle Coliseum',801,704,40.00);
INSERT INTO project.ticket VALUES ('TICK3','Linkin Park: One More Light', '12/15/2017', 'Fox Theatre',802,704,80.00);
INSERT INTO project.ticket VALUES ('TICK4','Sam Smith: The Thrill of It All', '08/24/2018', 'Shoreline',803,704,130.00);
INSERT INTO project.ticket VALUES ('TICK5','Adele Live 2018', '05/10/2018', 'Staples Center',804,704,110.00);
INSERT INTO project.ticket VALUES ('TICK6','Drake: Thank Me Later', '06/27/2018', 'Melbourne Rod Laver Arena',805,704,150.00);
INSERT INTO project.ticket VALUES ('TICK7','Cole World', '07/18/2018', 'The Observatory',806,704,108.00);
INSERT INTO project.ticket VALUES ('TICK8','Imagine Dragons', '12/30/2017', '1stBank Center',812,704,55.00);
INSERT INTO project.ticket VALUES ('TICK9','Charlie Puth', '12/15/2017', 'Philips Arena',813,704,70.00);
INSERT INTO project.ticket VALUES ('TICK10','Quavo', '1/10/2018', 'Madison Square Garden',814,704,40.00);
INSERT INTO project.ticket VALUES ('TICK11','Clean Bandit', '03/27/2018', 'The Showbox',815,704,50.00);
INSERT INTO project.ticket VALUES ('TICK12','98 Degrees', '11/19/2018', 'Flint Center',821,704,25.00);


/* INVENTORY */

CREATE TABLE project.inventory(
  Inventory_id int IDENTITY(1300,1) NOT NULL UNIQUE,
  Product_id varchar(15),
  SKU_id varchar(15) UNIQUE,
  Prodtype_id int,
  Quantity int,
  Returnable varchar(15),
  PRIMARY KEY (Inventory_id),
  FOREIGN KEY (Prodtype_id) REFERENCES project.product_type(Prodtype_id)
 );

INSERT INTO project.inventory(Product_id, SKU_id,Prodtype_id,Quantity,returnable)
SELECT project.track.track_id,concat('X1',Track_id),Prodtype_id,1000,'No'
FROM project.track;

INSERT INTO project.inventory(Product_id, SKU_id,Prodtype_id,Quantity,returnable)
SELECT project.album.album_id,concat('X1',Album_id),Prodtype_id,1000,'No'
FROM project.album
WHERE Prodtype_id = 701;

INSERT INTO project.inventory(Product_id, SKU_id,Prodtype_id,Quantity,returnable)
SELECT project.album.album_id,concat('X1',Album_id),Prodtype_id,1000,'Yes'
FROM project.album
WHERE Prodtype_id = 702;

INSERT INTO project.inventory(Product_id, SKU_id,Prodtype_id,Quantity,returnable)
SELECT project.merchandise.Merch_id,concat('X1',Merch_id),Prodtype_id,1000,'Yes'
FROM project.merchandise;

INSERT INTO project.inventory(Product_id, SKU_id,Prodtype_id,Quantity,returnable)
SELECT project.ticket.ticket_id,concat('X1',Ticket_id),Prodtype_id,1000,'No'
FROM project.ticket;



select * from project.inventory

select * from project.inventory WHERE Prodtype_id = 702

select * from project.billing_info

SELECT * FROM project.album
