DROP TABLE STUDENT;
CREATE TABLE STUDENT (
	ID NUMBER(4),
	LastName VARCHAR(255),
	FirstName VARCHAR(255),
	Address VARCHAR(255),
	City VARCHAR(255)
);

SELECT * FROM STUDENT;
INSERT INTO STUDENT VALUES (NULL, NULL, NULL, NULL, NULL);

SELECT COUNT(*)
FROM STUDENT;

-- 1) Ư�� �Ӽ����� �����͸� �����ϴ� ���
-- INSERT INTO ���̺�� (�Ӽ� 1, �Ӽ� 2,....)
-- VALUES (�� 1, �� 2, ....)
INSERT INTO STUDENT (ID, LastName, FirstName)
VALUES (1, 'ȫ', '�浿');

-- 2) ��� �Ӽ��� ���� �����͸� �����ϴ� ���
-- INSERT INTO ���̺�� 
-- VALUES (�� 1, �� 2, ....)
INSERT INTO STUDENT
VALUES (1, 'ȫ', '�浿', '��Ʈ�п�', '�����');




