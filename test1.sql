select
	category_code,
    category_name
from
	tbl_category
where 
	ref_category_code is not null
order by
	category_name desc;
    
select
	menu_name,
    menu_price
from
	tbl_menu
where 
	menu_name like '%밥%' and
    menu_price >= 20000 and
    menu_price <= 30000;
    
select
	*
from
	tbl_menu
where
	menu_price < 10000 or
    menu_name like '%김치%'
order by
	menu_price asc,
    menu_name desc;
    
select
	a.*
from
	tbl_menu a
join tbl_category b on
	a.category_code = b.category_code and
    b.category_name not in('기타','쥬스','커피') and
    a.menu_price = 13000 and
    a.orderable_status = 'Y';
    
select
	b.category_code,
    b.category_name,
    a.*
from
	tbl_menu a
join tbl_category b on
	a.category_code = b.category_code and
    b.category_name not in('기타','쥬스','커피') and
    a.menu_price = 13000 and
    a.orderable_status = 'Y';
   