drop table staging_table;
CREATE TABLE staging_table (
    fact_order_key INT NOT NULL AUTO_INCREMENT,
    invoice_key int NOT NULL,
    import_date VARCHAR(12) NOT NULL,
    item_key int NOT NULL,
    total_sales Decimal(5,2),
    discount Decimal(5,2),
    customer int NULL,
    quantity int NULL,
    date date,
    PRIMARY KEY (fact_order_key)
);



# Load data
UPDATE staging_table SET date = STR_TO_DATE(import_date, '%Y-%m-%d');




