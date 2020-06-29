














1)多表的连接查询(相当于做笛卡儿乘积)
SELECT * FROM  C, SC


2)表的等值连接查询
①查询各学生的选课信息(包括学号、课程名、成绩)
因为学号和成绩在SC表中, 而课程名在C表中, 因此需要多表查询。
SELECT SNO, CNAME, SCORE
FROM C, SC
WHERE C.CNO=SC.CNO


②查询学生的选课记录, 显示学生的学号、姓名、课程号、成绩)
SELECT S.SNO, SNAME, CNO, SCORE
FROM S, SC
WHERE S.SNO=SC.SNO


③查询学生的选课记录, 显示学生的学号、姓名、课程号、课程名、成绩
SELECT S.SNO, SNAME, SC.CNO, CNAME, SCORE
FROM S, SC, C
WHERE S.SNO=SC.SNO AND SC.CNO=C.CNO

delete from S where SNAME='ZXX';

④左外连接查询：当希望左表(第一张表)中所有记录全部显示出来时, 需要用左外连接操作。
INSERT INTO  S (SNO,SNAME)  VALUES ('20000','ZXX')

SELECT S.SNO, SNAME, CNO, SCORE
FROM S  
LEFT OUTER JOIN SC ON S.SNO=SC.SNO


观察与下面等值连接的执行结果有何不同？
SELECT S.SNO, SNAME, CNO, SCORE FROM S
JOIN SC ON S.SNO=SC.SNO
WHERE  S.SNO=SC.SNO


3)表自身的连接
①查询与'李勇'同系的学生学号
将学生表S与S本身进行等值连接(系部相等), 因为S与S做连接操作时不能区分, 所以, 对表取一个别名。然后将第二张表S中名字为'李勇'的记录选择出就可。
SELECT S1.SNO
FROM  S  AS  S1,  S  AS  S2
WHERE  S1.DEPT=S2.DEPT  AND  S2.SNAME='李勇'


②显示每个学生的非最高分成绩(学生自己的选课成绩中, 不是最高分的选课记录显示出来)
SELECT  SNO, CNO, SCORE  FROM  SC  AS  SC1 
WHERE  SCORE <(SELECT  MAX(SCORE)  FROM  SC  AS  SC2  
WHERE  SC2.SNO=SC1.SNO)

SELECT SC1.SNO, SC1.CNO, SC1.SCORE, SC2.MAX_SCORE FROM SC AS SC1,
	(SELECT SNO, MAX(SCORE) MAX_SCORE FROM SC
	GROUP BY SNO) AS SC2
WHERE SC1.SNO=SC2.SNO AND SC1.SCORE != SC2.MAX_SCORE

4)IN嵌套子查询
①不相关的IN 子查询：子查询可以单独执行, 与被嵌套的查询无关。
如, 查询与'李勇'同系的学生学号
可以先查询出'李勇'所在的系, 然后再到S表中查询与上述结果相同的记录。
SELECT  SNO 
FROM  S
WHERE  DEPT  IN 
(SELECT  DEPT  FROM  S  WHERE  SNAME='李勇')


查询'数据库原理'课程的选课人数
SELECT COUNT (*) FROM  SC
WHERE  CNO  IN 
( SELECT  CNO  FROM  C  WHERE  CNAME='数据库原理')

②相关的子查询：子查询中要用到父查询表的信息, 子查询不能独立执行。
如, 查询选修课程号为“C01”课程且成绩至少高于选修课程号为“C02”的同学的Cno、Sno和SCORE。
在子查询中, 因为要查找该同学'C02'课程的成绩, 所以, 需要父查询表中该学生的学号信息。
SELECT CNO, SNO, SCORE 
FROM  SC  AS  SC1
WHERE  CNO='C01'  AND  SCORE >(
SELECT SCORE FROM  SC  AS  SC2 
 WHERE  SC2.SNO=SC1.SNO AND SC2.CNO='C02')


5)*  EXISTS嵌套子查询
①执行以下语句, 观察显示的两个查询结果
SELECT SNO, SNAME 
FROM S
WHERE EXISTS
(SELECT * FROM SC WHERE CNO='C03')

GO 
SELECT SNO, SNAME  FROM S

delete from C WHERE CNO='C06';

②执行以下语句, 观察显示的两个查询结果
INSERT  INTO  C  VALUES('C06', '数据库安全', NULL, 3)
SELECT  SNO, SNAME 
FROM  S
WHERE  EXISTS
(SELECT  *  FROM  SC  WHERE  CNO='C06')

③查询'数据库原理'课程的选课人数
SELECT  COUNT(*)
FROM  SC
WHERE  EXISTS
( SELECT  *  FROM  C
   WHERE  C.CNO=SC.CNO AND CNAME='数据库原理')



1)查询“计算机系“学生所教课程的成绩表。
SELECT S.SNO,SNAME,DEPT,SCORE 
FROM S, SC
WHERE S.SNO=SC.SNO


2)查询成绩比该课程平均成绩低的同学的成绩表。
SELECT SC1.SNO, SC1.CNO, SC1.SCORE
FROM SC AS SC1,(
	SELECT CNO, AVG(SCORE) AVG_SCORE FROM SC
	GROUP BY CNO) AS SC2
WHERE SC1.CNO=SC2.CNO AND SC1.SCORE<AVG_SCORE


3)查询选修C01 课程的学生学号、课程名、成绩，并要求对查询结果按学号的降序排列，如果学号相同则按成绩的升序排列。
SELECT S.SNO, C.CNAME, SC.SCORE
FROM S, C, SC
WHERE S.SNO=SC.SNO AND C.CNO=SC.CNO AND SC.CNO='C01'
ORDER BY S.SNO DESC, SCORE ASC


4)查询选修两门及两门以上课程的学生学号及姓名。
SELECT S.SNO, S.SNAME
FROM S, (
	SELECT SNO, COUNT(*) COUNT FROM SC
	GROUP BY SNO
	HAVING COUNT(*) > 1) AS TEMP
WHERE S.SNO=TEMP.SNO


5)查询年龄在20-22之间的男生的选修的课程号。
SELECT S.SNO, S.SNAME, S.AGE, SC.CNO
FROM S, SC
WHERE S.SNO=SC.SNO AND S.AGE BETWEEN 20 AND 22 AND S.SEX='男'


6)查询选修‘数据结构’课程的学生人数。
SELECT COUNT(*) '学生人数'
FROM C, SC 
WHERE C.CNO=SC.CNO AND C.CNAME='数据结构'


7)查询每门选课成绩在80分以上的学生学号、姓名。
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