














1)�������Ӳ�ѯ(�൱�����ѿ����˻�)
SELECT * FROM  C, SC


2)��ĵ�ֵ���Ӳ�ѯ
�ٲ�ѯ��ѧ����ѡ����Ϣ(����ѧ�š��γ������ɼ�)
��Ϊѧ�źͳɼ���SC����, ���γ�����C����, �����Ҫ����ѯ��
SELECT SNO, CNAME, SCORE
FROM C, SC
WHERE C.CNO=SC.CNO


�ڲ�ѯѧ����ѡ�μ�¼, ��ʾѧ����ѧ�š��������γ̺š��ɼ�)
SELECT S.SNO, SNAME, CNO, SCORE
FROM S, SC
WHERE S.SNO=SC.SNO


�۲�ѯѧ����ѡ�μ�¼, ��ʾѧ����ѧ�š��������γ̺š��γ������ɼ�
SELECT S.SNO, SNAME, SC.CNO, CNAME, SCORE
FROM S, SC, C
WHERE S.SNO=SC.SNO AND SC.CNO=C.CNO

delete from S where SNAME='ZXX';

���������Ӳ�ѯ����ϣ�����(��һ�ű�)�����м�¼ȫ����ʾ����ʱ, ��Ҫ���������Ӳ�����
INSERT INTO  S (SNO,SNAME)  VALUES ('20000','ZXX')

SELECT S.SNO, SNAME, CNO, SCORE
FROM S  
LEFT OUTER JOIN SC ON S.SNO=SC.SNO


�۲��������ֵ���ӵ�ִ�н���кβ�ͬ��
SELECT S.SNO, SNAME, CNO, SCORE FROM S
JOIN SC ON S.SNO=SC.SNO
WHERE  S.SNO=SC.SNO


3)�����������
�ٲ�ѯ��'����'ͬϵ��ѧ��ѧ��
��ѧ����S��S������е�ֵ����(ϵ�����), ��ΪS��S�����Ӳ���ʱ��������, ����, �Ա�ȡһ��������Ȼ�󽫵ڶ��ű�S������Ϊ'����'�ļ�¼ѡ����Ϳɡ�
SELECT S1.SNO
FROM  S  AS  S1,  S  AS  S2
WHERE  S1.DEPT=S2.DEPT  AND  S2.SNAME='����'


����ʾÿ��ѧ���ķ���߷ֳɼ�(ѧ���Լ���ѡ�γɼ���, ������߷ֵ�ѡ�μ�¼��ʾ����)
SELECT  SNO, CNO, SCORE  FROM  SC  AS  SC1 
WHERE  SCORE <(SELECT  MAX(SCORE)  FROM  SC  AS  SC2  
WHERE  SC2.SNO=SC1.SNO)

SELECT SC1.SNO, SC1.CNO, SC1.SCORE, SC2.MAX_SCORE FROM SC AS SC1,
	(SELECT SNO, MAX(SCORE) MAX_SCORE FROM SC
	GROUP BY SNO) AS SC2
WHERE SC1.SNO=SC2.SNO AND SC1.SCORE != SC2.MAX_SCORE

4)INǶ���Ӳ�ѯ
�ٲ���ص�IN �Ӳ�ѯ���Ӳ�ѯ���Ե���ִ��, �뱻Ƕ�׵Ĳ�ѯ�޹ء�
��, ��ѯ��'����'ͬϵ��ѧ��ѧ��
�����Ȳ�ѯ��'����'���ڵ�ϵ, Ȼ���ٵ�S���в�ѯ�����������ͬ�ļ�¼��
SELECT  SNO 
FROM  S
WHERE  DEPT  IN 
(SELECT  DEPT  FROM  S  WHERE  SNAME='����')


��ѯ'���ݿ�ԭ��'�γ̵�ѡ������
SELECT COUNT (*) FROM  SC
WHERE  CNO  IN 
( SELECT  CNO  FROM  C  WHERE  CNAME='���ݿ�ԭ��')

����ص��Ӳ�ѯ���Ӳ�ѯ��Ҫ�õ�����ѯ�����Ϣ, �Ӳ�ѯ���ܶ���ִ�С�
��, ��ѯѡ�޿γ̺�Ϊ��C01���γ��ҳɼ����ٸ���ѡ�޿γ̺�Ϊ��C02����ͬѧ��Cno��Sno��SCORE��
���Ӳ�ѯ��, ��ΪҪ���Ҹ�ͬѧ'C02'�γ̵ĳɼ�, ����, ��Ҫ����ѯ���и�ѧ����ѧ����Ϣ��
SELECT CNO, SNO, SCORE 
FROM  SC  AS  SC1
WHERE  CNO='C01'  AND  SCORE >(
SELECT SCORE FROM  SC  AS  SC2 
 WHERE  SC2.SNO=SC1.SNO AND SC2.CNO='C02')


5)*  EXISTSǶ���Ӳ�ѯ
��ִ���������, �۲���ʾ��������ѯ���
SELECT SNO, SNAME 
FROM S
WHERE EXISTS
(SELECT * FROM SC WHERE CNO='C03')

GO 
SELECT SNO, SNAME  FROM S

delete from C WHERE CNO='C06';

��ִ���������, �۲���ʾ��������ѯ���
INSERT  INTO  C  VALUES('C06', '���ݿⰲȫ', NULL, 3)
SELECT  SNO, SNAME 
FROM  S
WHERE  EXISTS
(SELECT  *  FROM  SC  WHERE  CNO='C06')

�۲�ѯ'���ݿ�ԭ��'�γ̵�ѡ������
SELECT  COUNT(*)
FROM  SC
WHERE  EXISTS
( SELECT  *  FROM  C
   WHERE  C.CNO=SC.CNO AND CNAME='���ݿ�ԭ��')



1)��ѯ�������ϵ��ѧ�����̿γ̵ĳɼ���
SELECT S.SNO,SNAME,DEPT,SCORE 
FROM S, SC
WHERE S.SNO=SC.SNO


2)��ѯ�ɼ��ȸÿγ�ƽ���ɼ��͵�ͬѧ�ĳɼ���
SELECT SC1.SNO, SC1.CNO, SC1.SCORE
FROM SC AS SC1,(
	SELECT CNO, AVG(SCORE) AVG_SCORE FROM SC
	GROUP BY CNO) AS SC2
WHERE SC1.CNO=SC2.CNO AND SC1.SCORE<AVG_SCORE


3)��ѯѡ��C01 �γ̵�ѧ��ѧ�š��γ������ɼ�����Ҫ��Բ�ѯ�����ѧ�ŵĽ������У����ѧ����ͬ�򰴳ɼ����������С�
SELECT S.SNO, C.CNAME, SC.SCORE
FROM S, C, SC
WHERE S.SNO=SC.SNO AND C.CNO=SC.CNO AND SC.CNO='C01'
ORDER BY S.SNO DESC, SCORE ASC


4)��ѯѡ�����ż��������Ͽγ̵�ѧ��ѧ�ż�������
SELECT S.SNO, S.SNAME
FROM S, (
	SELECT SNO, COUNT(*) COUNT FROM SC
	GROUP BY SNO
	HAVING COUNT(*) > 1) AS TEMP
WHERE S.SNO=TEMP.SNO


5)��ѯ������20-22֮���������ѡ�޵Ŀγ̺š�
SELECT S.SNO, S.SNAME, S.AGE, SC.CNO
FROM S, SC
WHERE S.SNO=SC.SNO AND S.AGE BETWEEN 20 AND 22 AND S.SEX='��'


6)��ѯѡ�ޡ����ݽṹ���γ̵�ѧ��������
SELECT COUNT(*) 'ѧ������'
FROM C, SC 
WHERE C.CNO=SC.CNO AND C.CNAME='���ݽṹ'


7)��ѯÿ��ѡ�γɼ���80�����ϵ�ѧ��ѧ�š�������
SELECT S.SNO, S.SNAME
FROM S, (
	SELECT SNO, COUNT(*) COUNT
	FROM SC
	GROUP BY SNO) AS T1,
(
	SELECT SNO, COUNT(*) COUNT_80
	FROM SC
	WHERE SCORE>80
	GROUP BY SNO) AS T2
WHERE S.SNO=T1.SNO AND S.SNO=T2.SNO AND T1.COUNT=T2.COUNT_80



SELECT SNO, COUNT(*) COUNT
FROM SC
GROUP BY SNO


SELECT SNO, COUNT(*) COUNT_80
FROM SC
WHERE SCORE>80
GROUP BY SNO