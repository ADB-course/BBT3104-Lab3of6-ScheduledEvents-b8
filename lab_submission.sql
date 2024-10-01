--CREATE A TABLE CALLED  'customer_service_'
CREATE TABLE `customer_service_kpi` (
`customer_service_KPI_timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
`customer_service_KPI_average_waiting_time_minutes` INT NOT NULL,
PRIMARY KEY (`customer_service_KPI_timestamp`));
-- CREATE EVN_average_customer_waiting_time_every_1_hour`
create EVENT EVN_average_customer_waiting_time_every_1_hour
on 
schedule EVERY 1 HOUR 
START CURRENT_TIMESTAMP + INTERVAL 1 HOUR
END CURRENT_TIMESTAMP + INTERVAL 1 HOUR
ON
COMPLETION PRESERVE
COMMENT'the average waiting time for customers who raised a ticket in the past 1 hour'
DO
UPDATE
`customer_service_ticket`
SET
`customer_service_total_wait_time_hour` = TIMESTAMPDIF(HOUR,
`customer_service_ticket_raise_time`,
CURRENT_TIMESTAMP),
`customer_service_ticket_last_update` = CONCAT('The last 1 HOUR recurring update was made at ', CURRENT_TIMESTAMP)
WHERE
`customer_service_ticket_resolved` = 0;