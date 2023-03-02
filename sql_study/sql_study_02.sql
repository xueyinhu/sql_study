/** JOIN 子句用于将两个或者多个表联合起来进行查询
 * 当两个表中有同名的字段时，可以可以通过 table_name.column_name 来区分
 * ON 与 WHERE 的区别，ON 是连接条件，决定临时表的生成
 *  1. INNER JOIN 交集
 *  2. LEFT JOIN table_01的全集 + NULL
 *  3. RIGHT JOIN table_02的全集 + NULL
 *  4. FULL JOIN 全集
 *  5. SELF JOIN 自连接
 *  6. CROSS JOIN 交叉连接
 */
SELECT table_column_?, table_02_column_? FROM table_name_01 [] JOIN table_name_02 ON table_name_01_column_01 = table_name_02_column_01;
SELECT a.column_?, b.column_? FROM table_01 as a, table_02 as b WHERE condition;
-- 慎用 CROSS JOIN

/** UNION 与 UNION ALL 用于合并两个或者多个 SELECT 语句的结构集
 * UNION 运算符会过滤掉重复的记录，还会按照默认规则排序。UNION ALL 只是简单合并。
 * 比如 MySQL，不支持 FULL JOIN，就可以用 UNION ALL 来代替。
 */
SELECT column_? FROM table_? [WHERE] UNION / UNION ALL SELECT column_? FROM table_? [WHERE];

-- AS 为表或字段起一个临时的别名

/** ALTER TABLE 修改、添加、删除、修改与表相关的各种要素
 * 1. 给表添加新的字段
 * 2. 修改现有字段的名字
 * 3. 修改现有字段的类型
 * 4. 添加约束
 * 5. 删除约束
 */
ALTER TABLE table_name ADD column_name datatype;
ALTER TABLE table_name DROP COLUMN column_name;
ALTER TABLE table_name MODIFY COLUMN column_name datatype;
ALTER TABLE table_name MODIFY column_name datatype NOT NULL / ?;
ALTER TABLE table_name ADD CONSTRAINT MyUniqueConstraint UNIQUE(column_?);
ALTER TABLE table_name ADD CONSTRAINT MyUniqueConstraint CHECK (CONDITION);
ALTER TABLE table_name ADD CONSTRAINT MyPrimaryKey PRIMARY KEY (column_?);
ALTER TABLE table_name DROP CONSTRAINT MyUniqueConstraint;
-- 若使用的是 MySQL，则上句修改为：
ALTER TABLE table_name DROP INDEX MyUniqueConstraint;
ALTER TABLE table_name DROP CONSTRAINT MyPrimaryKey;
-- 若使用的是 MySQL，则上句修改为：
ALTER TABLE table_name DROP PRIMARY KEY;

/** TRUNCATE TABLE 清空表，删除表中的所有数据
 * DROP TABLE 会删除表的数据、结构、索引、触发器、约束等所有信息
 * DELETE FROM 使用的系统资源与日志资源较多，速度较慢
 *  其每删除一行，都会在事务日志中为所删除的行记录一项
 *  TRUNCATE TABLE 释放表中数据所用的数据页来删除数据，只会在事务日志中记录页的释放
 *  此外，TRUNCATE TABLE 还能重置具有自动递增(AUTO_INCREMENT)属性的字段
 */
TRUNCATE TABLE table_name;

/** SQL 视图 CREATE VIEW
 * 视图（VIEW）是一个由 SELECT 查询所定义出来的虚拟表，被视图引用的表被称为基础表
 *  实际上，并不同于查询出的结构集，视图给 SELECT 查询起了一个名字，并不会真正去执行
 *  除非为视图添加索引（INDEX），否则视图仅仅是一段存储在内存中的 SELECT 语句的文本
 * 与表主要的区别在于：
 *  表占用物理存储空间，也包含真正的数据；
 *  视图不需要物理存储空间（除非添加索引（INDEX）），也不包含真正的数据，只是引用数据
 * 为什么使用视图
 *  1. 简化数据访问，复杂的逻辑放在视图中实现
 *  2. 防止敏感的数据被选中，同时仍然提供访问
 *  3. 对视图添加一些格外的索引，来提高查询的效率
 *  缺点：在数据请求与数据交付之间加了一层开销
 * 视图的修改
 *  1. 通过视图修改的数据也必须呈现到图中
 *  2. 视图中的数据必须满足基础表的满足
 */
CREATE VIEW view_name AS SELECT column_? FROM table_name WHERE condition;
DROP VIEW view_name;

/** HAVING 子句 通常与 GROUP BY 子句一起使用
 * WHERE 子句在 GROUP BY 前起作用，HAVING 子句在 GROUP BY 子句后起作用
 */
 SELECT column_? FROM table_? WHERE condition GROUP BY column_? HAVING condition ORDER BY column_?;

/** 事务 将若干条 SQL 语句（基本操作）“打包”在一起，共同执行一个完整的任务
 * 事务的四个标准属性：
 *  1. 原子性（A，不可分割性）
 *      事务在执行过程中发生错误，会被回滚到事务开始前的状态
 *  2. 一致性（C）
 *      数据库的完整性不能被破坏，能完成接下来预定的事务
 *  3. 隔离性（I，独立性）
 *      多个并发事务同时对其数据进行读写和修改，事务隔离有着不同等级
 *          a. 读未提及
 *          b. 读提交
 *          c. 可重复性
 *          d. 串行化
 *  4. 持久性（D）
 *      事务成功执行后，对数据库的修改是永久的
 * 事务执行流程（MySQL为例）
 *  1. BEGIN / START TRANSACTION 事务开始
 *  2. COMMIT 提交事务
 *  3. ROLLBACK 回滚事务
 *  4. SAVEPOINT 在事务内部设置回滚记录点
 *  5. RELEASE SAVEPOINT 删除回滚记录点
 *  6. ROLLBACK TO 将事务回滚到标记点
 *  最终事务的状态要么 COMMIT 要么 ROLLBACK TO
 *  事务控制命令仅能与 DML 类别的 SQL 命令一起使用，不能在创建或删除表时使用，这些操作在数据库中是自动提交的
 */

/** 临时表 在会话期间创建，会话结束后自动被删除，临时表可以和普通表一样执行各种操作
 * MySQL 3.23 及其更高版本才支持临时表，否则使用 Heap Table
 */
CREATE TEMPORARY TABLE t_table_name(column_? datatype_? PRIMARY KEY(column_?));
DROP TABLE t_table_name
/** 克隆表 
 * MySQL 可以使用给 SHOW CREATE TABLE table_name 看该表结构的细节
 */
SHOW CREATE TABLE table_name;
CREATE TABLE other_table_name (...);
INSERT INTO other_table_name (...) SELECT ... FROM table_name;

/** 子查询（嵌套查询） 将一个 SELECT 的结果作为另一个 SQL 语句的数据来源或者判断条件
 */
SELECT column_? FROM table_? WHERE column_? [OPERATOR] (SELECT column_? FROM table_?);
SELECT column_? FROM (SELECT column_? FROM table_?) FROM table_? WHERE condition;

/** AUTO_INCREMENT 自动增长序列，可以指定步长
 * 若指定的值与已有的编号重复，则出现错误信息
 * 若指定的值大于已有的编号，下一个编号就从这个新值开始递增
 */
-- 获取 AUTO_INCREMENT 的值 （另一种方法是使用服务端脚本）
SELECT LAST_INSERT_ID();
-- 对现有序列重新编号：删除带有 AUTO_INCREMENT 的字段，然后再次添加
--从特定值开始增长
CREATE TABLE table_name (id INT UNSIGNED NOT NULL AUTO_INCREMENT=?);
ALTER TABLE table_name AUTO_INCREMENT=?;

/** SQL 注入
 * 通常使用模式匹配，借助正则表达式来校检用户的输入
 */
...






