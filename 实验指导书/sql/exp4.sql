USE LMS
SELECT * FROM S;

# 2)在SELECT关键字后指明要检索的列名
# ①查询S表的学生学号和姓名
SELECT SNO,SNAME FROM S;


# ②查询S表中的系部名
SELECT DEPT FROM S 

# ③查询S表中不重复的系部名
SELECT DISTINCT DEPT FROM S


3)改变列标题的检索
①使用 空格 形式： 列名 新标题
SELECT SNO 学号 , SNAME 姓名 FROM S

②使用“AS”形式, 列名  AS  新标题
SELECT SNO AS 学号, SNAME AS  姓名 FROM S

4)有条件选择的查询
①在S表检索“信息系”的学生信息
SELECT  *  FROM  S WHERE DEPT='信息系'

②在S表中检索姓“王”的学生信息
SELECT  *  FROM  S WHERE  sname  like '王%';

③在SC表检索’C01’选修课成绩为空的选课记录
SELECT  SNO, CNO  FROM  SC  WHERE  cno='C01'  and  SCORE  is  null

④检索年龄为21, 18, 22的学生学号、姓名
SELECT  SNO, SNAME  FROM  S WHERE  age  in  (21,18,22)

Age IN {21,18,22}表示某条记录的AGE字段值是否是集合{21,18,22}中的元素, 如是, 则选择。它等价于下面语句：

SELECT SNO, SNAME FROM S WHERE  age=18 or age=21 or age=22

5)使用聚集函数
①查询选课表中最高分、平均分、最低分
SELECT MAX(SCORE), AVG(SCORE),MIN(SCORE) FROM SC


②查询“C01”课程的最高分、平均分和最小成绩。
SELECT MAX(SCORE), AVG(SCORE),MIN(SCORE)
FROM  SC
WHERE  CNO='C01'


6)对检索结果进行排序
SELECT  *  FROM  SC
WHERE  SCORE  IS  NULL
ORDER  BY  SNO, CNO  DESC


7)进行分组统计：
①查询各学生的选课数
SELECT  SNO, COUNT(*)
FROM  SC
GROUP  BY  SNO


②使用HAVING ：“选课表”中查询选修了3 门以上课程的学生学号。
SELECT  SNO , COUNT (*) FROM SC
GROUP  BY  SNO
HAVING  COUNT(*)>=3


③“选课表”中按学号分组汇总学生的平均分, 并按平均分降序排列。
SELECT  SNO  学号, AVG(SCORE)  平均分  FROM  SC
GROUP  BY  SNO
ORDER  BY  平均分  DESC


④分析下面两个SELECT语句执行结果, 说明有什么不同？
SELECT  SNO  FROM  SC
ORDER  BY  SNO
GO

SELECT  SNO  FROM  SC
GROUP  BY  SNO



1)查询计算机系学生的学号和姓名。
SELECT SNO, SNAME FROM S
WHERE DEPT='计算机系';


2)查询选修了课程的学生学号。
SELECT DISTINCT SNO FROM SC;


3)查询选修C01 课程的学生学号和成绩，并要求对查询结果按成绩的降序排列，如果成绩相同则按学号的升序排列。
SELECT SNO, SCORE FROM SC
WHERE CNO='C01'
ORDER BY SCORE DESC, SNO ASC;


4)查询每门课程的平均分。
SELECT CNO, AVG(SCORE) 平均分
FROM SC 
GROUP BY CNO;


5)查询学校开设的课程总数。
SELECT COUNT(CNO) FROM C;


6)查询选修两门及两门以上课程的学生学号。
SELECT SNO FROM SC
GROUP BY SNO
HAVING COUNT(*) > 1


7)查询年龄在20-22之间的男生的学号、姓名、系部。
SELECT SNO, SNAME, DEPT FROM S
WHERE AGE BETWEEN 20 AND 22


8)查询选修‘C01’课程的学生人数。
SELECT COUNT(*) FROM SC
WHERE CNO='C01'








