/* SUB QUERIES */

select 
	category_code
from 
	tbl_menu
where 
	menu_name = '민트미역국';
    
select
	menu_code,
	menu_name,
	menu_price,
	category_code,
	orderable_status
from
	tbl_menu;

select
	menu_code,
	menu_name,
	menu_price,
	category_code,
	orderable_status
from
	tbl_menu
where
	category_code = (select 
						category_code
					from 
						tbl_menu
					where 
						menu_name = '민트미역국');
                        
select
	count(*) as 'count'
from
	tbl_menu
group by
	category_code;
    
select
	max(count)
from
	(select
		count(*) as 'count'
	from
		tbl_menu
	group by
		category_code) as countmenu;
-- from 절에 서브쿼리 사용 시 반드시 별칭이 있어야 한다.

select
	avg(menu_price)
from
	tbl_menu
where
	category_code = 4;

/* 카테고리별 평균 가격보다 높은 가격의 메뉴 조회 */
select
	menu_code,
	menu_name,
	menu_price,
    category_code,
    orderable_status
from
	tbl_menu a
where
	menu_price > (	select
						avg(menu_price)
					from
						tbl_menu
					where
						category_code = a.category_code);
                        
/* EXISTS */
-- 조회 결과가 있을 때 true 아니면 false

/* 메뉴가 있는 카테고리 조회 */
select
	category_name
from
	tbl_category a
where
	exists(select
				1
			from
				tbl_menu b
			where
				b.category_code = a.category_code)
order by 1;

/* CTE(Common Table Expressions) */
-- 파생 테이블과 비슷한 개념이며 코드의 가독성과 재사용성을 위해 파생 테이블 대신 사용하게된다.
-- from절에서만 사용됨(join일 시 join 구문에서도 가능)
with menucate as (select
						menu_name,
						category_name
					from
						tbl_menu a
					join
						tbl_category b on a.category_code = b.category_code)
select
	*
from
	menucate
order by
	menu_name;
                    