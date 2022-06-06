-- [�������� (subquery)] 

/* : SQL�� �ȿ� SQL��
 * 
 * -- ��������
 * -- : ���������� �̿��ؼ� ��� ���� ����
 * SELECT �� �̸�
 * FROM ���̺� �̸�
 * WHERE ���ǽ� (SELECT �� �̸�
 * 				FROM ���̺� �̸�
 * 				WHERE ���ǽ�) -- ��������
 * 
 * 
 */

-- [������ ��������]
-- : single-row subquery
-- : ���� ����� �ϳ��� ������ ������ ��������
-- : ������: �񱳿�����

-- EX) ��� �̸��� 'JONES'�� ������� �޿��� ���� ��� ��ȸ
-- 1) ��� �̸��� 'JONES'�� ����� �޿�
SELECT SAL
FROM EMP
WHERE ENAME = 'JONES';

-- 2) 2975 �޷����� �޿��� ���� ��� ��ȸ
SELECT *
FROM EMP
WHERE SAL > 2975;

/* �ڵ忡 ������� �� ���� ��� ���� !!
 * 1) JONES�� �޿� ���� => �ڵ� ������ ������ => ���������� ����
 * 2) ���������� ����� �� ���� (1) + 2))
 *  SELECT *
	FROM EMP
	WHERE SAL > 2975;
 * */

-- => �ϳ��� ���������� ��ĥ �� ����!
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL
		FROM EMP
		WHERE ENAME = 'JONES');

/* Ư¡
 * A. ���������� ()�� ���� �ۼ�
 * B. �������� �� �̸��� ���������� �� ���� ���� �ڷ���/������ ����
 * C. �������������� ORDER BY ��� �Ұ�
 * */

-- Q1. ��� �̸��� ALLEN ����� �߰� ���纸�� 
-- ���� �߰� ������ �޴� ��� ������ ��� (SELECT *)
SELECT *
FROM EMP
WHERE COMM > (SELECT COMM
		FROM EMP
		WHERE ENAME = 'ALLEN');
		
/* ������
 * 1) 'ALLEN' ���� ���� 
 * => ������ �������� (multiple-row subquery) ���
 * �� ������ �������� (single-row subquery)
 * 
 * 2) COMM�� NULL�� ���� ����
 * 
 * */

SELECT * FROM EMP;

-- Q2. ��� �̸��� SMITH ����� �߰� ���纸�� 
-- ���� �߰� ������ �޴� ��� ������ ��� (SELECT *)	

SELECT *
FROM EMP
WHERE COMM > (SELECT COMM
		FROM EMP
		WHERE ENAME = 'SMITH');
		
SELECT *
FROM EMP
WHERE COMM > (SELECT NVL(COMM, 0)
		FROM EMP
		WHERE ENAME = 'SMITH');
		
SELECT *
FROM EMP
WHERE COMM > (SELECT NVL2(COMM, COMM, 0)
		FROM EMP
		WHERE ENAME = 'SMITH');
		
-- Q3. 'SMITH' ������� ���� �Ի��� ������� ��� ��ȸ
SELECT *
FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
		FROM EMP
		WHERE ENAME = 'SMITH');		

SELECT * 
FROM EMP
ORDER BY HIREDATE;

-- [������ �������� + ������ �Լ�]
-- : ������ �Լ� (�Է� ������ -> ��� �ϳ�)

-- Q1. ��� �̸�, ����� ���� �μ� ���� ��� (JOIN)
-- 1) ����� �߿��� �μ� 20�� ���ϴ� ��� ���
-- 2) ��ü ������� ��� �޿��� �Ѵ� ��� ���


SELECT E.EMPNO, E.ENAME, E.JOB, 
		E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE E.DEPTNO = 20
AND E.SAL > (SELECT AVG(SAL) FROM EMP);



-- [������ ��������]
-- : multiple-row subquery
-- : ���� ����� ������ ���� ������ ��������
-- : ������ �������� ������ (�� ������ (<,<=, >, >=)) ��� �Ұ�

-- ������ ������
-- 1) IN ������

SELECT *
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;

SELECT *
FROM EMP
WHERE DEPTNO IN (20, 30);

SELECT *
FROM EMP;

-- Q1. �� �μ��� �ְ� �޿��� �޴� ��� ���� ���
SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
				FROM EMP
				GROUP BY DEPTNO);

-- 2) ANY, SOME ������
-- : ANY == SOME ������ ��ġ (�ٲ㾵 �� ����)
-- : ���������� ����� �� �ϳ��� true�� true ��ȯ���ִ� ������

SELECT *
FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL)
				FROM EMP
				GROUP BY DEPTNO);
				
SELECT *
FROM EMP
WHERE SAL = SOME (SELECT MAX(SAL)
				FROM EMP
				GROUP BY DEPTNO);
-- IN ()�� �����ϰ� ���� (= ANY(), = SOME())
				
				
-- EX) 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ��� ����

-- 1) ������ �������� + ������ �Լ�
SELECT *
FROM EMP
WHERE SAL < (SELECT MAX(SAL) 
				FROM EMP
				WHERE DEPTNO = 30);
				
-- 2) 
SELECT *
FROM EMP
WHERE SAL < SOME(SELECT MAX(SAL) 
				FROM EMP
				WHERE DEPTNO = 30);		
				
-- 3) 
SELECT *
FROM EMP
WHERE SAL < SOME(SELECT SAL
				FROM EMP
				WHERE DEPTNO = 30);
				
-- SOME(950, 1250, 1500, 1600, 2850)
-- ()�� ���� �� �� �ּ� �ϳ��� ���� ���ǽĿ� �����ϸ� true
-- SAL < 950 OR
-- SAL < 1250 OR
-- SAL < 1500 OR
-- SAL < 1600 OR
-- SAL < 2850
-- => 30�� �μ� ������� �ִ�޿� (2850)���� 
--   ���� �޿��� �޴� ��� ���
				
SELECT *
FROM EMP
WHERE SAL > SOME(SELECT SAL
				FROM EMP
				WHERE DEPTNO = 30);				

-- SAL > 950 OR
-- SAL > 1250 OR
-- SAL > 1500 OR
-- SAL > 1600 OR
-- SAL > 2850
-- => 30�� �μ� ������� �ּ� �޿� (950)����
-- ���� �޿��� �޴� ��� ���		

-- 3) ALL ������
-- : ���������� ��� ����� ���ǽĿ� ���� ���

-- Q1. �μ� ��ȣ�� 30���� ������� �ּұ޿����� 
-- �� ���� �޿��� �޴� ���
SELECT *
FROM EMP
WHERE SAL < ALL(SELECT SAL
				FROM EMP
				WHERE DEPTNO = 30);	
-- SAL < 950 AND
-- SAL < 1250 AND
-- SAL < 1500 AND
-- SAL < 1600 AND
-- SAL < 2850
				
SELECT *
FROM EMP
WHERE SAL > ALL(SELECT SAL
				FROM EMP
				WHERE DEPTNO = 30);	
				
-- SAL > 950 AND
-- SAL > 1250 AND
-- SAL > 1500 AND
-- SAL > 1600 AND
-- SAL > 2850
-- => 30�� �μ��� �޿� �ִ� (2850)���� 
-- ���� �޿��� �޴� ��� ���
				
-- 4) EXISTS ������
-- : �������� ��� ���� �ϳ� �̻� �����ϸ� true
-- : �������� ������ false�� �Ǵ� ������
				
SELECT *
FROM EMP
WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO = 10);
-- DNAME ACCOUTING�� �����ϱ� ������ true ��ȯ

SELECT *
FROM EMP
WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO = 40);
-- DNAME OPERATIN�� �����ϱ� ������ true ��ȯ

SELECT *
FROM EMP
WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO = 50);
-- DEPTNO = 50�� DNAME�� ���� => false ��ȯ


SELECT *
FROM EMP
WHERE EXISTS(SELECT COMM 
			FROM EMP 
			WHERE COMM IS NULL);

SELECT *
FROM EMP
WHERE EXISTS(SELECT JOB 
			FROM EMP 
			WHERE JOB = 'DEVELOPER');
-- ���� ��� X
-- �������� ������� ���� ������ ����
-- ���������� ������ ���� ���θ� ������ ��
			
-- Q1. 10�� �μ��� ���� ��� ����麸�� ���� �Ի��� ��� ���� ���
SELECT *	
FROM EMP
WHERE HIREDATE < ALL(SELECT HIREDATE
				FROM EMP
				WHERE DEPTNO = 10);

-- => 10�� �μ� ��� �Ի糯 �߿��� ���� ���������� ���� �������
-- ���� �Ի��� ��� ���
SELECT *	
FROM EMP
WHERE HIREDATE < ANY(SELECT HIREDATE
				FROM EMP
				WHERE DEPTNO = 10);

-- => 10�� �μ� ��� �Ի糯 �߿��� ���� ���� �������
-- �ʰ� �Ի��� ��� ���				
SELECT *	
FROM EMP
WHERE HIREDATE > ANY(SELECT HIREDATE
				FROM EMP
				WHERE DEPTNO = 10);
				
-- => 10�� �μ� ��� �Ի糯 �߿��� ������ ���� �������
-- �ʰ� �Ի��� ��� ���					
SELECT *	
FROM EMP
WHERE HIREDATE > ALL(SELECT HIREDATE
				FROM EMP
				WHERE DEPTNO = 10);
				
		
SELECT *
FROM EMP
WHERE COMM > ALL(SELECT COMM
				FROM EMP
				WHERE DEPTNO = 10);
				
SELECT *
FROM EMP
WHERE COMM > ALL(1000, 2000, 3000); 
-- 3000 �޷����� ���� �޴� ��� ���

SELECT *
FROM EMP
WHERE COMM < ALL(1000, 2000, 3000); 
-- 1000 �޷����� ���� �޴� ��� ���

SELECT *
FROM EMP
WHERE COMM > ANY(1000, 2000, 3000); 
-- 1000 �޷����� ���� �޴� ��� ���

SELECT *
FROM EMP
WHERE COMM < ANY(1000, 2000, 3000); 
-- 3000 �޷����� ���� �޴� ��� ���

				
/* ALL, ANY/SOME
 * : ALL (������): Ÿ��Ʈ�� ���� (������ ���̱� �����)
 * => >: �������� ���� ����� ��� �� ���� 
 * (�� Ŀ����!, �ִ񰪺��� Ŀ����!)
 * => <: �������� ���� ����� ��� �� ���� 
 * (�� �۾ƾ� ��!, �ּڰ����ٵ� �۾ƾ���!)
 * 
 * : ANY/SOME (������): �� Ÿ��Ʈ�� ���� (������ ���̱� �� �����)
 * => >: �������� ���� ����� �ϳ��� ���� 
 * (�ּڰ����ٸ� ũ�� ������!)
 * => <: �������� ���� ����� �ϳ��� ���� 
 * (�ִ񰪺��ٸ� ������ ������!)
 * 
 * 
 * COMM IN (1000, 2000, 3000)
 * => �������� ��� �߿� �ϳ��� ����
 * => "���� �߿� �ϳ� �����ϴ� ?"
 * 
 * EXIST(SELECT DNAME FROM EMP DEPTNO = 40) => true
 * : �������� ���� ����� �����ϸ� �������� ���
 * EXIST(SELECT DNAME FROM EMP DEPTNO = 50) => false
 * : �������� ���� ����� �������� ������ �������� ��� X
 */

SELECT * FROM EMP;

-- [���߿� ��������]
-- : multiple-column subquery
-- : ���������� WHERE���� ���� �����͸� ���� �� �����ϴ� ��� -- 1
-- : ���������� SELECT���� ���� ���� ��ȣ�� ���� ��� -- 2
-- : 1���� 2���� ������ Ÿ���� ���� (�񱳰� ������ Ÿ��)

SELECT *
FROM EMP
WHERE COMM < ANY(1000, 2000, 3000);
-- => COMM < 3000

-- �׷캰 �ִ� �޿��� �ް� �ִ� ��� ���� ���
SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
					FROM EMP
					GROUP BY DEPTNO);
-- ���������� �����: ������, ���߿�

--(30, 2850): (DEPTNO = 30 AND SAL = 2850) OR
--(20, 3000): (DEPTNO = 20 AND SAL = 3000) OR
--(10, 5000): (DEPTNO = 10 AND SAL = 5000) 


					

-- [�ζ��� �� (inline view)]
-- : ��ü �����Ͱ� �ƴ� �Ϻ� �����͸� �����ϴ� ���
-- : ����� ����� ������� ���̺� ��Ī�� �־� ���

-- �� ����� ?
-- 1) ������ �Ը� �ʹ� Ŭ ��
-- 2) ���ϴ� �Ϻ� ��� ���� ����ϰ��� �� ��

/* ����)
 * WITH -- �ζ��� �� ����
 * [��Ī1] AS (SELECT�� 1),
 * [��Ī2] AS (SELECT�� 2),
 * ..
 * [��Īn] AS (SELECT�� n)
 * SELECT
 * FROM ��Ī1, ��Ī2, ....
 * 
 * */

-- => �������� ������
-- => �ۼ��� ���ŷο�
-- => ���������� �������� �з��ϱ⿣ ����
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;


-- ���������� FROM���� �ۼ��� �� ����
-- => �������� ������
-- => FROM���� ������� ���� �����ϱ� ���� WITH ���� ����
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10, 
	(SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;


-- SELECT���� ���������� �ۼ��� ���� ����
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
	(SELECT DEPT.DNAME
	FROM DEPT
	WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME,
	(SELECT DEPT.DEPTNO
	FROM DEPT
	WHERE E.DEPTNO = DEPT.DEPTNO) AS DEPTNO
FROM EMP E;
-- * �������� �ȿ� �� �� �̻��� �� �̸� ������ �� ����
