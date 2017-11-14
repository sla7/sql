drop TABLE projectdraft.billinginfo
drop TABLE projectdraft.customer
drop TABLE projectdraft.orders

create table projectdraft.customer
  (Customer_id varchar(15),
  First_name varchar(15),
  Last_Name VARCHAR(15)
  primary key (Customer_id));

create table projectdraft.billinginfo
  (billinginfo_id VARCHAR(15),
  Billing_Name VARCHAR(15),
  Billing_Number NUMERIC(15),
  Customer_id   VARCHAR(15)
  PRIMARY KEY (billinginfo_id),
  foreign key (Customer_id) references projectdraft.customer);

create table projectdraft.orders
  (PRIMARYKEY Varchar(15),
  Orders_id VARCHAR(15),
  order_date DATETIME,
  paymentstatus VARCHAR(15),
  Billing_address VARCHAR(15),
  total VARCHAR(15),
  Customer_id VARCHAR(15),
  PRIMARY KEY (orders_id),
  FOREIGN KEY (Customer_id) REFERENCES projectdraft.customer);

create table projectdraft.paymentmethod
  (Payment_id VARCHAR(15),
  Customer_id VARCHAR(15),
  Payment_type VARCHAR(15),
  Card_Number VARCHAR(15),
  NameOnCard VARCHAR(15),
  CardExp DATETIME,
  BillingAddress VARCHAR(50),
  PRIMARY KEY (Payment_id),
  FOREIGN KEY (Customer_id) REFERENCES projectdraft.orders);

/* need primary key? */
create table projectdraft.orderpayment
  (Order_id varchar(15),
  Payment_id varchar(15),
  FOREIGN KEY (Order_id) REFERENCES projectdraft.orders,
  FOREIGN KEY (Payment_id) REFERENCES projectdraft.paymentmethod);


create table projectdraft.inventory
  (sku_id VARCHAR(15),
  category VARCHAR(15),
  Inventory_id VARCHAR(15),
  returnable VARCHAR(15),
  PRIMARY KEY (sku_id),
  )

create table projectdraft.orderdetails
  (Order_id VARCHAR(15),
  Quantity VARCHAR(15),
  Unit_price VARCHAR(15),
  sku_id VARCHAR(15),
  item VARCHAR(15),
  returnable VARCHAR(15),
  PRIMARY KEY (Order_id),
  FOREIGN KEY (sku_id) REFERENCES projectdraft.inventory)

