with Grocery_items as (

select distinct Category,avg(total_amount) over(partition by Category) as avg_Revenue_of_Sellout, Count_of_Sellout
from ( 
    
    select tran.business_unit_name as Category, tran.total_amount, 
    count(tran.total_amount) over(partition by tran.business_unit_name) as Count_of_Sellout,
    
    from `project250222.dataset_ty25.final_case_transaction` as tran
    full join `project250222.dataset_ty25.final_case_users` as users on users.user_id=tran.user_id
    where  tran.order_date < timestamp("2020-06-01 23:59:00+03") --TR time UTC+3
    and tran.business_unit_name in ("Bebek Bezi & Mendil", "Cilt Bakım", "Anne & Bebek Ürünleri", "Kırtasiye & Ofis", 
    "Petshop", "Gıda ve İçecek", "Ev Gereçleri", "Saç Bakım", "Kişisel Bakım","Sofra & Mutfak", "Ev Bakım ve Temizlik", "Anne & Bebek Bakım" )
) order by 3 desc
) --tahmin ettiğim Grocery kategorilerini test ettim, avg sepet tutarı 100 TL üstünde olanları Yerel Market için uygun bulmadım.

,
datas as(
select distinct Category, District, count( distinct users) over(partition by Category,District) as Distinct_Users, 
sum(total_amount) over(partition by Category,District) as Revenue_of_Sellout_byCategory,
 Count_of_Sellout, Count_user_all
from ( 
    
    select tran.business_unit_name as Category, tran.total_amount, users.user_id as users,-- kullanıcı idleri 
    count(tran.user_id) over(partition by tran.business_unit_name) as Count_user_all,--kaç farklı kullanıcı satın alım yapmış Kategori bazlı (o kategoriden kaç farklı user alışveriş yapmış)
    tran.SHIPMENT_DISTRICT_ID as District,--District
    count(tran.total_amount) over(partition by tran.business_unit_name,tran.SHIPMENT_DISTRICT_ID) as Count_of_Sellout --kaç kere para harcanmış Kategori ve District bazlı
    from `project250222.dataset_ty25.final_case_transaction` as tran
    join `project250222.dataset_ty25.final_case_users` as users on users.user_id=tran.user_id-- Kullanıcı idleri aynı olan satırlara göre joinledim
    where  tran.order_date < timestamp("2020-06-01 23:59:00+03") --TR time UTC+3
    and tran.business_unit_name in ("Bebek Bezi & Mendil", "Petshop", "Gıda ve İçecek", "Ev Gereçleri", "Saç Bakım",
     "Kişisel Bakım","Sofra & Mutfak", "Ev Bakım ve Temizlik", "Anne & Bebek Bakım" )

) where Count_user_all > 1
order by 3 desc, 4 desc
--En popüler kategorileri District'e göre belirledim.
)
select * from(
select *, row_number() over(partition by Category order by Distinct_Users desc, Revenue_of_Sellout_byCategory desc ) as rank
from datas
order by Distinct_Users desc, Revenue_of_Sellout_byCategory desc 
)
where rank in (1,2,3,4,5)

--sonuç: District 31'i seçerdim
