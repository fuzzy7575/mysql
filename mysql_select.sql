SELECT * FROM menudb.tbl_menu;
select menu_name from tbl_menu;
select 
	menu_code, 
    menu_name, 
    menu_price
from
	tbl_menu;
select * from tbl_menu;
select 6+3; 
select 6*3; 
select 6%3;

select now();
select concat('홍.','','길동');
select concat('홍.','','길동') as name;
select concat('홍.','','길동') as 'Full name';

select 
	menu_code,
    menu_name,
    menu_price
from
	tbl_menu
order by
	-- menu_price asc; -- 내림차순
    menu_price;
    
select 
	menu_code,
    menu_name,
    menu_price
from
	tbl_menu
order by
	menu_price desc; -- 내림차순
    
select 
	menu_code,
    menu_name,
    menu_price
from
	tbl_menu
order by
	menu_price desc,
    menu_name asc;
    
select 
	menu_code,
    menu_price,
    menu_code * menu_price 
from
	tbl_menu
order by
	menu_code * menu_price desc;
    
select 
	*, menu_code * menu_price 
from
	tbl_menu
order by
	menu_code * menu_price asc;
    
select field('A', 'A', 'B', 'C');
select field('B', 'A', 'B', 'C');

select
	*,field(orderable_status, 'N', 'Y')
from
	tbl_menu;
    
select
	menu_name,
    orderable_status,
    field(orderable_status, 'N', 'Y')
from
	tbl_menu
order by field(orderable_status, 'N', 'Y');

select
	category_code,
    category_name,
    ref_category_code
from
	tbl_category
order by
	-- ref_category_code --null 값이 가장 위에 나타난다.
	ref_category_code is null asc; -- asc 생략 가능 -- is null -- null 값이 가장 아래에 나타난다.
    
select
	category_code,
    category_name,
    ref_category_code
from
	tbl_category
order by
	ref_category_code is null desc, -- is null -> null 값인 것, is not null --> null 값이 아닌것
    ref_category_code desc; -- desc 생략 불가능
    
select
	menu_name,
    menu_price,
    orderable_status
from
	tbl_menu
where
	orderable_status = 'Y';
    
select
	menu_name,
    menu_price,
    orderable_status
from
	tbl_menu
where
	menu_price = 13000;
    
select
	menu_name,
    menu_price,
    orderable_status
from
	tbl_menu
where
	-- orderable_status <> 'Y';
	orderable_status != 'Y';
    
select
	menu_code,
    menu_name,
    menu_price
from
	tbl_menu
where
	menu_price <= 20000;

select 1 and 1;
select 1 and 0, 0 and 1, 0 and 0, 0 and null, null and 0;
select 1 and null, null and null;
select true and null, null and true;
select false and null, null and false;

select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	orderable_status = 'Y' and 
    category_code = 10;
    
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price > 5000 and 
    category_code = 10;

select 1 or 1, 1 or 0, 0 or 1;
select 0 or 0;
select false or false;
select 1 or null, 0 or null, null or null;

select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	orderable_status = 'Y' or 
    category_code = 10
order by
	category_code;
    
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price > 5000 or 
    category_code = 10;

select 1 or 0 and 0;
select (1 or 0) and 0;

select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	category_code = 4 or 
    menu_price = 9000 and
    menu_code > 10;
    -- category_code = 4 or (menu_price = 9000 and menu_code > 10);

select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price >= 10000 and 
    menu_price <= 25000
order by
    menu_price;
    
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price between 10000 and 25000
order by
    menu_price;
    
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price not between 10000 and 25000
order by
    menu_price;
    
select
	menu_name,
    menu_price
from
	tbl_menu
where
	menu_name like '%마늘%'; -- '%' : 0개 이상의 임의의 문자 , '_' : 하나의 임의의 문자
    
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price > 5000 and
    category_code = 10 and
    menu_name like '%갈치%';
    
select
    menu_name,
    menu_price    
from
	tbl_menu
where
    menu_name not like '%마늘%'
order by
	menu_name;
    
select
	menu_name,
    category_code
from
	tbl_menu
where
	category_code = 4 or
	category_code = 5 or
	category_code = 6
order by
	category_code;
    
select
	menu_name,
    category_code
from
	tbl_menu
where
	category_code in (4, 5, 6)
    -- category_code in (4, 5, 6) -- 부정표현
order by
	category_code;
    
select
    category_code,
    category_name,
    ref_category_code
from
	tbl_category
where
	-- ref_category_code is null
    ref_category_code is not null;
    
    




  