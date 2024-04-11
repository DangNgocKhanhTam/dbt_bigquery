with dim_date__generate as (
select 
*
from unnest(generate_date_array('2010-01-01', '2030-12-31', interval 1 day)) as date
), dim_date__enrich as (
select 
*, 
FORMAT_DATE('%A', date ) date_of_week, 
FORMAT_DATE('%a', date ) date_of_week_short, 
DATE_TRUNC(date, MONTH) year_month, 
FORMAT_DATE('%B', date) month, 
EXTRACT(YEAR FROM date) year_number
from dim_date__generate
) 
select 
*, 
case when date_of_week_short in ('Mon', 'Tue', 'Wed', 'Thu', 'Fri') then "Weekday"
     when date_of_week_short in ('Sat', 'Sun') then 'Weekend'
     else 'Invalid' end is_weekday_or_weekend
from dim_date__enrich 
