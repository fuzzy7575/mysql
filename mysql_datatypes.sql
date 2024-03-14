/* DATA TYPES */

-- 명시적 형변환
-- CAST (expression AS 데이터형식[(길이)])
-- CONVERT (expression, 데이터형식[(길이)])
-- 데이터 형식으로 가능한 것은 BINARY, CHAR, DATE, DATETIME, TIME, DECIMAL, JSON
-- SIGNED INTEGER, UNSIGNED INTEGER

select
	avg(menu_price)
from
	tbl_menu;
    
 select
	cast(avg(menu_price) as signed integer) as '평균 메뉴 가격'
    -- signed integer : 음수, 0, 양수를 모두 포함하는 정수값을 저장할 수 있다.
from
	tbl_menu;
    
select
	convert(avg(menu_price), signed integer) as '평균 메뉴 가격'
from
	tbl_menu;
    
select cast('2024$2$23' as date);
select cast('2024/2/23' as date);
select cast('2024%2%23' as date);
select cast('2024@2@23' as date);

select
	concat(cast(menu_price as char(3)), '원')	-- char(3) 길이 3만큼 앞에서 부터 출력
from
	tbl_menu;
select
	concat(cast(menu_price as char(5)), '원')
from
	tbl_menu;    

select
	category_code,
    concat(cast(sum(menu_price) as char(10)), '원')
from
	tbl_menu
group by
	category_code;
    
-- 암시적 형변환
select '1' + '2';	-- 각 문자가 정수로 변환됨
select concat(menu_price, '원') from tbl_menu; -- menu_price가 문자로 변환됨
select 3 > 'MAY'; -- 문자는 0으로 변환된다.
select 5 > '6MAY'; -- 문자에서 첫번째로 나온 숫자는 정수로 변환된다.
select 5 > 'M6AY'; -- 문자에서 숫자가 뒤에 나오면 문자로 인식되어 0으로 변환된다.
select '2024-2-23'; -- 날짜형으로 바뀔 수 있는 문자는 date형으로 변환된다.

