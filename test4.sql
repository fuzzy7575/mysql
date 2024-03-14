/*
### Q1.

다음 논리ERD와 물리ERD를 참고하여, 아래 조건을 만족하는 테이블을 생성하는 DDL 구문을 작성하세요.
*/

CREATE TABLE IF NOT EXISTS TEAM_INFO(
TEAM_CODE INT PRIMARY KEY AUTO_INCREMENT COMMENT '소속코드',
TEAM_NAME VARCHAR(100) NOT NULL COMMENT '소속명',
TEAM_DETAIL VARCHAR(500) COMMENT '소속상세정보',
USE_YN CHAR(2) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
CHECK(USE_YN in('Y', 'N'))
) COMMENT '소속정보';

CREATE TABLE IF NOT EXISTS MEMBER_INFO(
MEMBER_CODE INT PRIMARY KEY AUTO_INCREMENT COMMENT '회원코드',
MEMBER_NAME VARCHAR(70) NOT NULL COMMENT '회원이름',
BIRTH_DATE date COMMENT '생년월일',
DIVISION_CODE CHAR(2) COMMENT '구분코드',
DETAIL_INFO VARCHAR(500) COMMENT '상세정보',
CONTACT VARCHAR(50) NOT NULL COMMENT '연락처',
TEAM_CODE INT NOT NULL COMMENT '소속코드',
ACTIVE_STATUS CHAR(2) NOT NULL DEFAULT 'Y' COMMENT '활동상태',
CHECK(ACTIVE_STATUS in('Y','N','H')),
FOREIGN KEY (`TEAM_CODE`) REFERENCES TEAM_INFO (`TEAM_CODE`)
) COMMENT '회원정보';

/*
### Q2.

Q1에서 생성한 TEAM_INFO 테이블과 MEMBER_INFO 테이블에 아래와 같이 데이터를 INSERT하는 쿼리를 작성하세요.

단, 삽입 대상 컬럼명은 반드시 명시해야 합니다.
*/
INSERT INTO TEAM_INFO (TEAM_CODE,TEAM_NAME,TEAM_DETAIL,USE_YN)
VALUES (NULL,'음악감상부','클래식 및 재즈 음악을 감상하는 사람들의 모임', 'Y'),
(NULL,'맛집탐방부','클래식 및 재즈 음악을 감상하는 사람들의 모임', 'N'),
(NULL,'행복찾기부',NULL, 'Y');

INSERT INTO MEMBER_INFO (MEMBER_CODE,MEMBER_NAME,BIRTH_DATE,DIVISION_CODE,DETAIL_INFO,CONTACT,TEAM_CODE,ACTIVE_STATUS)
VALUES (NULL, '송가인', '1990-01-30', '1', '안녕하세요 송가인입니다~~', '010-9494-9494', 1, 'H'),
 (NULL, '임영웅', '1992-05-03', NULL, '국민아들 임영웅입니다~~', 'hero@trot.com', 1, 'Y'),
 (NULL, '태진아', NULL, NULL, NULL, '(1급 기밀)', 3, 'Y');

TRUNCATE menudb.member_info;
SELECT * FROM menudb.member_info;

/*
### Q3.

단합을 위한 사내 체육대회를 위하여 팀을 꾸리는 중입니다. 
기술지원부의 대리, 인사관리부의 사원, 
영업부(팀명에 ‘영업’이 포함되면 영업부로 봄)의 부장을 한 팀으로 묶으려고 합니다. 
이때, 이 팀의 팀원 수를 출력하세요.
SELECT 
	E.EMP_ID,
    D.DEPT_TITLE,
    J.JOB_NAME
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE 
	(DEPT_TITLE = '기술지원부' AND JOB_NAME = '대리') OR
	(DEPT_TITLE = '인사관리부' AND JOB_NAME = '사원') OR
	(DEPT_TITLE LIKE '%영업%' AND JOB_NAME = '부장');

단, UNION과 SUBQUERY를 활용하여 출력하세요.
*/
   
/*
SELECT 
	E.EMP_ID,
    D.DEPT_TITLE,
    J.JOB_NAME
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE 
	(DEPT_TITLE = '기술지원부' AND JOB_NAME = '대리') OR
	(DEPT_TITLE = '인사관리부' AND JOB_NAME = '사원') OR
	(DEPT_TITLE LIKE '%영업%' AND JOB_NAME = '부장');
*/

SELECT
	COUNT(*)
FROM
	employee
WHERE
	EMP_ID IN (
SELECT 
	E.EMP_ID
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE 
	DEPT_TITLE = '기술지원부' AND JOB_NAME = '대리'
UNION
SELECT 
	E.EMP_ID
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE 
	DEPT_TITLE = '인사관리부' AND JOB_NAME = '사원'
UNION
SELECT 
	E.EMP_ID
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE 
	DEPT_TITLE LIKE '%영업%' AND JOB_NAME = '부장');

/*  
SELECT 
	E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_TITLE,
    J.JOB_NAME
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE 
	DEPT_TITLE = '기술지원부' AND JOB_NAME = '대리'
UNION
SELECT 
	E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_TITLE,
    J.JOB_NAME
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE 
	DEPT_TITLE = '인사관리부' AND JOB_NAME = '사원'
UNION
SELECT 
	E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_TITLE,
    J.JOB_NAME
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE 
	DEPT_TITLE LIKE '%영업%' AND JOB_NAME = '부장';
*/

    
SELECT * FROM employee.employee;
SELECT * FROM employee.department;
SELECT * FROM employee.job;

/*
### Q4.

1. 부서가 영업부가 아니면서(부서명에 ‘영업’이 포함되지 않음) 
직급명이 ‘대리’ 혹은 ‘차장’인 직원의 목록과 
급여가 200만원 이상 300만원 이하인 직원의 목록을 합쳐 출력합니다. 
(이때, 직원의 사원번호, 직원명, 전화번호, 부서명, 직급명, 급여를 출력하도록 하세요.)
EMP_ID, EMP_NAME, PHONE, DEPT_TITLE, JOB_NAME, SALARY
SALARY BETWEEN 2000000 AND 3000000
DEPT_TITLE NOT LIKE '%영업%' AND (JOB_NAME = '대리' OR JOB_NAME = '차장')
DEPT_TITLE NOT LIKE '%영업%' AND JOB_NAME = '대리' 
DEPT_TITLE NOT LIKE '%영업%' AND JOB_NAME = '차장'
- HINT
UNION ALL을 활용하세요.
*/
SELECT 
	E.EMP_ID, 
    E.EMP_NAME, 
    E.PHONE, 
    D.DEPT_TITLE, 
    J.JOB_NAME, 
    E.SALARY
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE
	DEPT_TITLE NOT LIKE '%영업%' AND (JOB_NAME = '대리' OR JOB_NAME = '차장')
UNION ALL
SELECT 
	E.EMP_ID, 
    E.EMP_NAME, 
    E.PHONE, 
    D.DEPT_TITLE, 
    J.JOB_NAME, 
    E.SALARY
FROM
	employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE
	E.SALARY BETWEEN 2000000 AND 3000000;

/*
### Q4.

2. 1에서 출력한 목록에서 직원의 이름과 급여를 기준으로 묶어 
해당 직원이 몇 번 나오는지 카운트합니다. 
(이때, 추출한 목록에는 직원명, 급여, 나온 횟수가 출력되도록 하세요.)
- HINT
SUBQUERY와 GROUP BY를 활용하세요
EMP_NAME, SALARY, COUNT
GROUP BY EMP_NAME, SALARY
 */
SELECT 
	EMP_NAME, 
    SALARY, 
    COUNT(*) AS COUNT
FROM 
	(SELECT 
		E.EMP_ID, 
		E.EMP_NAME, 
		E.PHONE, 
		D.DEPT_TITLE, 
		J.JOB_NAME, 
		E.SALARY
	FROM
		employee E
	JOIN department D ON E.DEPT_CODE = D.DEPT_ID
	JOIN job J ON E.JOB_CODE = J.JOB_CODE
	WHERE
		DEPT_TITLE NOT LIKE '%영업%' AND (JOB_NAME = '대리' OR JOB_NAME = '차장')
	UNION ALL
	SELECT 
		E.EMP_ID, 
		E.EMP_NAME, 
		E.PHONE, 
		D.DEPT_TITLE, 
		J.JOB_NAME, 
		E.SALARY
	FROM
		employee E
	JOIN department D ON E.DEPT_CODE = D.DEPT_ID
	JOIN job J ON E.JOB_CODE = J.JOB_CODE
	WHERE
		E.SALARY BETWEEN 2000000 AND 3000000) AS T
GROUP BY EMP_NAME, SALARY;

/*
### Q4.

3. 2에서 출력한 목록을 목록에 나온 횟수가 많은 순으로 정렬한 뒤에 
급여가 많은 순으로 정렬하여 최상위 3명만 출력되도록 합니다.
ORDER BY COUNT ASC, SALARY DESC
LIMIT 3
*/
SELECT 
	EMP_NAME, 
    SALARY, 
    COUNT(*) AS COUNT
FROM 
	(SELECT 
		E.EMP_ID, 
		E.EMP_NAME, 
		E.PHONE, 
		D.DEPT_TITLE, 
		J.JOB_NAME, 
		E.SALARY
	FROM
		employee E
	JOIN department D ON E.DEPT_CODE = D.DEPT_ID
	JOIN job J ON E.JOB_CODE = J.JOB_CODE
	WHERE
		DEPT_TITLE NOT LIKE '%영업%' AND (JOB_NAME = '대리' OR JOB_NAME = '차장')
	UNION ALL
	SELECT 
		E.EMP_ID, 
		E.EMP_NAME, 
		E.PHONE, 
		D.DEPT_TITLE, 
		J.JOB_NAME, 
		E.SALARY
	FROM
		employee E
	JOIN department D ON E.DEPT_CODE = D.DEPT_ID
	JOIN job J ON E.JOB_CODE = J.JOB_CODE
	WHERE
		E.SALARY BETWEEN 2000000 AND 3000000) AS T
GROUP BY EMP_NAME, SALARY
ORDER BY COUNT ASC, SALARY DESC
LIMIT 3;


SELECT * FROM employee.employee;
SELECT * FROM employee.department;
SELECT * FROM employee.job;
