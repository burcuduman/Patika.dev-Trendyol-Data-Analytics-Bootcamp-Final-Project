# E-commerce brand's growth analysis and marketing campaign strategy planning by using Google BigQuery
In this project I have coducted a comprehensive analysis  regarding the following questions by using an ecommerce brand’s online shopping dataset (private). The dataset was consisting of two datasets as transaction and users. 
- [x] **Transaction dataset** has all the orders with details as order_parent_id which is unique order id, shipment_district_id, order_date,business_unit_name as category, shipment_number which is same as order_parent_id if there is no products from different retailers and if 1 order_parent_id has different shipment_number s it means that the basket was consisting of products from different retailers. Transaction dataset also has products_content_id, total_amount, user_id and Platform fields where Platform is Core if event happened in core business of the e-commerce brand and Grocery if event happened in fast-delivery business application of the brand.
- [x] **Users dataset** has information about the people shopping from those platforms of e-commerce business. It includes user speific fields as create_date, first_order_date, gender, birth_date and unique user_id.

First business question is, before the brand’s fast-delivery business didn’t start I have been asked for choosing a pilot district to start the business. Secondly, I have prepared a growth analysis of this new feature for its first 3 months. In the third question, I have made an analysis for customer acquisition campaign from the group of people who is using the core business of the e-commerce brand but not the fast-delivery feature. Lastly, I have conducted a basket analysis and product bundling for retailers’ and e-commerce brand’s benefit. The details of the analysis can be found below.

The visualisation of this project's results can be found from [my Google Sheets profile](https://docs.google.com/spreadsheets/d/1w_r572EJVW-PV2uR9mcCAp3IaAYdElUmcilN4x7jv3Y/edit?usp=sharing)


## [Question 1](https://github.com/burcuduman/Patika.dev-Trendyol-Data-Analytics-Bootcamp-Final-Project/blob/master/Final_Q1.sql)

Before the brand’s fast-delivery business didn’t start I have been asked for choosing a pilot district to start the business. 
For that purpose, I thought that fast-delivery business will be in categories of grocery, and I have analyzed the grocery categories among core business of the ecommerce brand. Then I looked at the average sellout of each grocery category because some anomalies may arise such as if skincare category’s average price is more than the market skincare average insight, I shouldn’t consider that. By using those insights, I have found out the most eligible categories for demo district of fast-delivery business. In my opinion, the first district that has the most sellout in grocery categories would be a great fit for demo of fast-delivery, because the customers living in this district has already been shopping from the grocery categories and they will only be experiencing the fast-delivery feature. Therefore, the most successful district will be the demo district since, if we fail in the most eligible district, we can’t survive in districts that has average or no sellout in grocery categories, so that it would be waste of money and sources to invest there. By using the popularity for each category, I have ranked the districts and found out that district number 31 is the appropriate one for testing our fast-delivery business since it is number 1 in 7 categories out of 9. 


## Question 2

In this question, I have prepared a growth analysis of the brand’s new feature as fast-delivery business, for its first 3 months. 
I have chosen the grocery categories of core business and all fast-delivery business. I compared the last 6 months average before fast-delivery and first 3 months of fast-delivery business.
In the first part: I have looked at the amount of new user registered in each of 3 months and the average new user amount in last 6 months before fast-delivery. I saw that the trendline is growing but not remarkably. [Question 2 part 1](https://github.com/burcuduman/Patika.dev-Trendyol-Data-Analytics-Bootcamp-Final-Project/blob/master/Final_Q2_part1.sql) 

Second and third part: I analyzed the order count of each month and average of 6 months before fast-delivery. The results show that the orders are outstandingly increased after fast-delivery, but it shows that the count of products may have been decreased in baskets therefore, there is more checkout of baskets but same number of products because, in third analysis we see that the amount of sellout revenue has not changed that significantly. 
[Question 2 part 2](https://github.com/burcuduman/Patika.dev-Trendyol-Data-Analytics-Bootcamp-Final-Project/blob/master/Final_Q2_part2.sql) , 
[Question 2 part 3](https://github.com/burcuduman/Patika.dev-Trendyol-Data-Analytics-Bootcamp-Final-Project/blob/master/Final_Q2_part3.sql)

To sum up, the growth analysis seems uncertain because the amount of data is not yet enough for making a radical decision as stopping this business or investing more here.


## [Question 3](https://github.com/burcuduman/Patika.dev-Trendyol-Data-Analytics-Bootcamp-Final-Project/blob/master/Final_Q3.sql)

In third question I have been asked to perform an analysis for customer acquisition campaign from the group of people who is using the core business of the ecommerce brand but not the fast-delivery feature. 
+ I have implemented a metric for choosing the people for this campaign which is engagement. I have calculated the engagement of customer by looking at the count of orders of each user ID. By box plotting the count of orders , I see that median of this data is 5 as it is quartile 50 and 17 is 75% which is quartile 75. Therefore, it explains that if a customer’s order count stands between 5 and 17 it seems that the customer is a potential loyal one, so the group of people I would be nominating for an acquisition campaign would be the ones between quartile 50 and 75.


## [Question 4](https://github.com/burcuduman/Patika.dev-Trendyol-Data-Analytics-Bootcamp-Final-Project/blob/master/Final_Q4.sql)

Lastly, I have conducted a basket analysis and product bundling for retailers’ and ecommerce brand’s benefit. I would like to optimize the marketing strategies and campaigns also identify the customer behavior better by performing this analysis. Since data did not include product names but only productIDs I couldn’t identify the real-life counterparts of this bundles. 
At first, I have started by finding the baskets that has only 2 or 3 different products in it because the data was very large and I have limited access to Google BigQuery. After that, I have counted all products’ order count regardless from any condition. The reason for that is, I calculated a sell rate for each product in a bundle by using how many times sold alone info and how many times sold with “product X”. With that rate, I countered such cases that: product Y is sold 116 times with products X and product Y is sold 1442 times in all orders and product X is sold 6131 times. The sell rate of product X is 8.04% among bundled with product Y but sell rate of product Y is 1.89%. This analysis shows that: when product X is sold it is more likely that product Y will be added however when product Y is sold it is 4 times less likely that product X will be added to the basket. Another case I have founded is, a product is sold only in a bundle with another specific product which can be explained as product A is only useful when sold with product B.

+ You can see detailed results from Q4 sheet of [my Google Sheets profile](https://docs.google.com/spreadsheets/d/1w_r572EJVW-PV2uR9mcCAp3IaAYdElUmcilN4x7jv3Y/edit?usp=sharing)


