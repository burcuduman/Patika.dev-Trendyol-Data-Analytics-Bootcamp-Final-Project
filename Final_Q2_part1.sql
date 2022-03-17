select distinct
count(distinct users) over(partition by User_Create_Flag) as Monthly_new_user_count, User_Create_Flag 

from(
select tran.business_unit_name as Category,
users.user_id users,
users.create_date,
users.first_order_date,
tran.order_date,
tran.Platform,
tran.total_amount,

case when users.create_date < timestamp("2020-09-01 23:59:00+03") AND users.create_date > timestamp("2020-08-01 00:00:00+03") then 'Agustos'
    when users.create_date < timestamp("2020-08-01 00:00:00+03") AND users.create_date> timestamp("2020-07-01 00:00:00+03") then 'Temmuz'
    when users.create_date < timestamp("2020-07-01 00:00:00+03") AND users.create_date > timestamp("2020-06-01 00:00:00+03") then 'Haziran'
    when users.create_date < timestamp("2020-06-01 00:00:00+03") AND users.create_date > timestamp("2019-12-01 00:00:00+03") then 'Before_Feature'
    else null
end as User_Create_Flag


from `project250222.dataset_ty25.final_case_transaction` as tran
    join `project250222.dataset_ty25.final_case_users` as users on users.user_id=tran.user_id
where tran.order_date < timestamp("2020-09-01 23:59:00+03") 
and tran.business_unit_name in ("Bebek Bezi & Mendil", "Petshop", "Gıda ve İçecek", "Ev Gereçleri", "Saç Bakım",
     "Kişisel Bakım","Sofra & Mutfak", "Ev Bakım ve Temizlik", "Anne & Bebek Bakım" )
)