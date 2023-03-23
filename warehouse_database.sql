USE warehouse;

CREATE TABLE `fact_order` (
  `fact_order_key` int NOT NULL AUTO_INCREMENT,
  `date_key` int NOT NULL,
  `item_key` int NOT NULL,
  `supplier_key` int NOT NULL,
  `retail_sales` double DEFAULT NULL,
  `retail_transfers` double DEFAULT NULL,
  `warehouse_sales` double DEFAULT NULL,
  PRIMARY KEY (`fact_order_key`),
 FOREIGN KEY (date_key) REFERENCES date(date_key),
  FOREIGN KEY (item_key) REFERENCES item(item_key),
   FOREIGN KEY (supplier_key) REFERENCES supplier(supplier_key)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `date` (
  `date_key` int NOT NULL AUTO_INCREMENT,
  `year` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  PRIMARY KEY (`date_key`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `item` (
  `item_key` int NOT NULL AUTO_INCREMENT,
  `item_code` int DEFAULT NULL,
  `item_description` longtext DEFAULT NULL,
  `item_type` varchar(50),
  PRIMARY KEY (`item_key`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `supplier` (
  `supplier_key` int NOT NULL AUTO_INCREMENT,
  `supplier` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`supplier_key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

INSERT INTO `warehouse`.`dim_item`
(`item_code`,
`item_description`,
`item_type`)
SELECT `item code`,
`item description`,
`item type`
FROM new_schema.warehouse_dw;

INSERT INTO `warehouse`.`dim_supplier`
(`supplier`)
SELECT `supplier`
FROM new_schema.warehouse_dw;

SELECT date_key, item_key, supplier_key, `retail sales`, `retail transfers`, `warehouse sales`
FROM new_schema.warehouse_dw
JOIN warehouse.dim_date
ON warehouse_dw.year = dim_date.calendar_year AND warehouse_dw.month = dim_date.month_of_year
JOIN warehouse.dim_item
ON warehouse_dw.`item code` = dim_item.item_code AND warehouse_dw.`item description` = dim_item.item_description AND warehouse_dw.`item type` = dim_item.item_type
JOIN warehouse.dim_supplier
ON warehouse_dw.`supplier` = dim_supplier.supplier



INSERT INTO `warehouse`.`dim_date`
(`month_of_year`,
`calendar_year`
)
SELECT DISTINCT `month`, 
`year` 
FROM new_schema.warehouse_dw;



INSERT INTO `warehouse`.`fact_order`
(`date_key`,
`item_key`,
`supplier_key`,
`retail_sales`,
`retail_transfers`,
`warehouse_sales`
)
SELECT date_key, item_key, supplier_key, `retail sales`, `retail transfers`, `warehouse sales`
FROM new_schema.warehouse_dw
JOIN warehouse.dim_date
ON warehouse_dw.year = dim_date.calendar_year AND warehouse_dw.month = dim_date.month_of_year
JOIN warehouse.dim_item
ON warehouse_dw.`item code` = dim_item.item_code AND warehouse_dw.`item description` = dim_item.item_description AND warehouse_dw.`item type` = dim_item.item_type
JOIN warehouse.dim_supplier
ON warehouse_dw.`supplier` = dim_supplier.supplier
LIMIT 50000


SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `dim_date` MODIFY `date_key` INT  NOT NULL AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;


DELETE FROM warehouse.dim_date WHERE `date_key` < 50000000