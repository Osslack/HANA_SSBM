/*BENCH 1*/
select sum(lo_extendedprice*lo_discount) as
revenue
from lineorder join  dim_date on lo_orderdatekey = d_datekey
where
d_year = 1993
and lo_discount between 1 and 3
and lo_quantity < 25;

select sum(lo_extendedprice*lo_discount) as revenue
from lineorder
join  dim_date on lo_orderdatekey = d_datekey
where  D_YearMonthNum = 199401 and lo_discount
between 4 and 6 and lo_quantity between 26 and 35;

select sum(lo_extendedprice*lo_discount) as revenue
from lineorder
join  dim_date on lo_orderdatekey = d_datekey
where  d_weeknuminyear = 6
and d_year = 1994
and lo_discount between 5 and 7 and lo_quantity between 26 and 35;


/*BENCH 2*/
select sum(lo_revenue), d_year, p_brand
from lineorder
join dim_date
 on lo_orderdatekey = d_datekey
join part
on lo_partkey = p_partkey join supplier
on lo_suppkey = s_suppkey
where  p_category = 'MFGR#12'
and s_region = 'AMERICA'
group by d_year, p_brand
order by d_year, p_brand;

select sum(lo_revenue), d_year, p_brand
from lineorder
join dim_date
on lo_orderdatekey = d_datekey
join part
on lo_partkey = p_partkey
join supplier
on lo_suppkey = s_suppkey
where  p_brand between 'MFGR#2221' and 'MFGR#2228'
and s_region = 'ASIA'
group by d_year, p_brand
order by d_year, p_brand;

select sum(lo_revenue), d_year, p_brand
from lineorder
join dim_date
on lo_orderdatekey = d_datekey
join part
on lo_partkey = p_partkey
join supplier
on lo_suppkey = s_suppkey
where  p_brand= 'MFGR#2239'
and s_region = 'EUROPE'
group by d_year, p_brand
order by d_year, p_brand;

/*BENCH 3*/
select c_nation, s_nation, d_year, sum(lo_revenue) as revenue
from customer
join lineorder
on lo_custkey = c_customerkey
join supplier
on lo_suppkey = s_suppkey
join dim_date   on lo_orderdatekey = d_datekey
where c_region = 'ASIA'
and s_region = 'ASIA'
and d_year >= 1992 and d_year <= 1997
group by c_nation, s_nation, d_year
order by d_year asc, revenue desc;

select c_city, s_city, d_year, sum(lo_revenue) as revenue
from customer
join lineorder
on lo_custkey = c_customerkey
join supplier
on lo_suppkey = s_suppkey
join dim_date
on lo_orderdatekey = d_datekey
where c_nation = 'UNITED STATES'
and s_nation = 'UNITED STATES'
and d_year >= 1992
and d_year <= 1997
group by c_city, s_city, d_year
order by d_year asc, revenue desc;

select c_city, s_city, d_year, sum(lo_revenue) as revenue
from customer
join lineorder
on lo_custkey = c_customerkey
join supplier   on lo_suppkey = s_suppkey
join dim_date   on lo_orderdatekey = d_datekey
where (c_city='UNITED KI1' or c_city='UNITED KI5')
and (s_city='UNITED KI1' or s_city='UNITED KI5')
and d_year >= 1992
and d_year <= 1997
group by c_city, s_city, d_year
order by d_year asc, revenue desc;

select c_city, s_city, d_year, sum(lo_revenue)
as revenue
from customer
join lineorder
  on lo_custkey = c_customerkey
join supplier
  on lo_suppkey = s_suppkey
join dim_date
  on lo_orderdatekey = d_datekey
where
(c_city='UNITED KI1' or c_city='UNITED KI5')
and (s_city='UNITED KI1' or s_city='UNITED KI5')
and d_yearmonth = 'Dec1997'
group by c_city, s_city, d_year
order by d_year asc, revenue desc;

/*BENCH 4*/
select d_year, c_nation,
sum(lo_revenue - lo_supplycost) as profit
from lineorder
join dim_date
  on lo_orderdatekey = d_datekey
join customer
  on lo_custkey = c_customerkey
join supplier
  on lo_suppkey = s_suppkey
join part
  on lo_partkey = p_partkey
where
c_region = 'AMERICA'
and s_region = 'AMERICA'
and (p_mfgr = 'MFGR#1'
or p_mfgr = 'MFGR#2')
group by d_year, c_nation
order by d_year, c_nation;

select d_year, s_nation, p_category,
sum(lo_revenue - lo_supplycost) as profit
from lineorder
join dim_date
  on lo_orderdatekey = d_datekey
join customer
  on lo_custkey = c_customerkey
join supplier
  on lo_suppkey = s_suppkey
join part
  on lo_partkey = p_partkey
where
c_region = 'AMERICA'
and s_region = 'AMERICA'
and (d_year = 1997 or d_year = 1998)
and (p_mfgr = 'MFGR#1'
or p_mfgr = 'MFGR#2')
group by d_year, s_nation, p_category
order by d_year, s_nation, p_category;

select d_year, s_city, p_brand,
sum(lo_revenue - lo_supplycost) as profit
from lineorder
join dim_date
  on lo_orderdatekey = d_datekey
join customer
  on lo_custkey = c_customerkey
join supplier
  on lo_suppkey = s_suppkey
join part
  on lo_partkey = p_partkey
where
s_nation = 'UNITED STATES'
and (d_year = 1997 or d_year = 1998)
and p_category = 'MFGR#14'
group by d_year, s_city, p_brand
order by d_year, s_city, p_brand;