-- SQL 语法学习
/** SQL 是关系型数据库的标准语言（如 MySQL、Oracle、SQL Server、MS Access、DB2 等）
 * 功能：
 *  1. 创建或删除数据库
 *  2. 创建、修改或删除数据表
 *  3. 向表中插入数据，或从表中删除数据
 *  4. 根据条件从表中查询数据
 *  5. 在数据库中创建视图、存储过程
 *  6. 设置用户对数据库的使用权限
 *  7. 定义函数和触发器
 *
 *
 * 注意事项：
 *  SQL Server 使用 T-SQL，Oracle 使用 PL/SQL，MS Access 使用 JET SQL
 */

/** RDBMS（Relational Database Management System）：关系数据库管理系统
 * 相关概念：
 *  Table 数据库对象，每一行都是一条数据，每一列都是数据的一个属性，整个表就是若干条相关数据的集合
 *  Field 列的标签
 *  Column 列
 *  Record 数据行
 *  NULL 空值
 * SQL约束 表的数据列必须强行遵守的规则
 *  约束可以是列级别，也可以是表级别；列级约束仅作用于某一列，而表级约束则作用于整张表
 *  创建数据表后，可以使用 ALTER TABLE 语句来增加约束规则，带有 DROP CONSTRAINT 选项的 ALTER TABLE 语句来删除已经定义的约束
 *  Oracle 可以使用 DROP PRIMARY KEY 关键字删除主键约束，有些数据库允许暂时禁用约束
 *      NOT NULL 非空约束
 *      DEFAULT 默认约束
 *      UNIQUE 唯一约束
 *      PRIMARY KEY 主键 用来唯一标识数据表中的每一行/记录
 *      FOREIGN KEY 外键 用于将两个表连接在一起，让两个表的数据保持同步
 *      CHECK 检查性约束 用于限定列的取值范围
 *      INDEX 索引 用于快速从数据库中检索或者获取数据
 * 数据的完整性
 *      实体完整性 表中的每条记录代表一个实体，不能重复
 *      域完整性 域就是字段，保证字段的取值合理
 *      引用完整性 如果某条记录被另外一个表中的字段引用，那么该记录不能被删除
 *      自定义完整性 不同版本的 RDBMS 在实现时，还可以根据其具体的应用环境，自己制定一些其它的完整性约束
 *
 *
 * 数据库范式
 *  ？
 */

/** SQL 执行过程
 * 当在任何一款 RDBMS 中执行 SQL 命令时，系统首先确定执行请求的最佳方式。然后 SQL 引擎将会翻译 SQL 语句，并处理请求任务
 *  SQL 命令 -> SQL 语言处理器（语法解析器+优化器） -> DBMS 引擎（文件管理器+事务管理器） -> 物理数据库
 */

/** SQL 命令
 * 1. DDL（Data Definition Language）数据定义语言
 *  CREATE 创建
 *  ALTER 修改
 *  DROP 删除
 * 2. DML（Data Manipulation Language）数据处理语言
 *  SELECT 查
 *  INSERT 增
 *  UPDATE 改
 *  DELETE 删
 * 3. DCL（Data Control Language）数据控制语言
 *  GRANT 分配权限
 *  REVOKE 收回权限
 */

/** 数据类型
 * 1. 字符串类型
 *  CHAR(size) 长度为 size (0 ~ 255，默认为 1) 个字符的字符串
 *  VARCHAR（size） 可变长度的 size（0 ~ 65535）个字符的字符串
 *  TINYTEXT 最大长度为 255 (2^8-1) 的字符串文本
 *  TEXT(size) 最大长度为 65535 (2^16-1) 的字符串文本，即 64 KB
 *  MEDIUMTEXT 最大长度为 16777215 (2^24-1) 的字符串文本，即 16 MB
 *  LONGTEXT 最大长度为 4294967295 (2^32-1) 的字符串文本，即 4 GB
 *  ENUM(val1,val2,val3,...) 字符串枚举类型，最大包括 65535 个枚举值
 *  SET(val1,val2,val3,...) 字符串集合类型，最多 64 个值。若不包括输入，则代替为空值
 * 2. 整数类型 (超小/小/中等/ /大/[BOOL])
 *  TINYINT 字节大小为 1 (-128, 127)
 *  SMAILLINT 字节大小为 2
 *  MEDIUMINT 字节大小为 3
 *  INT/INTEGER 字节大小为 4
 *  BIGINT 字节大小为 8
 *  BOOL MySQL 并不真正支持 BOOL 类型，其为 TINYINT(1) 的别名
 * 3. 小数类型 (浮点数（近似值）+ 定点数（精确值）)
 *  FLOAT(size, d) 单精度浮点数类型，4 字节大小。size 表示数字总个数，d 表示小数部分的数字个数
 *  FLOAT(p) 单精度浮点数类型。p 决定是 FLOAT (0 <= p <=24) 还是 DOUBLE (25 <= p <= 53) 类型
 *  DOUBLE(size, d) 双精度浮点数类型。size 表示数字总个数，d 表示小数部分的数字个数
 *  DECIMAL(size, d)/DEC(size, d) 定点数类型。size 最大取值为 65，默认值为 10；d 的最大取值为 30，默认值为 0
 * 4. 日期时间类型
 *  DATE 日期类型，格式为 YYYY-MM-DD，取值范围是 1000-01-01 ~ 9999-12-31
 *  DATETIME(fsp) 日期和时间类型，格式为 YYYY-MM-DD hh:mm:ss，取值范围是 1000-01-01 00:00:00 ~ 9999-12-31 23:59:59
 *  TIMESTAMP(fsp) 时间戳类型，从 Unix 纪元（'1970-01-01 00:00:00' UTC）到现在的秒数
 *  TIME(fsp) 时间类型，格式为 hh:mm:ss，取值范围为 -838:59:59 ~ 838:59:59
 *  YEAR 四位数字的年份格式 1901 ~ 2155，还有一个特殊取值 0000
 * 5. 二进制类型
 *  BIT(size) size 表示位数，取值为 1 ~ 64，默认为 1
 *  BINARY(size) 除了存储的是二进制形式的字符串，其余等价于 CHAR()
 *  VARBINARY(size) 除了存储的是二进制形式的字符串，等价于VARCHAR()类型
 *  TINYBLOB 存储较小的二进制数据，可以容纳 2^8-1 个字节
 *  BLOB 存储二进制数据，可以容纳 2^16-1 个字节，即 64 KB
 *  MEDIUMBLOB 存储中等的二进制数据，可以容纳 2^24-1 个字节，即 16 MB
 *  LONGBLOB 存储较大的二进制数据，可以容纳 2^32-1 个字节，即 4 GB
 *
 *
 * SQL NULL 空值
 */

-- 创建一个数据库
CREATE DATABASE database_name;
-- 删除数据库
DROP DATABASE database_name;
-- 查看数据库
SHOW database_name; 
-- 使用数据库
USE database_name;

-- 创建一个表
CREATE TABLE table_name (
    column_? datatype_?,
    PRIMARY KEY(some columns)
)
CREATE TABLE website (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    url VARCHAR(30) DEFAULT '',
    age TINYINT UNSIGNED NOT NULL,
    alexa INT UNSIGNED NOT NULL,
    uv FLOAT DEFAULT '0',
    country CHAR(3) NOT NULL DEFAULT '',
    PRIMARY KEY('id')
);
-- 删除一个表
DROP TABLE table_name;
-- 查看一个表
DESC table_name;
-- 重命名一个表
ALTER TABLE old_table_name RENAME TO new_table_name;
RENAME old_table_name TO new_table_name;

-- 向一个表中插入数据
INSERT INTO table_name (column_?) VALUES (value_?);
INSERT INTO table_name VALUES (value_?) -- 为所有列插入数据
-- 使用另一个表的数据填充一个表
INSERT INTO table_name [(column_?)] SELECT column_? FROM other_table_name [WHERE condition];
-- 选取数据（WHERE）
SELECT column_? / * FROM table_name WHERE condition;
-- 修改数据（WHERE）
UPDATE table_name SET column_?=value_? WHERE condition;
-- 删除数据（WHERE）
DELETE FROM table_name WHERE condition;

-- WHERE condition
-- 条件中的运算符
SELECT * FROM table_name WHERE [condition1] AND [condition2] OR [condition3];
/** 条件中的模糊匹配
 * 百分号 % 代表零个、一个或者多个任意的字符
 * 下划线 _ 代表单个字符或者数字
 * [charlist] 字符列表中的任意单一字符，可以使用连字符(-)根据 ASCII 编码指定一个字符范围 
 * [^charlist] 不在字符列表中的任意单一字符
 */
SELECT * FROM table_name WHERE LIKE '[a-zA-Z0-9]'
-- GROUP BY column_?
SELECT * FROM table_name [WHERE condition] [GROUP BY column_?]
-- ORDER BY column_? [ASC/DESC] 默认 ASC 升序
SELECT * FROM table_name [WHERE condition] [GROUP BY column_?] [ORDER BY column_?] [ASC/DESC]
-- 借助 SQL 聚合函数，可以对分组的数据进行再次加工 SUM() COUNT() AVG()

-- SELECT 语句中的 DISTINCT 删除重复记录
SELECT DISTINCT column_? FROM table_name WHERE [condition];

/**限制返回数据的条数
 * 注意并不是所有的数据库都支持 TOP 子句
 *  MySQL 使用 LIMIT 子句获取指定数量的记录
 *  Oracle 使用 ROWNUM 子句获取指定数量的记录
 *  SQL Server 支持 TOP 子句
 */
SELECT TOP number / column_? FROM table_name WHERE condition;

-- 向已经创建的表中的字段添加或删除约束
ALTER TABLE table_name MODIFY column_1 type NOT NULL;
ALTER TABLE table_name MODIFY column_1 type DEFAULT default_value;
ALTER TABLE table_name ALTER COLUMN column_1 DROP DEFAULT;
ALTER TABLE table_name ADD CONSTRAINT myUniqueConstraint UNIQUE(column_?);
-- MySQL
ALTER TABLE table_name DROP INDEX myUniqueConstraint;
/** 主键 用于唯一标识表中的每一行记录 （当主键包含多个字段时，又称为复合键）
 * SQL 规定主键长度不能超过 900 个字节，Oracle 规定为 32 个字段
 */
ALTER TABLE table_name ADD CONSTRAINT PK_CUSTID PRIMARY KEY (column_?);
ALTER TABLE table_name DROP PRIMARY KEY;
/** 外键 将两个表连接在一起，让两个表的数据保持同步
 * 外键由表中的一个字段或多个字段构成
 * 从表的外键指向主表的主键，从表的数据受到主表的约束，向从表中插入或者更新数据时，外键的值必须存在于主表的主键中
 */
ALTER TABLE table_name ADD FOREIGN KEY (column) REFERENCES main_table_name (column);
ALTER TABLE table_name DROP FOREIGN KEY;
-- CHECK 约束
ALTER TABLE table_name MODIFY column type NOT NULL CHECK(column condition);
ALTER TABLE table_name ADD CONSTRAINT myCheck CHECK(column_? condition_?);
ALTER TABLE table_name DROP CONSTRAINT myCheck;
/** 索引
 * 仅在被频繁检索的字段上创建索引
 * 针对大数据量的表创建索引
 * 通常来说，经常查询的记录数目少于表中总记录数据的 15% 时，可以创建索引
 * 尽量不要在有大量重复值得字段上建立索引
 */
CREATE INDEX index_name ON table_name (column_?);
ALTER TABLE table_name DROP INDEX myIndex;
