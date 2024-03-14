-- GROOPING
-- GROUP BY 절은 특정 열의 값에 따라 그룹화하는데 사용된다.
-- HAVING 은 GROUP BY 절과 함께 사용해야 하며 그룹에 대한 조건을 적용하는데 사용
select 
	category_code
from
	tbl_menu
group by
	category_code;

select 
	category_code,
    count(*)
from
	tbl_menu
group by
	category_code;

select 
	category_code,
    sum(menu_price)	-- 합계
from
	tbl_menu
group by
	category_code;
    
select 
	category_code,
    avg(menu_price)
from
	tbl_menu
group by
	category_code;
    
select 
	category_code,
    avg(menu_price), -- 평균 (실수형 반환)
    convert(avg(menu_price), signed integer) as 'int' -- 평균 (정수형 형변환)
from
	tbl_menu
group by
	category_code;
    
select 
	menu_price,
    category_code
from
	tbl_menu
group by
	menu_price,
    category_code;
-- HAVING    
select 
	menu_price,
    category_code
from
	tbl_menu
group by
	menu_price,
    category_code
having 
	category_code >= 5 and category_code <= 8;
-- where 절은 그룹화 전의 개별 행에 대한 조건 지정
-- having 절은 그룹화 후의 집계 결과에 대한 조건 지정

-- ROLL UP
select 
	category_code,
    sum(menu_price)
from
	tbl_menu
group by
    category_code;

select 
	category_code,
    sum(menu_price)
from
	tbl_menu
group by
    category_code
with rollup;	-- 전체 합계를 표시

select 
	menu_price,
    category_code,
    sum(menu_price)
from
	tbl_menu
group by
    menu_price,
    category_code
with rollup;	-- 카테고리별 합계, 전체 합계를 표시 -- 2개 필드를 그룹화 하여 rollup
				