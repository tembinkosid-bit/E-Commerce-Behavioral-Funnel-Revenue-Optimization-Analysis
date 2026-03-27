--Daily Metrices table

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'daily_metrics';

/* Data type for total events,views,carts ,revenue and purchases is currently nvarchar needs to be changed to data type INT and revenue changed to decimal(10.2)*/

--Data type Changes

  alter table daily_metrics
  alter column total_events  INT;

   alter table daily_metrics
  alter column total_views  INT;
 
  alter table daily_metrics
  alter column total_carts  INT;

   alter table daily_metrics
  alter column total_purchases  INT;

   alter table daily_metrics
  alter column revenue  Decimal(10,2);


  --Product_fact Table

 SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'product_fact';

/* the tbale shows that avg_price,total_views,total_carts,total_purchases and revenue are nvarchar while they all need to be INT and avg_price and revenue as Decimal(10,2)*/

--Data type change
alter table product_fact
alter column category_id BIGINT;

alter table product_fact
alter column total_views INT;

alter table product_fact
alter column total_carts INT;

alter table product_fact
alter column total_purchases INT;

alter table product_fact
alter column avg_price Decimal(10,2);

alter table product_fact
alter column revenue Decimal(10,2);

--session_fact

 SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'session_fact';

/*revenue is placed as float need to change to Decimal(10,2)*/

alter table session_fact
alter column revenue Decimal(10,2);

alter table session_fact
alter column category_id BIGINT;

alter table session_fact
alter column total_views INT;

alter table session_fact
alter column total_carts INT;

alter table session_fact
alter column total_purchases INT;