create table projectdraft.customer
  (Customer_id varchar(15),
  First_name varchar(15),
  Last_Name VARCHAR(15)
  primary key (Customer_id));

create table projectdraft.billinginfo
  (Billinginfo_id VARCHAR(15),
  Billing_Name VARCHAR(15),
  Billing_Address VARCHAR(15),
  Billing_city VARCHAR(15),
  Billing_state VARCHAR(15),
  Billing_zip VARCHAR(15),
  Customer_id   VARCHAR(15)
  PRIMARY KEY (billinginfo_id),
  foreign key (Customer_id) references projectdraft.customer);

create TABLE projectdraft.shipping_address_info
  (Address_id VARCHAR(15),
  Customer_id VARCHAR(15),
  Address_line1 VARCHAR(15),
  Address_line2 VARCHAR(15),
  City VARCHAR(15),
  state VARCHAR(15),
  zipcode VARCHAR(15),
  Cust_phone VARCHAR(15),
  PRIMARY KEY (Address_id),
  FOREIGN KEY (Customer_id) references projectdraft.customer);


create table projectdraft.orders
  (Orders_id VARCHAR(15),
  Order_date DATETIME,
  Paymentstatus VARCHAR(15),
  Billing_address VARCHAR(15),
  total VARCHAR(15),
  Customer_id VARCHAR(15),
  PRIMARY KEY (orders_id),
  FOREIGN KEY (Customer_id) REFERENCES projectdraft.customer);

create table projectdraft.payment_type
  (
  Payment_type_id VARCHAR(15),
  Payment_type    VARCHAR(15),
  PRIMARY KEY (Payment_type_id)
  );

create table projectdraft.paymentmethod
  (Payment_id VARCHAR(15),
  Customer_id VARCHAR(15),
  Payment_type_id VARCHAR(15),
  Payment_type VARCHAR(15),
  Card_Number VARCHAR(15),
  NameOnCard VARCHAR(15),
  CardExp DATETIME,
  Card_CSV_code VARCHAR(15),
  Billing_id VARCHAR(50),
  PRIMARY KEY (Payment_id),
  FOREIGN KEY (Customer_id) REFERENCES projectdraft.orders,
  FOREIGN KEY (Payment_type_id) REFERENCES projectdraft.payment_type);
  
create table projectdraft.orderpayment
  (Order_id varchar(15),
  Payment_id varchar(15),
  FOREIGN KEY (Order_id) REFERENCES projectdraft.orders,
  FOREIGN KEY (Payment_id) REFERENCES projectdraft.paymentmethod);

create table projectdraft.product_type
  (Prodtype_id VARCHAR(15),
  Prodtype_name VARCHAR(15)
  PRIMARY KEY (Prodtype_id)
  );

create table projectdraft.artist
  (Artist_id VARCHAR(15),
  Artist_name VARCHAR(15)
  PRIMARY KEY (Artist_id)
  )

create table projectdraft.track
  (Track_id VARCHAR(15),
  Track_name VARCHAR(15),
  Album_id VARCHAR(15),
  Artist_id VARCHAR(15),
  Prodtype_id VARCHAR(15),
  Track_price VARCHAR(15),
  PRIMARY KEY (Track_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist);

create TABLE projectdraft.album
  (Album_id VARCHAR(15),
  Album_name VARCHAR(15),
  Album_realease_year VARCHAR(15),
  Prodtype_id VARCHAR(15),
  Artist_id VARCHAR(15),
  Album_price VARCHAR(15),
  PRIMARY KEY (Album_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist,
  FOREIGN KEY (Prodtype_id) REFERENCES projectdraft.product_type);

create table projectdraft.merchandise
  (Merch_id VARCHAR(15),
  Merchandise_name VARCHAR(15),
  Prodtype_id VARCHAR(15),
  Artist_id VARCHAR(15),
  PRIMARY KEY (Merch_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist);


create table projectdraft.ticket
  (Ticket_id VARCHAR(15),
  Event_name VARCHAR(15),
  Event_date VARCHAR(15),
  Event_Location VARCHAR(15),
  Ticket_price VARCHAR(15),
  Prodtype_id VARCHAR(15),
  Artist_id VARCHAR(15),
  PRIMARY KEY (Ticket_id),
  FOREIGN KEY (Artist_id) REFERENCES projectdraft.artist,
  FOREIGN KEY (Prodtype_id) REFERENCES projectdraft.product_type
  )

create table projectdraft.inventory
  (Inventory_id VARCHAR(15),
  Sku_id VARCHAR(15),
  Category VARCHAR(15),
  Product_id VARCHAR(15),
  Prodtype_id VARCHAR(15),
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
  Order_Line_id   VARCHAR(15),
  Order_id        VARCHAR(15),
  Quantity        VARCHAR(15),
  Unit_price      VARCHAR(15),
  Sku_id          VARCHAR(15),
  Item_name       VARCHAR(15),
  Purchase_date   VARCHAR(15),
  Returnable_date VARCHAR(15),
  PRIMARY KEY (Order_Line_id),
  FOREIGN KEY (Sku_id) REFERENCES projectdraft.inventory,
  FOREIGN KEY (Order_id) REFERENCES projectdraft.orders
)

