/*
Q1.
재직 중이고 휴대폰 마지막 자리가 2인 직원 중 
입사일이 가장 최근인 직원 3명의 
사원번호, 직원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
EMP_ID, EMP_NAME, PHONE, HIRE_DATE, ENT_YN

- 참고. 퇴사한 직원은 퇴직여부 컬럼값이 ‘Y’이고, 재직 중인 직원의 퇴직여부 컬럼값은 ‘N’
*/
SELECT 
	EMP_ID, 
	EMP_NAME, 
	PHONE, 
	HIRE_DATE, 
	ENT_YN 
FROM 
	employee
WHERE
	ENT_YN = 'N' AND
    PHONE LIKE '__________2'
ORDER BY HIRE_DATE DESC
LIMIT 3;

/*
Q2.
재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
A.EMP_NAME, B.JOB_NAME, A.SALARY, A.EMP_ID, A.EMAIL, A.PHONE, A.HIRE_DATE

단, 급여를 기준으로 내림차순 출력하세요.
*/   
 SELECT
	A.EMP_NAME, 
	B.JOB_NAME, 
	A.SALARY, 
	A.EMP_ID, 
	A.EMAIL, 
	A.PHONE, 
	A.HIRE_DATE
FROM
	employee A
JOIN job B ON A.JOB_CODE = B.JOB_CODE
where 
	A.ENT_YN = 'N' AND 
    B.JOB_NAME = '대리'
ORDER BY
	A.SALARY DESC;
 
/*
Q3.
재직 중인 직원들을 대상으로 
부서별 인원, 급여 합계, 급여 평균을 출력하고, 
마지막에는 전체 인원과 전체 직원의 급여 합계 및 평균이 출력되도록 하세요.
COUNT(EMP_NAME), SUM(SALARY), AVG(SALARY)
단, 출력되는 데이터의 헤더는 컬럼명이 아닌 
‘부서명’, ‘인원’, ‘급여합계’, ‘급여평균’으로 출력되도록 하세요.
B.DEPT_TITLE AS '부서명', 
COUNT(*) AS ‘인원’, 
SUM(SALARY) AS ‘급여합계’, 
AVG(SALARY) AS ‘급여평균’
*/

SELECT
	B.DEPT_TITLE AS 부서명,
    COUNT(*) AS 인원, 
	SUM(SALARY) AS 급여합계, 
	AVG(SALARY) AS 급여평균
FROM employee A
JOIN department B ON A.DEPT_CODE = B.DEPT_ID
WHERE 
	A.ENT_YN = 'N'
GROUP BY
    B.DEPT_TITLE
WITH ROLLUP;

/*
Q4.

전체 직원의 직원명, 주민등록번호, 전화번호, 부서명, 직급명을 출력하세요.
A.EMP_NAME, A.EMP_NO, A.PHONE, B.DEPT_TITLE, C.JOB_NAME
단, 입사일을 기준으로 오름차순 정렬되도록 출력하세요.
*/
SELECT
	A.EMP_NAME, 
    A.EMP_NO, 
    A.PHONE, 
    B.DEPT_TITLE, 
    C.JOB_NAME
FROM
	employee A
JOIN department B ON A.DEPT_CODE = B.DEPT_ID
JOIN job C ON A.JOB_CODE = C.JOB_CODE
ORDER BY
	A.HIRE_DATE ASC;

/*
Q5.
<1단계> 전체 직원 중 연결된 관리자가 있는 직원의 인원을 출력하세요.
COUNT(*)
참고. 연결된 관리자가 있다는 것은 관리자사번이 NULL이 아님을 의미함
WHERE MANAGER_ID IS NOT NULL
*/
SELECT
	count(*)
FROM
	employee
WHERE
	MANAGER_ID IS NOT NULL;

/*
<2단계> 1단계에서 조회한 내용에는 문제가 조금 있습니다.
관리자사번이 존재하여 연결된 관리자가 있기는 하나, 
해당 관리자가 직원 목록에 존재하지 않는 직원이 있습니다.

따라서 1단계를 디벨롭하여 직원 목록에 관리자사번이 존재하는 직원의 인원을 출력하세요.
*/
SELECT
	count(*)
FROM
	employee    
WHERE
	MANAGER_ID IN (SELECT 
				EMP_ID
			 FROM
				employee) AND
	MANAGER_ID IS NOT NULL;
/*
SELECT
	*
FROM
	employee    
WHERE
	MANAGER_ID IN (SELECT 
				EMP_ID
			 FROM
				employee) AND
	MANAGER_ID IS NOT NULL;
*/

/*
<3단계> 모든 직원의 직원명과 관리자의 직원명을 출력하세요.
A.EMP_NAME, B.EMP_NAME
참고. ‘모든 직원’이므로 관리자가 존재하지 않는 직원도 출력되어야 합니다.
*/

SELECT
	A.EMP_NAME, 
    B.EMP_NAME
FROM
	employee A
LEFT JOIN employee B ON A.MANAGER_ID = B.EMP_ID
ORDER BY A.EMP_NAME;

/*
SELECT
	A.EMP_NAME, 
    A.EMP_ID,
    B.EMP_NAME,
    B.EMP_ID
FROM
	employee A
LEFT JOIN employee B ON A.MANAGER_ID = B.EMP_ID;
*/

/*
<4단계> 관리자가 존재하는 직원의 
직원명, 부서명, 관리자의 직원명, 관리자의 부서명을 출력하세요.
A.EMP_NAME, 
C.DEPT_TITLE,
B.EMP_NAME,
D.DEPT_TITLE
*/   
SELECT
	A.EMP_NAME, 
    C.DEPT_TITLE,
    B.EMP_NAME,
    D.DEPT_TITLE
FROM
	employee A
LEFT JOIN employee B ON A.MANAGER_ID = B.EMP_ID
LEFT JOIN department C ON A.DEPT_CODE = C.DEPT_ID
LEFT JOIN department D ON B.DEPT_CODE = D.DEPT_ID
WHERE
	A.MANAGER_ID IS NOT NULL
ORDER BY A.EMP_NAME;
