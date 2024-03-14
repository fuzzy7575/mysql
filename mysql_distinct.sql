-- DISTINCT

-- 중복된 값을 제거하는데 사용한다.

select
	distinct category_code
from
	tbl_menu
order by
	category_code;

--  null값을 포함한 열의 distinct사용
select
	distinct category_code
from
	tbl_category
order by
	category_code;

select
    category_code,
    category_name,
--     distinct ref_category_code -- 중간에 하나만 사용 할 수 없음
from
	tbl_category;
    
-- 다중열 distinct 사용  
select distinct
	category_code,
    orderable_status
from
	tbl_menu;