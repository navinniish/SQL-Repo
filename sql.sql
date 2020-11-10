create database w1;
use database w1;

select * from final;

select date, tech , item_1 as Item, quantity_1 as Quantity
from final
union all
select date, tech , item_2, quantity_2
from final
union all
select date, tech ,item_3 , quantity_3
from final
union all
select date, tech ,item_4, quantity_4
from final
union all
select date, tech ,item_5, quantity_5
from final
union all
select date, tech ,item_6, quantity_6
from final
union all
select date, tech ,item_7, quantity_7
from final
union all
select date, tech ,item_8, quantity_8
from final
union all
select date, tech ,item_9, quantity_9
from final
union all
select date, tech ,item_10, quantity_10
from final
union all
select date, tech ,item_11, quantity_11
from final
union all
select date, tech ,item_12, quantity_12
from final
union all
select date, tech ,item_13, quantity_13
from final
union all
select date, tech ,item_14, quantity_14
from final
union all
select date, tech ,item_15, quantity_15
from final
group by tech, date
order by tech;