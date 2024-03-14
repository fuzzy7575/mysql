/*
Q1.
부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.
SALARY
*/

/* CASE1 - LIMIT 사용 */
SELECT
	SUM(SALARY) AS SUM
FROM employee
GROUP BY
    DEPT_CODE
ORDER BY SUM DESC
LIMIT 1;

/* CASE2 - 서브쿼리와 MAX 사용 */
SELECT
	MAX(SUM)
FROM (SELECT
		SUM(SALARY) AS SUM
	  FROM 
		employee
	  GROUP BY
		DEPT_CODE) AS SUMSALARY;


/*
Q2.
서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
EMP_ID, EMP_NAME, DEPT_CODE, SALARY
참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임
*/

/* CASE1 - IN 사용 */
SELECT
	EMP_ID, 
    EMP_NAME, 
    DEPT_CODE, 
    SALARY
FROM employee
WHERE 
	DEPT_CODE IN (SELECT
					DEPT_ID
				 FROM
					department
				 WHERE
                    DEPT_TITLE IN ('국내영업부', '해외영업1부', '해외영업2부', '해외영업3부'));

/* CASE2 - LIKE 사용 */                    
SELECT
	EMP_ID, 
    EMP_NAME, 
    DEPT_CODE, 
    SALARY
FROM employee
WHERE 
	DEPT_CODE IN (SELECT
					DEPT_ID
				 FROM
					department
				 WHERE
                    DEPT_TITLE LIKE '%영업%');

/*    
SELECT
					DEPT_ID
				 FROM
					department
				 WHERE
					-- DEPT_CODE IN ('D4', 'D5', 'D6', 'D7'));
                    DEPT_TITLE IN ('국내영업부', '해외영업1부', '해외영업2부', '해외영업3부');
*/


/*
Q3.
서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.
EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
*/
SELECT
	A.EMP_ID, 
    A.EMP_NAME, 
    B.DEPT_TITLE, 
    A.SALARY
FROM employee A
JOIN department B ON A.DEPT_CODE = B.DEPT_ID
WHERE 
	DEPT_CODE IN (SELECT
					DEPT_ID
				 FROM
					department
				 WHERE
                    DEPT_TITLE LIKE '%영업%');


/*
Q4.
1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 
국가명을 추출하는 쿼리를 작성하세요.
B.DEPT_ID, B.DEPT_TITLE, C.LOCAL_NAME, D.NATIONAL_NAME
department B
LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE
2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서명, 
(부서의) 국가명을 출력하세요.
A.EMP_ID, A.EMP_NAME, A.SALARY, B.DEPT_TITLE, C.NATIONAL_NAME

단, 국가명 내림차순으로 출력되도록 하세요.
*/
/* 1 */
SELECT
	B.DEPT_ID, 
    B.DEPT_TITLE, 
    C.LOCAL_NAME, 
    D.NATIONAL_NAME
FROM
	department B
LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE
ORDER BY D.NATIONAL_NAME DESC;
/* 2 */  
SELECT
	A.EMP_ID, 
    A.EMP_NAME, 
    A.SALARY, 
    T.DEPT_TITLE, 
    T.NATIONAL_NAME
FROM
	employee A
LEFT JOIN (SELECT
		B.DEPT_ID, 
		B.DEPT_TITLE, 
		C.LOCAL_NAME, 
		D.NATIONAL_NAME
	  FROM
		department B
	  LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
	  LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE
      ORDER BY D.NATIONAL_NAME DESC) AS T
ON A.DEPT_CODE = T.DEPT_ID
ORDER BY T.NATIONAL_NAME DESC;
/*
SELECT
	A.EMP_ID, 
    A.EMP_NAME, 
    A.SALARY, 
    T.DEPT_TITLE, 
    T.NATIONAL_NAME
FROM
	employee A
LEFT JOIN (SELECT
		B.DEPT_ID, 
		B.DEPT_TITLE, 
		C.LOCAL_NAME, 
		D.NATIONAL_NAME
	  FROM
		department B
	  LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
	  LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE) AS T
ON A.DEPT_CODE = T.DEPT_ID
ORDER BY T.NATIONAL_NAME DESC;
*/    
/*
SELECT
	B.DEPT_ID, 
    B.DEPT_TITLE, 
    C.LOCAL_NAME, 
    D.NATIONAL_NAME
FROM
	department B
LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE;
*/


/*
러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합니다. 
위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로 정했습니다.
sal_grade
SAL_LEVEL
SALARY + MIN_SAL
Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로, 
직원의 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, NATIONAL_NAME, 위로금
단, 위로금의 결과 집합 헤더는 ‘위로금’으로 출력되도록 하고, 위로금 내림차순으로 출력되도록 하세요.
ORDER BY 위로금 DESC
*/
/* CASE1 - 4번의 서브쿼리를 LEFT JOIN 하고  
메인쿼리 WHERE 절에서 러시아만 출력 */
SELECT
	A.EMP_ID, 
    A.EMP_NAME, 
    A.SALARY, 
    T.DEPT_TITLE, 
    T.NATIONAL_NAME,
    (A.SALARY + E.MIN_SAL) AS 위로금
FROM
	employee A
LEFT JOIN
	sal_grade E ON A.SAL_LEVEL = E.SAL_LEVEL
LEFT JOIN
	(SELECT
		B.DEPT_ID, 
		B.DEPT_TITLE, 
		C.LOCAL_NAME, 
		D.NATIONAL_NAME
	  FROM
		department B
	  LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
	  LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE) AS T
ON A.DEPT_CODE = T.DEPT_ID
WHERE
	T.NATIONAL_NAME = '러시아'
ORDER BY 위로금 DESC;

/* CASE2 - 4번의 서브쿼리에 WHERE 절을 추가하고 러시아만 출력하여
메인쿼리에서 LEFT JOIN과 IS NOT NULL로 제거 (MINUS) */
SELECT
	A.EMP_ID, 
    A.EMP_NAME, 
    A.SALARY, 
    T.DEPT_TITLE, 
    T.NATIONAL_NAME,
    (A.SALARY + E.MIN_SAL) AS 위로금
FROM
	employee A
LEFT JOIN
	sal_grade E ON A.SAL_LEVEL = E.SAL_LEVEL
LEFT JOIN
	(SELECT
		B.DEPT_ID, 
		B.DEPT_TITLE, 
		C.LOCAL_NAME, 
		D.NATIONAL_NAME
	  FROM
		department B
	  LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
	  LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE
      WHERE D.NATIONAL_NAME = '러시아') AS T
ON A.DEPT_CODE = T.DEPT_ID
WHERE
	T.NATIONAL_NAME IS NOT NULL
ORDER BY 위로금 DESC;

SELECT
	A.EMP_ID, 
    A.EMP_NAME, 
    A.SALARY,
    T.DEPT_TITLE, 
    T.NATIONAL_NAME,
    (A.SALARY + E.MIN_SAL) AS 위로금
FROM
	employee A
LEFT JOIN
	sal_grade E ON A.SAL_LEVEL = E.SAL_LEVEL
LEFT JOIN
	(SELECT
		B.DEPT_ID, 
		B.DEPT_TITLE, 
		C.LOCAL_NAME, 
		D.NATIONAL_NAME
	  FROM
		department B
	  LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
	  LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE
      WHERE D.NATIONAL_NAME = '러시아') AS T
ON A.DEPT_CODE = T.DEPT_ID
WHERE
	A.DEPT_CODE = T.DEPT_ID
ORDER BY 위로금 DESC;

/*
	  SELECT
		B.DEPT_ID, 
		B.DEPT_TITLE, 
		C.LOCAL_NAME, 
		D.NATIONAL_NAME
	  FROM
		department B
	  LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
	  LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE
      WHERE D.NATIONAL_NAME = '러시아';
*/
/*
SELECT
	A.EMP_ID, 
    A.EMP_NAME, 
    A.SALARY, 
--     T.DEPT_TITLE, 
--     T.NATIONAL_NAME 
    (A.SALARY + E.MIN_SAL) AS 위로금
FROM
	employee A
LEFT JOIN
	sal_grade E ON A.SAL_LEVEL = E.SAL_LEVEL;
*/
/*
SELECT
	A.EMP_ID, 
    A.EMP_NAME, 
    A.SALARY, 
    T.DEPT_TITLE, 
    T.NATIONAL_NAME,
    (A.SALARY + E.MIN_SAL) AS 위로금
FROM
	employee A
LEFT JOIN
	sal_grade E ON A.SAL_LEVEL = E.SAL_LEVEL
LEFT JOIN
	(SELECT
		B.DEPT_ID, 
		B.DEPT_TITLE, 
		C.LOCAL_NAME, 
		D.NATIONAL_NAME
	  FROM
		department B
	  LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
	  LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE
      WHERE D.NATIONAL_NAME = '러시아') AS T
ON A.DEPT_CODE = T.DEPT_ID;
*/
/*
SELECT
	A.EMP_ID, 
    A.EMP_NAME, 
    A.SALARY, 
    T.DEPT_TITLE, 
    T.NATIONAL_NAME,
    (A.SALARY + E.MIN_SAL) AS 위로금
FROM
	employee A
LEFT JOIN
	sal_grade E ON A.SAL_LEVEL = E.SAL_LEVEL
LEFT JOIN
	(SELECT
		B.DEPT_ID, 
		B.DEPT_TITLE, 
		C.LOCAL_NAME, 
		D.NATIONAL_NAME
	  FROM
		department B
	  LEFT JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
	  LEFT JOIN nation D ON C.NATIONAL_CODE = D.NATIONAL_CODE) AS T
ON A.DEPT_CODE = T.DEPT_ID;
*/

