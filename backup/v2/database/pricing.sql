-- Step 1 Update US width, length, height and base price


update wood_product set name=vendor_name,
			width=vendor_width*0.39,
			length=vendor_length*0.39,
			height=vendor_height*0.39,
			base_price=(vendor_price/(select other from currency where type = 'VN'));
			
			
-- where product_id = 170;	price = 7.06

-- Step 2: Update price by adding shipping, import_tax and margin, floor it to INT number then add 99 cents

update wood_product wp set price=floor(base_price+shipping_cost+(select base_price*import_tax_rate from wood_category wc where wc.category_id = wp.category_id)+(select base_price*margin from wood_category wc where wc.category_id = wp.category_id))+0.99


-- select product_id, category_id, image_name, width,length,height,base_price, price,vendor_width, vendor_length, vendor_height, vendor_price from wood_product;

-- select price*import_tax_rate from wood_category wc, wood_product wp where wc.category_id = wp.category_id and wp.product_id = 170

-- select price*margin from wood_category wc, wood_product wp where wc.category_id = wp.category_id and wp.product_id = 170

-- select price, vendor_price from wood_product where product_id = 170;