









1)���ݵĲ���
�ٵ���¼�Ĳ���
USE  LMS
GO
SELECT  *  FROM  S
INSERT INTO  S(SNO, SNAME) VALUES('200300','Paulwen')
SELECT * FROM  S


�ڶ��¼�Ĳ���
CREATE  TABLE  SBAK(
SNO VARCHAR (10) NOT NULL,
SNAME VARCHAR(20),
DEPT VARCHAR(20), 
AGE INT, 
SEX CHAR(4))
GO
SELECT *  FROM  SBAK
INSERT  INTO  SBAK  SELECT *  FROM  S;
SELECT *  FROM  SBAK



2)���ݵ�ɾ��
CREATE  TABLE CBAK ( 
	CNO VARCHAR(10) NOT NULL, 
	CNAME VARCHAR(20), 
	CPNO VARCHAR(10),
	CREDIT INT)
GO
INSERT  INTO  CBAK  SELECT  *  FROM  C
DELETE  FROM  CBAK  WHERE  CREDIT<4
SELECT  *   FROM  CBAK


3)���ݵ��޸�
SELECT  *  FROM  S
UPDATE  S  SET  DEPT='CS'WHERE  DEPT='�����ϵ'
GO
SELECT  *  FROM  S


4)�����Ľ���
�ٽ����Ǿ�������
SELECT  *  FROM  C
GO
CREATE  INDEX  ICNAME  ON  C (CNAME)
GO
SELECT  *   FROM  C  /*�����ݱ� */
SELECT  *   FROM  C  with (INDEX= ICNAME)   /*�������������ݱ� */


�ڽ�����������
SELECT *  FROM  C
GO
CREATE  CLUSTERED  INDEX  CICNO  ON  C(CNO)
GO
SELECT *   FROM  C


�۽���Ψһ����
CREATE  UNIQUE  INDEX  UISNO  ON  SC (SNO)

ִ�к���ʲô�����Ϊʲô�������������
CREATE  UNIQUE  INDEX  UISNO  ON  SC (SNO,  CNO  DESC)

ִ�к���ʲô�����

�ܽ�����������
SELECT  *  FROM  S
GO
CREATE  INDEX  IAGESNO  ON  S(AGE DESC, SNO)
GO 
SELECT  *  FROM  S
SELECT  *  FROM  S WITH (INDEX =IAGESNO)


�ݲ鿴���е�����
SP_HELPINDEX  'S'


��ɾ�����е�����
DROP  INDEX  S.IAGESNO
GO
SP_HELPINDEX  'S'


5)��ͼ�������
����ͼ�Ľ���
CREATE  VIEW  SHOWSNO
	AS
	SELECT  S.SNO, SNAME, AVG(SCORE) AS ƽ���ɼ� 
	FROM  S, SC
	WHERE  S.SNO=SC.SNO
	GROUP BY S.SNO, SNAME
GO 
SELECT  *  FROM  SHOWSNO



������Ϣϵѧ������ͼ
CREATE  VIEW  VISDEPT
AS
SELECT  *   FROM  S  WHERE  DEPT='��Ϣϵ'


������ͼ���޸�����
UPDATE  VISDEPT
SET  DEPT='IS'
GO 
SELECT  *  FROM  VISDEPT
��ͼ�л���������Ϊʲô��������

CREATE  VIEW  S_SUM AS
	SELECT  SNO, SUM(SCORE)  AS  TOTALSCORE  FROM  SC
	GROUP  BY  SNO
GO
UPDATE  S_SUM SET TOTALSCORE=60

ִ�����, ����ʲô���������Ϊʲô��

������ͼ��ɾ������
SELECT  *  FROM  VISDEPT
DELETE  FROM  VISDEPT  WHERE  SEX='Ů'
SELECT  *  FROM  VISDEPT
SELECT  *  FROM  S



1)��S��ϵ��Ϊ�������ϵ��ѧ����Ӧ��ϵ����Ϊ��CS����
UPDATE S SET DEPT='CS' WHERE DEPT='�����ϵ';


2)����һ����SC����ͬ�����ݱ�SCNEW����ѯSC���гɼ�Ϊ�յļ�¼�����临�Ƶ�SCNEW���С�
create table SCNEW(
	SNO VARCHAR(10) NOT NULL,
	CNO VARCHAR(10) NOT NULL,
	SCORE DECIMAL
)
GO
INSERT INTO SCNEW SELECT * FROM SC WHERE SCORE IS NULL
SELECT * FROM SCNEW



3)ɾ��SC���гɼ�Ϊ�յ�ѡ�μ�¼��
DELETE FROM SC WHERE SCORE IS NULL
GO
SELECT * FROM SC


4)����S���������ֶν���Ψһ��������
CREATE UNIQUE INDEX UISNAME ON S(SNAME)


5)����S����SNO�ľ���������
CREATE CLUSTERED INDEX CISNO ON S(SNO)

6)����SC���ϸ���SNO����CNO����ĸ���������
CREATE INDEX IDX_SNO_CNO ON SC(SNO ASC, CNO DESC)


7)����ÿ�ſγ̵Ŀγ̺š��γ�����ѡ��������ƽ���ֵ���ͼ��
CREATE VIEW MYVIEW AS
	SELECT C.CNO, C.CNAME, COUNT(SC.CNO) ѡ������, AVG(SC.SCORE) ƽ����
	FROM C
	LEFT OUTER JOIN SC
	ON C.CNO=SC.CNO
	GROUP BY C.CNO, SC.CNO, C.CNAME
GO
SELECT * FROM MYVIEW
