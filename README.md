# eCommerce


eCommerce is plain old java project with jsp pages to create a shopping cart application with payment processing through paypal api.  Application can run on any database and jdbc driver.  What bundled in the application is scripts and driver to run mysql.  It's a working application that can be replicated with small chances.  You can standup a new application up quickly.


# Setup
  - Run Table.sql
  - Run currency.sql
  - Run wood_category.sql
  - Run wood_product.sql
  - Run pricing
  - Run quanity.sql to update real product quantity from our warehouse inventory.


# ENCRYPTION

  - Take input string
  - Use Base64 (encrypt/decrypt)
  - Use crypto (encrypt/decrypt)
  - Sample: 
  	java test.security.CryptoTest crypto encrypt "eBiz is a global trading company for both import and export" "DES" "brando_1236904149_biz_api1.yahoo.com"
  	java test.security.CryptoTest base64 encrypt "eBiz is a global trading company for both import and export"
	java test.security.CryptoTest crypto decrypt "eBiz is a global trading company for both import and export" "DES" "mh0Va/SgAqF3w7Ect2/SsQ=="

### Dependencies

* [MySQL] - Database to host product catalog
* [Java lib] - Libraries included in the project already
* [Web Server] - Install any webserver running JSP pages ie. Tomcat
```



License
----

None

