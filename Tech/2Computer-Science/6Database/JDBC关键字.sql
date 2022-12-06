一种解决一个字段含逗号的情况：
 ：FIND_IN_SET(str,strlist) 假如字符串str 在由N 子链组成的字符串列表strlist 中，则返回值的范围在 1 到 N 之间。
select g.id,g.school_ids,GROUP_CONCAT(s.locality_name) from goods g left join school s on FIND_IN_SET(s.id , g.school_ids)
GROUP BY g.id
ORDER BY g.id ASC

    一个聚合函数：一对多中将多行聚合未一行显示。需配合 group by；GROUP_CONCAT(distinct sd.id)可去重，可设置分隔符
    ：group_concat([DISTINCT] 要连接的字段 [Order BY ASC/DESC 排序字段] [Separator '分隔符'])



select column_name,column_comment,data_type from information_schema.columns where table_name = 'oms_order';

truncate table 表名;	删除表中的数据的方法有delete,truncate, 其中TRUNCATE TABLE用于删除表中的所有行，而不记录单个行删除操作。TRUNCATE TABLE 与没有 WHERE 子句的 DELETE 语句类似；但是，TRUNCATE TABLE 速度更快，使用的系统资源和事务日志资源更少。
-------------------------------------------------------------
从MySQL 5.7.5开始，默认的SQL模式包括ONLY_FULL_GROUP_BY
使用这个就是使用和oracle一样的group 规则, select的列都要在group中,或者本身是聚合列(SUM,AVG,MAX,MIN) 才行。

1、查询mysql 相关mode
select @@global.sql_mode;

如果结果包含：ONLY_FULL_GROUP_BY 字段

mysql> set @@global.sql_mode=`STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE, ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION`;



-------------------------------------------------------------

--select(属性，属性.........)	from（表名）						查询 	【DQL】数据查询语言
--where				where 条件语句									过滤
--group by															分组
--having															对分组后数据过滤
--order by			查询语句 order by 字段(排序的依据) desc|asc		排序
--desc 				降序 			倒序排序(即:从大到小排序)
--asc 				升序【默认】 	正序排序(即：从小到大排序)---升序排列
--join on			表连接
--max				最大值
--min				最小值
--avg				平均值
--sum				和
--[as] 				取别名
--and				与
--or				或
--UNION 			合并有相同列的表，如果允许重复的值，请使用 UNION ALL。
--[not]in			属于（针对于零散数据的查询）
--distinct			去重
--between  and		（包括）and（不包括）


Mybatis转义字符表
&lt;	<	小于
&gt;	>	大于
&amp;	&	与
&apos;	'	单引号
&quot;	"	双引号

--insert into 表名(属性，属性.......) values(对应添加值),(对应添加值) 增 		【DML】数据操作语言
--create sequence 序列名  start with n increment by m; 从n开始步长为m
--delete from 表名 where 删除条件									  删 		【DML】数据操作语言
--update 表名 set(属性=值，属性=值......)	where()					  改 		【DML】数据操作语言


--create   table		建表													【DDL】数据定义语言 create/alter/drop
--drop	table			删除表													【DDL】数据定义语言 create/alter/drop
--DROP TABLE T_USER cascade CONSTRAINTS  							强删

--number(n,m)		数字
--varchar2(n)		字符串
--date				日期（sql）
--clob				文本类型（大数据）
--blob				二进制类型（大数据）

--primary key		主键约束(非空且不重复)
--unique			不重复约束
--not null			非空约束
--check()			自定义约束
--reerences			外键（FK）
--defoult			默认值（当用户没有确定值时，自动填充的内容）

--rollback			回滚													【TX】事务控制
--commit			提交（insert或者update后如不提交表处于锁状态）			【TX】事务控制
--desc				列表属性

--StringBuffer		append		带占位符的可变长字符串



-----------------JDBC-------------------------
-------注册驱动

--Class.forName("oracle.jdbc.OracleDriver")

-------建立连接

--String url = "jdbc:oracle:thin:@localhost:1521:xe"
--Connection coon = DriverManager.getConnection(url,"hr","hr");

-------获得Statement对象

--Statement stmt = coon.createStatement();
--( PrepareStatement stmt = coon.prepareStatement();  )

-------sql语句

--String sql = "insert | delete | update | select"
--(String sql = "insert | delete | update | select ?????")
--			stmt.setString(1,xxxx);
--			stmt.setString(2,xxxx);

--通过Statement执行sql语句

--ResultSet rs = stmt.executeQuery(String sql)      		返回结果集
--Int       row = stmt.executUpdate(String sql)				返回影响数据条数 DDL DML
--rs.next()										游标

--处理返回集（rs）ResultSet 类型

--回收资源

--rs.close();


--------------------工具类------------------

--建立配置文件
--private static Properties pro = new Properties();

--建立静态代码块读取配置---------------------------

--先建立读取流
--InputStream is = new ;

--调用资源配置
--is =this.class.getResourceAsStream("配置文件")

--从流中读取属性列表
--pro.load(is)

----------------------------------------------------

--创建一个方法可以注册驱动    创建连接
--注册驱动
--Class.forName(pro.getproperty("jdbc.driver"));

--创建连接
--coon = DriverManager.getConnection(,,,)



------------------------------------------------------
--知识点总结
--sql语句
--jdbc封装sql语句			（细节：时间类型转换）
--运用工具类简化jdbc
--对多个jdbc封装成Dao（接口和类）
--建立业务层调用Dao(接口和方法)




---------------------------------------sql语句补充----------------------------------

一、Oracle引言(为什么使用数据库)

	1、传统存储数据的缺点：
		1) int a = 10; Object o = new Object();  临时数据
		2)文件存数：数据不安全、数据量较少、IO、并发

	2、数据库的优点
		1)持久保存数据
		2)安全   .data
		3)存储的数据量较大
		4)支持多用户访问
		5)支持多种数据类型
		6) 支持错误操作的撤销(TX事务控制)
		7)支持数据的移植和备份

	3、基本的概念：
		1) 数据库的作用：用于管理和持久化数据。
		2)关系型数据库(RDBMS)
		RDBMS :Relationship DataBase Management System
		存储数据时类似于二维表形式保存数据(table)，表与表之间可能存在关系(外键)。
		table ： 用于保存一类数据，由行和列构成  ------类(class)
		row ：行，代表保存的一条数据 -------一个具体的对象(new Xxx())
		column :列， 字段  ------ 对象的属性

	4、常用的关系型数据库：
		Oracle  mysql  SqlServer  DB2

二、Oracle数据库的使用

	1、安装、卸载
		安装：
		1) 准备安装目录，目录不要有中文
		2) 切记安装密码：管理员密码  ，sys
		3) 安装完毕后不要修改计算机名

	2、启动数据库的服务：
		OracleServiceXE ：Oracle的核心服务
		OracleXETNSListener ：Oracle的监听服务

	4、hr测试用户的解锁
		1)需要管理员用户解锁，以管理员身份登录
		2)解锁方式一：在dos界面中
			alter user hr account unlock

	5、第一条sql命令：
		select table_name from user_tables;

	6、模糊查询  [not]like
		% ：匹配0---n个字符
		_ : 一个占位符
		含A的 ： %A%
		以A开头(结尾) ：A%(%A)
		A的前后至少一个字符 ：_%A%_
		至少5个字符 ：_____%

三、Oracle数据库中的函数

	1、单行函数：每一行都会调用函数
		1) sysdate  ：当前的时间
			dual ：哑表、哑元  作用：保证select语法的完整  select sysdate from dual
		2)sys_guid() : 使用Oracle的策略生成UUID
			select sys_guid() from dual;
		3) mod(x,y) <====>x%y
		4) concat()：字符串拼接
		5)length()：求长度

	2、组函数：针对于一组数据，而执行的函数
		count():
			count(*) :统计所有的数据条数
			count(字段名) ：统计当前字段非空的数据条数
				区别：
					count(1) 与 count(*),如果有主键自动会优化指定到那一个字段。所以没必要去count(1)，用count(*)，sql会帮你完成优化的 因此：count(1)和count(*)基本没有差别！
					count(字段)，count(字段) 会统计该字段在表中出现的次数，忽略字段为null 的情况。
					count（主键）的执行效率是最优的。

		max()  min()  avg() sum()
		如果对于当前的表没有做特殊的分组处理，默认一张表就是一个组

	3、实战中的函数：
		nvl(字段,value):
			当给定字段的值为null时，显示为value值，如果给定的字段值不为null，显示原始值。
		to_char(date,’yyyy-mm-dd’):把日期数据转化为字符格式
		日期格式：
			yyyy ：四位年
			mm ：两位月
			dd ：两位日
			hh：12进制的小时
			hh24 ：24形式的小时
			mi：分钟
			ss：秒
			day：星期
		to_date(‘字符日期’,’yyyy-mm-dd’):把字符日期转化为Date
		--显示2000-01-01星期几
		select to_char(to_date('2000-01-01','yyyy-mm-dd'),'day') from dual;
		计算月份：add_months(date,n) : 计算n个月之后的日期

四、分组查询
	1、语法：select....from ......group by 分组依据
		根据分组条件对查询结果进行分组显示

	4、分组的规则：
		1)只有在group  by后出现的字段，才能出现在select之后
		2)如果在group by之后没有出现的字段，可以配合组函数出现在select之后
		3)如果在group by 之后出现单行函数，在select之后可以出现相同的单行函数

	5、分组之后再次过滤having
		where和having对比：
		1) where是对原始数据的过滤，having是对分组后的数据过滤
		2) 语法：where 在from之后，having在group by后
		3) 如果where和having具有相同的过滤效果，优先使用where

	6、所有查询的关键字：
		语法顺序：
			select ...from 表名(数据源)
			where...(对原始数据的过滤)
			group by...(对过滤后的数据分组)
			having....(对分组后的数据过滤)
			order by ..
		执行顺序：
			from ：确定数据源
			where：对原始数据的过滤
			group by ：对where过滤后的数据分组
			having：对分组后的数据过滤
			select: 运算得结果
			order  by ：对查询的结果进行排序

二、子查询
	1、概念：在原始完整的select语句上又嵌套了select，称内部为子查询，外部称为主查询。

	2、应用场景：查询的数据、查询的条件来源于一个动态的结果(select出来的)。

	3、子查询分类：
		1)子查询的结果为一个值。(一行一列)
			子查询处理：
			直接把这个结果当做一个值，进行等值、不等值的运算。
			--查询工资为最高工资的员工信息
			--步骤1 ：求最高工资
			select max(salary) from employees;   --maxSalary=24000
			--步骤2 ：查询工资为maxSalary的员工信息
			select * from employees where salary=maxSalary;
			--步骤3 ：替换整合  把子查询结果作为值放入条件语句
			select * from employees where salary=(select max(salary) from employees);

		2)子查询的结果为多个值【一列多行】
			处理方式：把查询的结果当做多个值，在where子句后使用in运算。
			--查询与last_name为'Cambrault'工资一样的员工信息
			--步骤1 ：查询last_name为‘Cambrault’的工资
			select salary from employees where last_name='Cambrault';--11000 7500
			--步骤2 ：查询工资为11000 7500的员工信息
			select * from employees where salary in(11000,7500);
			--步骤3 ：替换整合
			select * from employees where salary in(select salary from employees
			where last_name='Cambrault') and last_name!='Cambrault';

		3)子查询的结果为多行多列【分页】
			概念：
				伪列：数据表中本身不存在的列，是在查询过程中被构造出来，显示
				Oracle中的伪列：
				rownum：对查询数据的编号，第一条数据编号为1，......第n条数据编号为n。
					(rownum 不能做大于1操作)
					 rownum是查询过后才按顺序排的，假如你的条件是rownum>1;那么
						返回数据的第一条（rownum是1）就不符合要求了，然后第二
						条数据变成了现在的第一条，结果这一条rownum又变成1了又
						不符合要求了，以此类推 就没有返回结果。
				rowid：在整个数据库中唯一标识一条数据(计算机相关)  用的少

			2)查询4--6名的员工信息(rownum 不能做大于1操作)
				处理：把子查询的结果当做一张临时表处理
				第一步：
				查询员工的所有信息及伪列rownum，给rownum取别名
				select rownum as rn,e.* from employees e;--tb1
				第二步：
				从tb1中查询rn在4---6之间的数据
				select *  from tb1 where tb1.rn between 4 and 6;
				第三步：替换整合
				select  * from (select rownum as rn ,e.* from employees e) tb1
				where tb1.rn between 4 and 6;

	4、分页总结
		Select ：
			不排序：
				给rownum取别名rn，把rn当做虚表的有效列
				从虚表中查询rn在一个区间
				整合：最终的结果
			排序：
				按照指定字段排序，tb1
				给rownum取别名rn，把rn当做虚表的有效列
				从虚表中查询rn在一个区间
				整合：最终的结果

			分页参数：
				select语句中的参数：
					beginPage  ：开始的数据
					endPage：结束数据
					dataCount：总的数据条数 select count(*) from 表名
				页面可以传递的参数
					pageSize ：每页显示的数据条数
					currentPage：当前页码
				通过计算：
					pageCount ：总的页码数  (dataCount-1)/pageSize+1
					beginPage:(currentPage-1)*pageSize+1
					endPage:curremtPage*pageSize
	5、匹配查询到的指定列的值并修改
		(case u.sex
         when 1 then '男'---------------1是匹配的列值，'男'是将匹配的列值修改的值
         when 2 then '女'
         else '空的'
         end
        )性别---------------------------列名

三、表连接【重点、难点】

	1、应用场景：当查询的数据不是从一张表中查询时，此时要使用表连接。

	2、表连接的语法：select ....from 表1 [连接方式] join 表2 on 连接条件
		连接的分类：内连接 、外连接、交叉连接、自连接

	3、内连接：select ...from 表1  [inner] join 表2 on 连接条件
		举例：
			查询员工的姓名、工资(employments)、部门编号、部门名称(departments)
				select 	e.first_name||'_'||e.last_name,e.salary,d.department_i	d,d.department_name
				from employees e join departments d
				on e.department_id=d.department_id
		内连接特点：
			1、必须有连接条件
			2、查询结果：只有满足连接的数据才会显示
			3、主从关系：没有主从关系

	4、外连接(左外连接、右外连接、全外连接)
		左外连接语法：select ....from 表1 left  [outer]  join 表2 on 连接条件
		右外连接语法：select ....from 表1 right [outer]  join 表2 on 连接条件
		全外连接语法：select ....from 表1 full [outer]  join 表2 on 连接条件
		举例：
			1、查询员工的姓名、工资(employments)、部门编号、部门名称(departments)[左外连接]
				select  e.first_name||’_’||e.last_name,e.salary,d.department_id,d.department_name  from employees e left join departments d
				on e.department_id=d.department_id
		左外连接的特点：
			1、必须有连接条件
			2、查询结果：满足连接条件的数据+左表中不满足连接条件的数据
			3、主从关系：左表为主表
		右连接的特点：
			1、必须有连接条件
			2、查询结果：满足连接条件的数据+右表中不满足连接条件的数据
			3、主从关系：右表为主表
		全连接的特点：
			1、必须有连接条件
			2、查询结果：满足连接条件的数据+左、右表中不满足连接条件的数据
			3、主从关系：没有

	5、多表连接(三张)【了解】
		语法：
			select ...from 表1  [连接方式]join 表2
			on  表1和表2的连接条件
			[连接方式] join 表3
			on 表3和虚表的连接条件(注：虚表指表1和表2的查询结果)
		举例：
			--2.查询在研发部('IT')工作员工的编号，姓名（employees），工作部门(departments)，工作所在地(locations)
			select e.employee_id,e.first_name,d.department_name,l.city
			from employees e join departments d
			on e.department_id=d.department_id
			join locations l
			on d.location_id=l.location_id
			where d.department_name='IT'


一、基本概念
	1、SQL：Structure  Query Language 结构化查询语言
	2、SQL体系的分类：
		DQL ：Data Query Language 数据查询语言 select【重点】
		DDL：Data Define Language 数据定义语言  create/alter/drop
		DML:Data Manipulate Language 数据操作语言 delete/insert/upadate【重点】
			数据的增删改
		DCL：Data Controller Language 数据控制语言 grant 授权
		TCL：Transaction Controller Language 事务控制语言 commit/rollback【重点】

二、DDL 数据定义语言
	1、Oarcle中的数据类型desc
		1)number
			  number(n) : 给定的最大数字值不能超过n位
			  number(5) :100.2
			  number(n,m): 总的长度为n，小数位数为m，其中小数点不占位
			  number(5,3) :   123.5 error
				12.3  12.33333 四舍五入
			  number ：给定的数值为小数或者整数  整数最大为38  小数位8

		2)字符串相关：
			varchar2(n) :最大给定n个长度的字符串,可变长
			char(n) :最大给定n个长度的字符串,不可变长
			varchar2(5):   abcde   ab
			char(5): abcde    ‘ab   ‘

		3)date 日期类型
			注意：在Oracle中没有boolean类型，varchar(1) y n

		4)大数据类型【了解】
			clob：文本类型
			blob：二进制文件，音频、视频

	2、Oracle中的约束
		约束：对用户给定数据的校验
		1)主键约束  primary key  在整个数据表中是唯一标识
			保证给定的值在数据表中不重复、不为空
		2)唯一 ：unique
			保证给定的值在数据表中不重复
		3)非空 ：not null
			保证给定的值在数据表中不为空
		4)自定义约束 、check约束
			密码必须为六位：check (password like’______’)  | check (length(password)=6)
			邮箱必须有@符号：check (email like ‘%@%’)
			座机必须是有-，前面三位为位，后面为6位：check(telphone like ‘___-______’)
		5)外键 references (FK)
			一张表的主键作为另一张表的外键(如：部门表中的部门编号就是员工表中的外键)
		6) 默认值： 当用户给定字段没有值时，自动填充的内容
			default 值
	3、建表 ：
		语法：
		create table 表名(
			字段名1 数据类型1 [默认值] [约束1] [约束2] ,
			字段名2 数据类型2 [默认值] [约束1] [约束2] ,
			.....
			字段名n 数据类型n [默认值] [约束1] [约束2]
		);
		举例：
			创建单表
				创建一张班级表
					班级编号  number(6)
					班级名称  varchar2(50)
					班主任    varchar2(30)
					班级的最大人数 number(3)
					开班时间 date
					create table  t_clazz(
						cid number(6) primary key,
						cname varchar2(50) not null,
						bzr varchar2(30),
						maxCount number(3),
						createTime date
					);
			创建有外键的表
				创建一张学生表
					学号   number(6)
					姓名  varchar2(30)
					性别  varchar2(1)
					年龄  number(3)
					电话  varchar2(11)
					邮箱  varchar2(30)
					家庭住址 varchar2(100)
					所在班级 number(6)   外键指向t_clazz表中的主见
					create table t_student(
						id number(6) primary key,
						name varchar2(30) not null,
						sex varchar2(1)  default ‘f’ check(sex in (‘f’,’m’)),
						age number(3),
						email varchar2(30) check(email like ‘_%@%_’),
						address varchar2(30),
						cid number(6) references t_clazz(cid)
					);
		补充：
			mysql :  database
			Oracle :  user
		创建用户：
			sql 版 ：
				创建用户：create user aa(用户名) identified by aa(密码);
				注意：密码不能书写为纯数字
				给用户授权： grant create session to aa;
							grant connect,resource to aa;
	4、删除表结构 drop table 表名
		细节：
		父表：没有外键(1)  先创建 后删除
		子表：有外键表(多) 后创建 先删除
三、DML【insert/delete/update】【重点】
	1、insert 添加数据
		语法一：全表插入
			insert into 表名 values(所有字段的值);
		例子：向t_clazz表中添加一条数据
			insert  into t_clazz values(1,’java84班’,’miss teng’,150,to_date(‘2017-03-15’,’yyyy-mm-dd’));
		语法二：部分字段插入
			insert into 表名(字段1,字段2,字段3)values(值1,值2,值3)
			insert into t_clazz (cid,cname,bzr)values(2,’java86班’,’miss teng’);
		注意细节：
			①全表插入：字段的个数、数据类型、顺序完全匹配，对于没有非空约束的字段如果想添加为空值，指定为null
			②部分字段：提倡使用，非空约束的字段必须出现
			③添加数据有父子关系 ：先给父表添加数据
	2、序列【重点】(类似于目录可加快查检速度，但占用内存)
		作用：生成一组有序、不重复的数字,用于做主键或者唯一键的生成
		如何使用序列：
			1）创建一个序列(一张表创建一个序列)
				create sequence 序列名 ;--创建的序列从1开始，步长为1
					如：create sequence seq_clazz
				create sequence 序列名  start with n increment by m; 从n开始步长为m

			2）使用 序列名.nextval  ：获得序列的下一个值
				结合序列向表中添加数据
				insert into t_clazz (cid,cname,bzr)values(seq_clazz.nextval,’h583班’,’xxx’);
					每运行一次本语句：seq_clazz.nextval会获得一个当前序列的正常排序的下一个序列值作为cid属性的值，
			3）删除序列：drop sequence 序列名
				主键生成方式二：UUID-----sys_guid()
				insert into t_user(id,name,pass)values(sys_guid(),’yanxj@’,’888888’);
	3、delete 删除表中的数据
		语法：delete from 表名 where 删除条件
			删除t_clazz表中id为1的数据：
			delete from t_clazz where cid=1;
		具有父子关系表中：
			如果要删除父表中的数据：
				处理方式一：把子表中的数据删除
				处理方式二：把子表关系的外键修改 null或者其他的父表数据
	4、update修改表中的数据
		语法： update 表名 set 字段=新值,字段=新值 where  修改条件
		例如：
			把学生表中的id为1的姓名修改为test
			update t_student set name=’test’ ,email=’aaa@aa’ where id=1;
四、事务控制(TX)【重点概念】
	1、事务的概念：数据库的最小操作单元，包括多条sql语句，这些sql要么同时成功(一个事务成功，提交：commit)；如果有一条sql失败(事务失败，回滚：rollback)。

	2、事务的原理：

	3、事务的范围：
		开始：
		第一条sql执行开始
		sql2...
		sqln
		结束：commit;rollback
		注意：在每个数据库的client(dos界面、浏览器、第三方)，做完DML操作后，要加上commit。
	4、事务的特点(ACID).
		A :Automatic 事务的原子性，同一个事务的多条sql不可分割
		C：Consistency 事务的一致性，同一个事务的前后操作状态一致
		I：Isolation 事务的隔离性，多个事务之间相互独立，互不影响
		D：Durability 事务的持久性，影响数据库的操作是持久的


















































