Create Database if not exists `order-directory` ;
use `order-directory`;



create table if not exists `supplier`(
`SUPP_ID` int primary key,
`SUPP_NAME` varchar(50) ,
`SUPP_CITY` varchar(50),
`SUPP_PHONE` varchar(10)
);




CREATE TABLE IF NOT EXISTS `customer` (
  `CUS_ID` INT NOT NULL,
  `CUS_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `CUS_PHONE` VARCHAR(10),
  `CUS_CITY` varchar(30) ,
  `CUS_GENDER` CHAR,
  PRIMARY KEY (`CUS_ID`));
  
/***************************************************/

CREATE TABLE IF NOT EXISTS `category` (
  `CAT_ID` INT NOT NULL,
  `CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,
 
  PRIMARY KEY (`CAT_ID`)
  );



  CREATE TABLE IF NOT EXISTS `product` (
  `PRO_ID` INT NOT NULL,
  `PRO_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `PRO_DESC` VARCHAR(60) NULL DEFAULT NULL,
  `CAT_ID` INT NOT NULL,
  PRIMARY KEY (`PRO_ID`),
  FOREIGN KEY (`CAT_ID`) REFERENCES CATEGORY (`CAT_ID`)
  
  );
  
  /*******************************************************/
  
  CREATE TABLE IF NOT EXISTS `product_details` (
  `PROD_ID` INT NOT NULL,
  `PRO_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `PROD_PRICE` INT NOT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES PRODUCT (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER(`SUPP_ID`)
  
  );


 
CREATE TABLE IF NOT EXISTS `order` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`)
  );


/*********************************************************************/

CREATE TABLE IF NOT EXISTS `rating` (
  `RAT_ID` INT NOT NULL,
  `CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`)
  );

/***********************************************************************/

insert into `supplier` values(1,"Rajesh Retails","Delhi",'1234567890');
insert into `supplier` values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into `supplier` values(3,"Knome products","Banglore",'9785462315');
insert into `supplier` values(4,"Bansal Retails","Kochi",'8975463285');
insert into `supplier` values(5,"Mittal Ltd.","Lucknow",'7898456532');




  
INSERT INTO `CUSTOMER` VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO `CUSTOMER` VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO `CUSTOMER` VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO `CUSTOMER` VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO `CUSTOMER` VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');

/***********************************************************************/

INSERT INTO `CATEGORY` VALUES( 1,"BOOKS");
INSERT INTO `CATEGORY` VALUES(2,"GAMES");
INSERT INTO `CATEGORY` VALUES(3,"GROCERIES");
INSERT INTO `CATEGORY` VALUES (4,"ELECTRONICS");
INSERT INTO `CATEGORY` VALUES(5,"CLOTHES");
  

  
INSERT INTO `PRODUCT` VALUES(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
INSERT INTO `PRODUCT` VALUES(2,"TSHIRT","DFDFJDFJDKFD",5);
INSERT INTO `PRODUCT` VALUES(3,"ROG LAPTOP","DFNTTNTNTERND",4);
INSERT INTO `PRODUCT` VALUES(4,"OATS","REURENTBTOTH",3);
INSERT INTO `PRODUCT` VALUES(5,"HARRY POTTER","NBEMCTHTJTH",1);

/***********************************************************************/

INSERT INTO PRODUCT_DETAILS VALUES(1,1,2,1500);
INSERT INTO PRODUCT_DETAILS VALUES(2,3,5,30000);
INSERT INTO PRODUCT_DETAILS VALUES(3,5,1,3000);
INSERT INTO PRODUCT_DETAILS VALUES(4,2,3,2500);
INSERT INTO PRODUCT_DETAILS VALUES(5,4,1,1000);
  

  
INSERT INTO `ORDER` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDER` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDER` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDER` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDER` VALUES(30,3500,"2021-08-16",4,3);

/**************************************************************************/
INSERT INTO `RATING` VALUES(1,2,2,4);
INSERT INTO `RATING` VALUES(2,3,4,3);
INSERT INTO `RATING` VALUES(3,5,1,5);
INSERT INTO `RATING` VALUES(4,1,3,2);
INSERT INTO `RATING` VALUES(5,4,5,4);

/**************************************************************************/
/*question 3*/
select CUS_GENDER,count(CUS_GENDER) as GENDER_COUNT from (select CUS_GENDER from customer,(select CUS_ID from `order` where ORD_AMOUNT > 3000) as table1 
where customer.CUS_ID = table1.CUS_ID) as table2 group by CUS_GENDER;

/**************************************************************************/
/*question 4*/
select table4.ORD_ID, table4.ORD_AMOUNT, table4.ORD_DATE, table4.CUS_ID, table4.PROD_ID, product.PRO_NAME 
from (select table3.ORD_ID, table3.ORD_AMOUNT, table3.ORD_DATE, table3.CUS_ID, product_details.PROD_ID from (select * from `order` where CUS_ID = 2) as table3,product_details where table3.PROD_ID = product_details.PROD_ID) as table4,product
where table4.PROD_ID = product.PRO_ID; 

/**************************************************************************/
/*question 5*/
select * from supplier where SUPP_ID in (select SUPP_ID from product_details group by SUPP_ID having count(PROD_ID) > 1);
/**************************************************************************/
/*question 6*/
select * from category where CAT_ID in (select CAT_ID from product where PRO_ID in (select PRO_ID from product_details where PROD_ID in (select PROD_ID from (select PROD_ID,ORD_AMOUNT from `order` having ORD_AMOUNT = min(ORD_AMOUNT)) as table1))); 
/**************************************************************************/
/*question 7*/
select PRO_ID, PRO_NAME from product where PRO_ID in (select PRO_ID from product_details where PROD_ID in (select PROD_ID from `order` where ORD_DATE > '2021-10-05'));
/**************************************************************************/
/*question 8*/
select tablex.SUPP_ID, tablex.SUPP_NAME, customer.CUS_NAME, tablex.RAT_RATSTARS from (select supplier.SUPP_ID, supplier.SUPP_NAME, rating.RAT_ID, rating.CUS_ID, rating.RAT_RATSTARS from supplier,rating where supplier.SUPP_ID = rating.SUPP_ID) as tablex,customer 
where tablex.CUS_ID = customer.CUS_ID order by RAT_RATSTARS desc limit 3;
/**************************************************************************/
/*question 9*/
select CUS_NAME, CUS_GENDER from customer where CUS_NAME like 'A%' or CUS_NAME like '%A';
/**************************************************************************/
/*question 10*/
select sum(ORD_AMOUNT) from (select `order`.ORD_AMOUNT, customer.CUS_GENDER from customer,`order` where `order`.CUS_ID = customer.CUS_ID) as table1 where CUS_GENDER = 'M';
/**************************************************************************/
/*question 11*/
select * from customer left join`order` on `order`.CUS_ID = customer.CUS_ID;
/**************************************************************************/
/*question 12*/
select tablex.SUPP_ID, tablex.SUPP_NAME, tablex.RAT_RATSTARS, 'Genuine Supplier' as verdict from (select supplier.SUPP_ID, supplier.SUPP_NAME, rating.RAT_RATSTARS from supplier,rating  where supplier.SUPP_ID = rating.SUPP_ID) as tablex where tablex.RAT_RATSTARS  > 4
union
select tabley.SUPP_ID, tabley.SUPP_NAME, tabley.RAT_RATSTARS, 'Average Supplier' as verdict from (select supplier.SUPP_ID, supplier.SUPP_NAME, rating.RAT_RATSTARS from supplier,rating  where supplier.SUPP_ID = rating.SUPP_ID) as tabley where tabley.RAT_RATSTARS  <= 4 AND tabley.RAT_RATSTARS > 2
union
select tablez.SUPP_ID, tablez.SUPP_NAME, tablez.RAT_RATSTARS, 'Supplier not considered' as verdict from (select supplier.SUPP_ID, supplier.SUPP_NAME, rating.RAT_RATSTARS from supplier,rating  where supplier.SUPP_ID = rating.SUPP_ID) as tablez where tablez.RAT_RATSTARS <= 2;
