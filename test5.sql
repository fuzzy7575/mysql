/*
### Q1.

전화번호가 010으로 시작하는 직원의 직원명과 전화번호를 다음과 같이 출력하세요.
PHONE LIKE '010________'
PHONE LIKE '%010%'
EMP_NAME, PHONE
CONCAT_WS('-', SUBSTRING(PHONE, 1,3), SUBSTRING(PHONE, 4,4), SUBSTRING(PHONE, 8,4)) AS PHONE
- 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘PHONE’이어야 함
- 전화번호는 ‘010-0000-0000’ 형식으로 출력해야 함
*/
SELECT
	EMP_NAME, 
    CONCAT_WS('-', SUBSTRING(PHONE, 1,3), SUBSTRING(PHONE, 4,4), SUBSTRING(PHONE, 8,4)) AS PHONE
FROM
	employee
WHERE
	PHONE LIKE '010________';

/*
### Q2.

근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
EMP_NAME as 직원명, HIRE_DATE as 입사일, SALARY as 급여
CONCAT(SUBSTRING(HIRE_DATE,1,4), '년', SUBSTRING(HIRE_DATE,6,2), '월', SUBSTRING(HIRE_DATE,9,2), '일') AS 입사일,
<<<<<<< HEAD
CONCAT(YEAR(HIRE_DATE), '년', MONTH(HIRE_DATE), '월', DAY(HIRE_DATE), '일') AS 입사일,
FORMAT(SALARY, 0) as 급여
DATE_ADD(CURDATE(),INTERVAL -20 YEAR)
SUBDATE(CURDATE(),INTERVAL 20 YEAR)
=======
CONCAT(YEAR(HIRE_DATE), '년', MONTH(HIRE_DATE), '월', DAY(HIRE_DATE), '일') AS 입사일
FORMAT(SALARY, 0) as 급여
HIRE_DATE <= DATE_ADD(CURDATE(),INTERVAL -20 YEAR)
HIRE_DATE <= SUBDATE(CURDATE(),INTERVAL 20 YEAR)
>>>>>>> e851ac1e895bbc390ac2e97a557767a69aefa529
단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.
- 출력한 결과집합 헤더의 명칭은 각각 ‘직원명’, ‘입사일’, ‘급여’여야 함
- 입사일은 ‘0000년 00월 00일’ 형식으로 출력해야 함
- 급여는 천 단위로 , 를 찍어 출력해야 함
*/

SELECT 
	EMP_NAME AS 직원명,
    -- DATE_FORMAT(HIRE_DATE, '%Y년 %m월 %d일' ) AS 입사일,
    -- CONCAT(SUBSTRING(HIRE_DATE,1,4), '년', SUBSTRING(HIRE_DATE,6,2), '월', SUBSTRING(HIRE_DATE,9,2), '일') AS 입사일,
    CONCAT(YEAR(HIRE_DATE), '년', MONTH(HIRE_DATE), '월', DAY(HIRE_DATE), '일') AS 입사일,
    FORMAT(SALARY, 0) as 급여
FROM 
	employee
WHERE
	-- HIRE_DATE <= '2004-02-29'
    -- HIRE_DATE <= DATE_ADD(CURDATE(),INTERVAL -20 YEAR)
    HIRE_DATE <= SUBDATE(CURDATE(),INTERVAL 20 YEAR)
ORDER BY HIRE_DATE ASC, SALARY DESC;

/*
### Q3.

모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요.
- 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘SALARY’, ‘BONUS’, ‘TOTAL_SALARY’여야 함
- 보너스를 더한 급여는 소수점이 발생할 경우 반올림 처리함
- 급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
- 보너스는 백분율로 출력해야 함
*/

SELECT
	EMP_NAME,
    FORMAT(SALARY, 0) AS SALAY,
    CONCAT(TRUNCATE((BONUS * 100), 0), '%') AS BONUS,
    FORMAT(SALARY + (SALARY * IFNULL(BONUS,0)), 0) AS TOTAL_SALAY
FROM 
	employee
ORDER BY ROUND(SALARY + (SALARY * IFNULL(BONUS,0))) DESC;

/*
### Q4.

직원의 직원명과 이메일을 다음과 같이 출력하세요.
- 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘EMAIL’이어야 함
- 이메일의 도메인 주소인 greedy.com 은 모두 동일하므로, 해당 문자열이 맞춰질 수 있도록 이메일의 앞에 공백을 두고 출력해야 함
EMP_NAME, EMAIL
LPAD
SELECT MAX(CHAR_LENGTH(EMAIL)) FROM employee
*/
SELECT
	EMP_NAME,
	LPAD(EMAIL, (SELECT MAX(CHAR_LENGTH(EMAIL)) FROM employee), ' ') AS EMAIL
FROM 
	employee;

/*
+@ (심화)
    
<<<<<<< HEAD
SELECT * FROM employee.employee;
SELECT 
	EMP_NAME AS 직원명,    
    -- CONCAT(SUBSTRING(HIRE_DATE,1,4), '년', SUBSTRING(HIRE_DATE,6,2), '월', SUBSTRING(HIRE_DATE,9,2), '일') AS 입사일,
    CONCAT(YEAR(HIRE_DATE), '년', MONTH(HIRE_DATE), '월', DAY(HIRE_DATE), '일') AS 입사일,
    FORMAT(SALARY, 0) as 급여
FROM 
	employee
WHERE
	-- HIRE_DATE <= '2004-02-29'
    -- HIRE_DATE <= DATE_ADD(CURDATE(),INTERVAL -20 YEAR)
    HIRE_DATE <= SUBDATE(CURDATE(),INTERVAL 20 YEAR)
ORDER BY HIRE_DATE ASC, SALARY DESC;
=======
이메일의 도메인 주소가 모두 다르다고 가정할 때, 
@의 위치를 한 줄로 맞추고 싶은 경우에는 어떻게 수정할 수 있을까?
SPACE
(SELECT MAX(INSTR(EMAIL, '@')) FROM employee) - INSTR(EMAIL, '@')
*/  
SELECT
	EMP_NAME,
	CONCAT(SPACE((SELECT MAX(INSTR(EMAIL, '@')) FROM employee) - INSTR(EMAIL, '@')), EMAIL) AS EMAIL
FROM 
	employee;

/*
### Q5.

사내 행사 준비를 위해 직원 목록을 출력하려고 합니다. 직원 목록을 다음과 같이 출력하세요.
단, 관리자의 이름순으로 정렬하여 출력되도록 하세요.
- 직원명, 직급명, 주민등록번호, 부서가 있는 국가, 부서명, 해당 직원의 관리자 직원명을 출력해야 함
- 출력한 결과집합 헤더의 명칭은 각각 ‘NAME_TAG’, ‘EMP_NO’, ‘BELONG’, ‘MANAGER_NAME’이어야 하며 출력 형식은 각각 아래와 같아야 함
    - NAME_TAG : (직원명) (직급명)님
    - EMP_NO : (생년월일6자리)-(뒷자리 한 자리를 제외하고는 *로 표시)
    - BELONG : (부서의 국가)지사 (부서명) 소속

(직원명) (직급명)님
CONCAT ((EMP_NAME) (JOB_NAME)님)

(생년월일6자리)-(뒷자리 한 자리를 제외하고는 *로 표시)
INSERT(기준 문자열, 위치, 길이, 삽입할 문자열)
INSERT(EMP_NO, 9, 6, '******')
RIGHT(문자열, 길이)
REPLACE(문자열, 찾을 문자열, 바꿀 문자열)
REPLACE(EMP_NO, RIGHT(EMP_NO, 6), '******')

(부서의 국가)지사 (부서명) 소속
CONCAT((NATIONAL_NAME)지사 (DEPT_TITLE) 소속)

*/
SELECT
	CONCAT(E.EMP_NAME, ' ', J.JOB_NAME, '님') AS NAME_TAG,
-- 	INSERT(E.EMP_NO, 9, 6, '******') AS EMP_NO,
-- 	REPLACE(E.EMP_NO, RIGHT(E.EMP_NO, 6), '******') AS EMP_NO,
	RPAD(SUBSTRING(EMP_NO,1,8), 14, '*') AS EMP_NO,
    CONCAT(N.NATIONAL_NAME,'지사 ', D.DEPT_TITLE, ' 소속') AS BELONG,
	E.MANAGER_NAME AS MANAGER_NAME
FROM 
	(SELECT
		A.EMP_NAME,
        A.EMP_NO,
        A.JOB_CODE,
        A.DEPT_CODE,
		B.EMP_NAME AS MANAGER_NAME
	FROM
		employee A
	LEFT JOIN employee B ON A.MANAGER_ID = B.EMP_ID) AS E
LEFT JOIN job J ON E.JOB_CODE = J.JOB_CODE
LEFT JOIN department D ON E.DEPT_CODE = D.DEPT_ID
LEFT JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE
LEFT JOIN nation N ON L.NATIONAL_CODE = N.NATIONAL_CODE
WHERE E.DEPT_CODE IS NOT NULL
ORDER BY E.MANAGER_NAME ASC, E.JOB_CODE ASC;

SELECT * FROM employee;
SELECT * FROM job;
SELECT * FROM location;
SELECT * FROM nation;
SELECT * FROM department;
describe employee;
/*
SELECT
	CONCAT(DN.NATIONAL_NAME,'지사 ', DN.DEPT_TITLE, ' 소속') AS BELONG
FROM
	(SELECT 
		D.DEPT_TITLE,
        N.NATIONAL_NAME
    FROM department D  
	LEFT JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE
	LEFT JOIN nation N ON L.NATIONAL_CODE = N.NATIONAL_CODE
    ) AS DN;
*/
/*
SELECT
	E.EMP_NAME AS NAME_TAG,
	E.MANAGER_NAME AS MANAGER_NAME
FROM 
	(SELECT
		A.EMP_NAME, 
		B.EMP_NAME AS MANAGER_NAME
	FROM
		employee A
	LEFT JOIN employee B ON A.MANAGER_ID = B.EMP_ID) AS E
ORDER BY E.MANAGER_NAME;
*/
/*
SELECT
	A.EMP_NAME, 
    B.EMP_NAME AS MANAGER_NAME
FROM
	employee A
LEFT JOIN employee B ON A.MANAGER_ID = B.EMP_ID;
*/
