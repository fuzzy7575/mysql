/* BUILD_IN_FUNTIONS */

-- 1. 문자열 관련 함수
-- ASCII : 아스키 코드값 추출
-- CHAR : 아스키 코드로 문자 추출

select ascii('A'), char(65);

-- BIT_LENGTH : 할당된 비트(BIT) 크기 반환
-- CHAR_LENGTH : 문자열의 길이 반환
-- LENGTH : 할당된 바이트(BYTE) 크기 반환

select bit_length('pie'), char_length('pie'), length('pie');
select 
	menu_name,
    bit_length(menu_name),
    char_length(menu_name),
    length(menu_name)
from
	tbl_menu;
    
-- CONCAT : 문자열을 이어붙임
-- CONCAT_WS : 구분자와 함께 문자열을 이어붙임
-- CONCAT_WS(구분자, 문자열1, 문자열2)
select concat('호랑이', '기린', '판다');
select concat_ws('-', '2024', '2', '23');

-- ELT : 해당 위치의 문자열 반환
-- ELT(위치, 문자열1, 문자열2, ...)

-- FIELD : 찾을 문자열 위치 반환
-- FIELD (찾을 문자열, 문자열1, 문자열2, ...)

-- FIND_IN_SET : 



