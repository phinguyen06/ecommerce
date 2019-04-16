READ_ME

Step 1:  Run Table.sql

Step 2:  Run currency.sql

Step 3:  Run wood_category.sql

Step 4:  Run wood_product.sql

Step 5:  Run pricing

Step 6:  Run quanity.sql to update real product quantity from our warehouse inventory.  





ENCRYPTION

Step 1: Take input string

Step 2: Use Base64 (encrypt/decrypt)

Step 3: Use crypto (encrypt/decrypt)

java test.security.CryptoTest crypto encrypt "eBiz is a global trading company for both import and export" "DES" "brando_1236904149_biz_api1.yahoo.com"
java test.security.CryptoTest base64 encrypt "eBiz is a global trading company for both import and export"


java test.security.CryptoTest crypto decrypt "eBiz is a global trading company for both import and export" "DES" "mh0Va/SgAqF3w7Ect2/SsQ=="




BY DEFAULT MYSQL set Autocommit to TRUE

mysql> select @@autocommit;

mysql> set @@autocommit = 0;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            0 |
+--------------+
1 row in set (0.00 sec)