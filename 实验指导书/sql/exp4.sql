USE LMS
SELECT * FROM S;

# 2)��SELECT�ؼ��ֺ�ָ��Ҫ����������
# �ٲ�ѯS���ѧ��ѧ�ź�����
SELECT SNO,SNAME FROM S;


# �ڲ�ѯS���е�ϵ����
SELECT DEPT FROM S 

# �۲�ѯS���в��ظ���ϵ����
SELECT DISTINCT DEPT FROM S


3)�ı��б���ļ���
��ʹ�� �ո� ��ʽ�� ���� �±���
SELECT SNO ѧ�� , SNAME ���� FROM S

��ʹ�á�AS����ʽ, ����  AS  �±���
SELECT SNO AS ѧ��, SNAME AS  ���� FROM S

4)������ѡ��Ĳ�ѯ
����S���������Ϣϵ����ѧ����Ϣ
SELECT  *  FROM  S WHERE DEPT='��Ϣϵ'

����S���м����ա�������ѧ����Ϣ
SELECT  *  FROM  S WHERE  sname  like '��%';

����SC�������C01��ѡ�޿γɼ�Ϊ�յ�ѡ�μ�¼
SELECT  SNO, CNO  FROM  SC  WHERE  cno='C01'  and  SCORE  is  null

�ܼ�������Ϊ21, 18, 22��ѧ��ѧ�š�����
SELECT  SNO, SNAME  FROM  S WHERE  age  in  (21,18,22)

Age IN {21,18,22}��ʾĳ����¼��AGE�ֶ�ֵ�Ƿ��Ǽ���{21,18,22}�е�Ԫ��, ����, ��ѡ�����ȼ���������䣺

SELECT SNO, SNAME FROM S WHERE  age=18 or age=21 or age=22

5)ʹ�þۼ�����
�ٲ�ѯѡ�α�����߷֡�ƽ���֡���ͷ�
SELECT MAX(SCORE), AVG(SCORE),MIN(SCORE) FROM SC


�ڲ�ѯ��C01���γ̵���߷֡�ƽ���ֺ���С�ɼ���
SELECT MAX(SCORE), AVG(SCORE),MIN(SCORE)
FROM  SC
WHERE  CNO='C01'


6)�Լ��������������
SELECT  *  FROM  SC
WHERE  SCORE  IS  NULL
ORDER  BY  SNO, CNO  DESC


7)���з���ͳ�ƣ�
�ٲ�ѯ��ѧ����ѡ����
SELECT  SNO, COUNT(*)
FROM  SC
GROUP  BY  SNO


��ʹ��HAVING ����ѡ�α��в�ѯѡ����3 �����Ͽγ̵�ѧ��ѧ�š�
SELECT  SNO , COUNT (*) FROM SC
GROUP  BY  SNO
HAVING  COUNT(*)>=3


�ۡ�ѡ�α��а�ѧ�ŷ������ѧ����ƽ����, ����ƽ���ֽ������С�
SELECT  SNO  ѧ��, AVG(SCORE)  ƽ����  FROM  SC
GROUP  BY  SNO
ORDER  BY  ƽ����  DESC


�ܷ�����������SELECT���ִ�н��, ˵����ʲô��ͬ��
SELECT  SNO  FROM  SC
ORDER  BY  SNO
GO

SELECT  SNO  FROM  SC
GROUP  BY  SNO



1)��ѯ�����ϵѧ����ѧ�ź�������
SELECT SNO, SNAME FROM S
WHERE DEPT='�����ϵ';


2)��ѯѡ���˿γ̵�ѧ��ѧ�š�
SELECT DISTINCT SNO FROM SC;


3)��ѯѡ��C01 �γ̵�ѧ��ѧ�źͳɼ�����Ҫ��Բ�ѯ������ɼ��Ľ������У�����ɼ���ͬ��ѧ�ŵ��������С�
SELECT SNO, SCORE FROM SC
WHERE CNO='C01'
ORDER BY SCORE DESC, SNO ASC;


4)��ѯÿ�ſγ̵�ƽ���֡�
SELECT CNO, AVG(SCORE) ƽ����
FROM SC 
GROUP BY CNO;


5)��ѯѧУ����Ŀγ�������
SELECT COUNT(CNO) FROM C;


6)��ѯѡ�����ż��������Ͽγ̵�ѧ��ѧ�š�
SELECT SNO FROM SC
GROUP BY SNO
HAVING COUNT(*) > 1


7)��ѯ������20-22֮���������ѧ�š�������ϵ����
SELECT SNO, SNAME, DEPT FROM S
WHERE AGE BETWEEN 20 AND 22


8)��ѯѡ�ޡ�C01���γ̵�ѧ��������
SELECT COUNT(*) FROM SC
WHERE CNO='C01'








