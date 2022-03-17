/* --detect the districts where fast-delivery business maybe not yet opened
    select distinct SHIPMENT_DISTRICT_ID, sum(flag) over(partition by SHIPMENT_DISTRICT_ID) from(    
        
        select  SHIPMENT_DISTRICT_ID, 
        case when Platform="Grocery" then 1 else 0 end as flag

        from `project250222.dataset_ty25.final_case_transaction` 
        where order_date < timestamp("2021-07-01 00:00:00+03") 
    )
    */

with datas as(
select distinct user_id,order_count from(

    select distinct user_id, order_parent_id , sum(flag) over(partition by user_id) as count_flag, count(order_parent_id) over(partition by user_id) as order_count from(


        select  user_id, order_parent_id, 
        case when Platform="Grocery" then 1 else 0 end as flag --we want core business users that has never shopped in Grocery (fast-delivery business)

        from `project250222.dataset_ty25.final_case_transaction` 
        where order_date < timestamp("2021-07-01 00:00:00+03") and SHIPMENT_DISTRICT_ID not in (58,61,33,34,62,60)
    ) ) where count_flag=0 

order by order_count desc
),


--box plot
quartiles as (
select q[offset(1)] q25,q[offset(2)] q50, q[offset(3)] q75 from
( select approx_quantiles(order_count, 4) q  from  datas))

select * from quartiles 