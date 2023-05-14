
INSERT INTO ds_2002_hinton_final_project.item
(`item_key`)
SELECT DISTINCT  `item_key`
FROM ds_2002_hinton_final_project.staging_table;


INSERT INTO ds_2002_hinton_final_project.customer
(`customer_key`)
SELECT DISTINCT  `customer`
FROM ds_2002_hinton_final_project.staging_table;

DELETE FROM ds_2002_hinton_final_project.invoice
WHERE 1=1;


INSERT INTO ds_2002_hinton_final_project.invoice
(`invoice_key`)
SELECT DISTINCT `invoice_key`
FROM ds_2002_hinton_final_project.staging_table;

INSERT INTO ds_2002_hinton_final_project.invoice
(`total_sales`, `discount`, `quantity`)
SELECT `total_sales`, `discount`, `quantity`
FROM ds_2002_hinton_final_project.staging_table;








INSERT INTO ds_2002_hinton_final_project.fact_order
(`fact_order_key`, `invoice_key`, `item_key`, `customer_key`, `date_key`)
SELECT `fact_order_key`, `invoice_key`, `item_key`, `customer`, `day_key`
FROM ds_2002_hinton_final_project.staging_table
JOIN dim_day on dim_day.date = staging_table.date;



SELECT * FROM staging_table
