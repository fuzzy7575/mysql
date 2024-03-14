/* VIEW */
-- SELECT 쿼리문을 저장한 객체로 가상테이블이라고 불린다.
-- 데이터를 쉽게 읽고 이해할 수 있도록 돕는 동시에,
-- 원본 데이터의 보안을 유지하는데 도움이 된다.

create view hansik as
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
    tbl_menu
where
	category_code = 4;
    
select * from hansik;

insert into tbl_menu 
values (null, '식혜맛국밥', 5500, 4, 'Y');

insert into hansik 
values (null, '식혜맛국밥', 5500, 4, 'Y');
-- 베이스테이블의 auto_increment가 적용되어 null값을 넣어도 자동으로 increment된다.

insert into hansik 
values (99, '식혜맛국밥', 5500, 4, 'Y');

describe tbl_menu;
describe hansik;

update hansik
set
	menu_name = '버터맛국밥',
    menu_price = 5700
where
	menu_code = 99;

delete from hansik
where menu_code = 99;

/* 
VIEW로 DML 명령어 조작이 불가능한 경우
-- 사용된 서브쿼리에 따라 DML 명령어로 조작이 불가능할 수 있다. 
1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
3. 산술 표현식이 정의된 경우
4. JOIN을 이용해 여러 테이블을 연결한 경우
5. DISTINCT를 포함한 경우
6.그룹함수나 GROUP BY절을 포함한 경우
*/

drop view hansik;

-- OR REPLACE 옵션
-- 테이블을 드롭하지 않고 기존의 VIEW를 새로운 VIEW로 쉽게 다룰 수 있다.
create or replace view hansik as
select
	menu_code as '메뉴코드',
    menu_name as '메뉴명',
    category_name as '카테고리명'
from
	tbl_menu a
join tbl_category b on a.category_code = b.category_code
where b.category_name = '한식';
  
select * from hansik;
select * from tbl_menu;
