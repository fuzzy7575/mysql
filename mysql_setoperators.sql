/* SET OPERATORS */

-- UNION : 두개 이상의 select 문의 결과를 결합하여 중복된 레코드를 제거 후 반환.

select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	category_code = 10
union    
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price < 9000;
    
-- UNION ALL : 중복된 레코드를 제거하지 않고 모두 반환

select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	category_code = 10
union all
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price < 9000;
    
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	category_code = 10
union all
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price < 9000
order by menu_code;  -- order by 절은 뒤쪽 select 문에서
    
-- INTERSECT : 두 select문의 결과 중 공통되는 레코드만을 반환.
-- MySQL은 재공하지 않는다. 하지만 inner join 또는 in 연산자를 활용해서 구현가능.

-- inner join 사용
select
	a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
from
	tbl_menu a
inner join (select
				menu_code,
                menu_name,
                menu_price,
                category_code,
                orderable_status
			from
				tbl_menu
			where
				menu_price < 9000) b on (a.menu_code = b.menu_code)
where
	a.category_code = 10;
    
-- in 사용
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	category_code = 10 and
    menu_code in (select 
					menu_code
				  from
					tbl_menu
				  where
					menu_price < 9000);
                    
-- MINUS : 첫번째 select 문의 결과에서 
-- 		   두번째 select문의 결과가 포함하는 레코드를 제외하고 반환.
-- MySQL은 MINUS를 재공하지 않음. left join을 활용해서 구현하는 것은 가능하다.

select
	a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
from
	tbl_menu a
left join (select
				menu_code,
                menu_name,
                menu_price,
                category_code,
                orderable_status
			from
				tbl_menu b
			where
				menu_price < 9000) b on (a.menu_code = b.menu_code)
where
	a.category_code = 10 and
    b.menu_code is null;
					                   
-- 위 sql문 확인용
select
	a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status,
    b.menu_name,
    b.menu_price
from
	tbl_menu a                
left join (select
				menu_code,
                menu_name,
                menu_price,
                category_code,
                orderable_status
			from
				tbl_menu b
			where
				menu_price < 9000) b on (a.menu_code = b.menu_code)
where
	a.category_code = 10;
    