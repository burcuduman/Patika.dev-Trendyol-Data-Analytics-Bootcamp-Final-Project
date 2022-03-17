with Bundle_products as(
select * , row_number() over(partition by order_parent_id order by product_content_id) as rownumber from(
select distinct user_id, order_parent_id, shipment_number, product_content_id, 
count(distinct product_content_id) over(partition by order_parent_id, order_date ) as different_product_orders_howmany
    
    from `project250222.dataset_ty25.final_case_transaction` as tran

    
) where different_product_orders_howmany > 1 and different_product_orders_howmany <4 -- looking the baskets only 2 or 3 distinct products are ordered.
order by order_parent_id
),

oldsystem as (
select * from Bundle_products
),

newsystem as (
select * from Bundle_products
),


Tuples as(

    select distinct oorder, op, norder,np, row_number() over(partition by oorder order by op) as row  from (
        select oldsystem.order_parent_id oorder, oldsystem.product_content_id op , newsystem.order_parent_id  norder, newsystem.product_content_id np from oldsystem 
        FULL OUTER JOIN NEWSYSTEM ON NEWSYSTEM.order_parent_id =OLDSYSTEM.order_parent_id 
        where oldsystem.product_content_id!=newsystem.product_content_id

)), --finding tuples in baskets by using outer join

How_many_alone as (

select distinct product_content_id,count(SHIPMENT_DISTRICT_ID) over(partition by product_content_id ) as how_many 
from `project250222.dataset_ty25.final_case_transaction` as tran
order by how_many desc
) --finding a products order count regardless from anything



select * from
(

    select distinct product_content_id, Tuples.np, 
    count(order_parent_id) over(partition by product_content_id,Tuples.np) as how_manytimes_sold_together 
    from(
            select distinct user_id, order_parent_id, shipment_number, product_content_id, 
            count(distinct product_content_id) over(partition by order_parent_id) as different_product_orders_howmany
            from `project250222.dataset_ty25.final_case_transaction` as tran
    
        ) as all_baskets inner join Tuples on Tuples.op=all_baskets.product_content_id and Tuples.oorder=all_baskets.order_parent_id
    where different_product_orders_howmany > 1
    order by how_manytimes_sold_together desc,product_content_id,Tuples.np 
) 
as Tuples1 inner join How_many_alone on Tuples1.product_content_id=How_many_alone.product_content_id
where how_many > 99 --for analysing a bundle I have decideded on a condition such as, a product must have been sold at least 100 times for being considered in my analysis.
order by  how_manytimes_sold_together desc
