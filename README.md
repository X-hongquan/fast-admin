# fast-admin

## 目录

[TOC]





## 1.介绍

基于SpringBoot3+vue3+js 快速后台开发框架，聚集企业开发常用知识点。从思路，原理解析

适合人群：想学习全栈开发，Java开发实习生，Java开发应届生，前端实习生，前端应届生。





### 技术选型

部署：Docker，Docker-compose

存储：Mysql，Redis，MinIO

后端：SpringBoot3，MybatisPlus，SpringMVC，JDK21

协议：http，Websocket(待使用)

前端：Vue3，Pinia，Vue-Router，Vite，ElementPlus, Axios, scss，JavaScript



### 优点

- 全部采用新技术栈，代码简易封装，容易学习
- **自定义实现了http定时任务调度，支持CRON表达式，和Fixed-Dleay**
- 提供在线redis网页版，定时刷新，减少切屏，加速开发
- **实际开发中，有太多DTO，VO，Form，或者在表实体上添加@TableField（exisit=false），所以提供了包扫描的类型字段，让前端可以有提示**
- **在设计接口阶段，接口的类型已经被定义好了，所以这部分代码不应该重复写，应该在发起请求层转换参数**
- **区分了菜单，和功能接口权限，权限控制颗粒度更细**
- **动态SQL，AOP的使用**



## 2.快速启动

1. Linux虚拟机安装docker，docker-compose
2. 配置 相对应的配置文件路径，my.cnf,redis.conf配置文件，放在docker目录下
3. docker-compose up
4. mysql，导入sql文件，minio可以拆入图片
5. 启动项目



## 3.存储层

## 3.1Mysql

```sql
select u.* from user as u left join user_role as ur
    on u.id = ur.user_id
           where u.status=1 group by u.id having count(*)=3
order by u.id asc limit 0,10
```

查询有3个角色以上的用户并根据用户id升序排序，并从第一位开始，取10位

### 1.执行顺序

1. form user as u
2. left join .. on 
3. where ...
4. group by u.id having count(u.id)>3
5. select u.*
6. order by u.sort asc
7. limit 0,10               -->limit (index,length) 索引，数量



### 2.数据类型

| 分类   | 类型          | 大小（bytes）          | 描述                     |
| ------ | ------------- | ---------------------- | ------------------------ |
| 数值型 | tinyint       | 1（-128,127）（0,255） |                          |
|        | smallint      | 2                      |                          |
|        | mediumint     | 3                      |                          |
|        | int           | 4                      |                          |
|        | bigint        | 8                      |                          |
|        | float         | 4                      |                          |
|        | double        | 8                      |                          |
|        | Decimal（M,N) | M位数据，N位小数       | 用于需要精度小数类型计算 |



| 分类   | 类型       | 大小(bytes)     | 描述         |
| ------ | ---------- | --------------- | ------------ |
| 字符串 | char（n）  | 0-255           | 定长字符串   |
|        | varchar(n) | 0-65535         | 变长字符串   |
|        | tinyblob   | 0-255           | 二进制数据   |
|        | tinytext   | 0-255           | 短文本字符串 |
|        | blob       | 0-65535         | 二进制数据   |
|        | text       | 0-65535         | 长文本       |
|        | mediumblob | 0-16777215      |              |
|        | mediumtext |                 |              |
|        | longblog   | 0-4 294 967 295 |              |
|        | long-text  | 0               |              |



| 分类 | 类型      | 大小 | 范围                                       | 格式                |
| ---- | --------- | ---- | ------------------------------------------ | ------------------- |
| 日期 | date      | 3    | 1000-01-01 至9999-12-31                    | YYYY-MM-DD          |
|      | time      | 3    |                                            | HH:MM:SS            |
|      | year      | 1    | 1901 ~ 2155                                | YYYY                |
|      | datetime  | 8    | 1000-01-01 00:00:00 至 9999-12-31 23:59:59 | YYYY-MM-DD HH:MM:SS |
|      | timestamp | 4    | 1970-01-01 00:00:01 至 2038-01-19 03:14:07 | YYYY-MM-DD HH:MM:SS |



### 3.条件判断

=

!=

```shell
>=  <=           // and j.max_salary <![CDATA[<=]]> #{maxSalary}    <号xml使用不了，需要使用CDATA
```

in(x,y,z)  

not in ()  not like  not between

between   x and y     包括边界

判断null         is  null   is  not null



### 4.误区和重点

- **and 优先级比or高**

  - x  y  z 为condition条件表达式

  - where x  or  y  and  z          =>      (y and z )  or x       

  - 也就是只要x成功或者 y and z 成功就可以执行

- **判断null     is  null   is  not null**
- **
- **limit  0 ,10      0是索引**
- **left join 不能过滤掉左表数据**



### 5. 常用函数

ifnull(column,result)        column ==null ？result:colum

if(expr,result1,result2)     expr? result1 :result2

**字符串函数**

```sql
/**
  拼接字符串
 */
select concat('a','b','c');
/**
  截取字符串 第一个参数是从1开始,第二个参数取得是长度，跟java不太相同
 */
select substring('abcd',1,2);
/**
  转小写
 */
select lower('A');
/**
  转大写
 */
select upper('a')
```

**日期函数**

检查时区

show variables like '%time_zone%';

如果时间不对，设置配置文件

[mysqld]

default-time-zone=Asia/Shanghai

重新启动

```sql
/**
  获取当前datetime对象
 */
select now();
/**
  计算天数差距,前面一个减去后面一个
 */
select datediff('2022-12-01 10:00:00', '2022-12-03 23:00:00');
/**
  日期添加时间,返回新日期     INTERVAL 1 day|month|year
 */
select date_add(now(),INTERVAL 1 day );
/**
  日期减少时间
 */
select date_sub(now(),INTERVAL 1 day);
/**
  计算年/月/天差距，period_diff(2012, 2012);period_diff(201201, 201205);前面一个参数减去后面一个参数
 */
SELECT period_diff(201201, 201205);
/**
  获取当前日期给定的年数
 */
select year(20190203);
/**
  获取当前日期给定的月数
 */
select month(20190812);
/**
  返回当前日期,只包括年月日
 */
select current_date();
/**
  只有时分秒
 */
select current_time;
/**
  日期格式化字符串
 */
select date_format(now(), '%Y-%m-%d %H:%i:%s');
/**
  字符串转日期
 */
select str_to_date('2024-8-20 12:00:00', '%Y-%m-%d %H:%i:%s');
```

格式化  = > 将日期对象转成字符串形式

- `%Y`：四位数的年份

- `%m`：两位数的月份（01-12）

- `%d`：两位数的日期（01-31）

- `%H`：两位数的小时（00-23）

- `%i`：两位数的分钟（00-59）

- `%s`：两位数的秒钟（00-59）

- `%W`：英文星期几（Sunday-Saturday）

- `%w`：数字表示的星期几（0-6）

- `%M`：英文月份（January-December）

- `%b`：英文缩写月份（Jan-Dec）

- `%p`：AM 或 PM

  

**聚合函数**

经常配合分组函数使用

count(*) 优先使用 ,有优化，count(1) ,count(column)     统计不为空的字段累加1

max(column)    

min(column)

avg(column)



### 6.group  by

![group.drawio](.\images\group.drawio.png)



### 7. join，left join



```sql
//基本不用
select  * from user as u join user_role as ur;

//不满足的连接条件，直接抛弃
select  * from user as u join user_role as ur on u.id = ur.user_id;

//经常使用,左表不管是否符合连接条件，都会保留
select  * from user as u left join user_role as ur on u.id = ur.user_id;
```





**总结如果是left join 的话on 条件不能过滤掉左表数据，需要使用where，join 用on 或 where都行**





### 8.sql优化

IO通常说的是网络IO，和磁盘IO

原理：**减少IO阻塞，减少时间复杂度**

**插入**

主键递增        =>因为所有数据都在聚集索引的叶子节点下，减少页分列，页合并

批量插入        => 减少网络IO和磁盘IO

**查询**

1. 建立索引
2. 走覆盖索引（通常创建联合索引）
3. join表时范围条件放前  如 on  u.id=1 and u.id=ur.user_id     =>减少连接临时表数据数量
4. where 条件 走索引
5. order by 走索引

**limit优化**

大数据量优化

原理 =>  减少数据传输，排序缓冲区默认大小256kb，如果数据量 过大就要流式查询，多IO，

```sql
select * from user limit 2000000,10;
select * from user where id in (select id from user limit 2000000,10);
```

**更新**

```sql
update user set avatar='da' where id=1;
```

where之后的字段一定要用有索引条件，否则会造成表锁，影响效率

**删除**

```sql
delete from user where id=1;
```

where之后的字段一定要用有索引条件，否则会造成表锁，影响效率

//todo

## 3.2 Redis

key-value内存数据库

//todo



## 3.3 MinIO

分布式对象存储服务

//todo



# 4.后端功能模块



## 4.1自定义功能注解

用SpringAOP切入拥有注解的层面，通过反射获取注解信息来达到某种目的，不需要侵入原有代码

目标类有实现接口->JDK动态代理

目标类没实现接口->CGLIB代理  

原理：**生成含有目标的代理对象**

//todo



相同目标方法上同时存在多个切面时，切面的优先级控制切面的**内外嵌套**顺序。

- 优先级高的切面：外面
- 优先级低的切面：里面

使用@Order注解可以控制切面的优先级：

- @Order(较小的数)：优先级高
- @Order(较大的数)：优先级低

使用目前流行的是切注解，不需要去记切点表达式，下面例子都是切入含有Log注解的方法

```java
 //在目标类方法执行之前
@Before(value = "@annotation(controllerLog)")
 public void boBefore(JoinPoint joinPoint, Log controllerLog) {
        TIME_THREADLOCAL.set(System.currentTimeMillis());
 }

//在返回执行之后，可以获取到返回结果
@AfterReturning(pointcut = "@annotation(controllerLog)", returning = "jsonResult")
public void doAfterReturning(JoinPoint joinPoint, Log controllerLog, Object jsonResult) {
    handleLog(joinPoint, controllerLog, null, jsonResult);
}
//抛出异常执行，可以获取到异常e对象
@AfterThrowing(value = "@annotation(controllerLog)", throwing = "e")
public void doAfterThrowing(JoinPoint joinPoint, Log controllerLog, Exception e) {
    handleLog(joinPoint, controllerLog, e, null);
}

//可以自由控制目标方法执行
@Around(value = "@annotation(controllerLog)")
public Object aroundMethod(ProceedingJoinPoint joinPoint){
    String methodName = joinPoint.getSignature().getName();
    String args = Arrays.toString(joinPoint.getArgs());
    Object result = null;
    try {
        System.out.println("环绕通知-->目标对象方法执行之前");
        //目标方法的执行，目标方法的返回值一定要返回给外界调用者
        result = joinPoint.proceed();
        System.out.println("环绕通知-->目标对象方法返回值之后");
    } catch (Throwable throwable) {
        throwable.printStackTrace();
        System.out.println("环绕通知-->目标对象方法出现异常时");
    } finally {
        System.out.println("环绕通知-->目标对象方法执行完毕");
    }
    return result;
}
```

#### @RepeatSubmit

防止重复提交

范围：方法

原理：**使用redis存储以接口路径+个人token作为key，设置ttl，参数为value，在ttl期间如果重复提交一样的参数，视为重复提交**

范例：

```java
 @RepeatSubmit
 public R<Integer> add(@RequestBody User user) {
```

#### @DataScope

数据过滤，除了系统管理员，不同角色拥有的数据权限不应该是一致的

范围：方法

原理：**利用mybatis-xml中，拼接sql过滤掉数据**

范例：

```java
    @DataScope(alias = "r", value = "id")
    public List<Role> getList(Role role) {
        return baseMapper.getList(role);
    }
```

#### @PreAuth

权限校验

范围：方法

原理 ：**检查ThreadLocal当前用户是否拥有该权限**

范例：

```
@PreAuth("system:user:query")
public TableInfo<List<User>> list(User user) {
    PageUtils.startPage();
    List<User> list = userService.getList(user);
    return TableInfo.ok(list);
}
```

#### @Log

打印日志

范围：方法，

原理： **SpringAOP+异步线程记录日志**

范例

```java
@Log(title = "新增用户", businessType = BusinessType.INSERT, excludeParamNames = {"password"})
public R<Integer> add(@RequestBody User user) {
    int row = userService.add(user);
    return R.ok(row);
}
```

#### @Job

在JobTemplate下标识定时任务，与数据库JobName一致

范围：方法，

原理： **原理，Trigger组件初始化时会使用反射获取到方法上拥有Job的注解放入Map集合中，启动定时任务的时候获取引用**

范例：

```java
public class JobTemplate {
    
    @Job("print")
    public void print() {
        System.out.println("我打印一");
    }

    @Job("print2")
    public void print2() {
        System.out.println("我打印二");
    }
}
```

## 4.2 文件上传下载

### 上传

http报文

```http
POST /upload HTTP/1.1
Host: example.com
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Length: 2471 //请求体内容大小

------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="file"; filename="api.zip"
Content-Type: application/octet-stream
Content-Length: 2258 //文件内容大小

The contents of the file go here.
------WebKitFormBoundary7MA4YWxkTrZu0gW--
```

前端

```html
<input type="file" accept="image/*" id="files" multiple>
<button onclick="upload()"></button>
<script>
    const file = document.getElementById('file')
    let files
    file.addEventListener('change', (e) => {
        files = e.target.files
    })
    function upload() {
        const formData = new FormData()
        for (let i = 0; i < files.length; i++) {
            formData.append('files', files[i])
        }
        //或者替换成axios
        fetch('/upload', {
            method: 'POST',
            body: formData
        }).then(res => res.json()).then(res => {
            console.log(res)
             files=undefined
        })
       
   }
</script>
```



后端

设置单个请求最大文件大小，和请求内容最大总字节数

```yaml
spring:
  servlet:
    multipart:
      max-file-size: 10MB
      max-request-size: 50MB
```



```java
//接收
public R upload(MultipartFile[] files)  {
      //获取到二进制流，和文件信息，可以存在本地，或者云储存
}
```



### 下载

后端

```java
 //压缩包形式返回
@GetMapping("/api/{mode}")
  public void generateAPI(@PathVariable("mode") String mode, HttpServletResponse response) throws IOException {
        Builder builder = new Builder();
        List<FileObj> fileObjs = new ArrayList<>();
        builder.builderAPI(mode, fileObjs);
        ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
        for (FileObj fileObj : fileObjs) {
            String fileName = fileObj.getFileName();
            ZipEntry zipEntry = new ZipEntry(fileName);
            zos.putNextEntry(zipEntry);
            zos.write(fileObj.getBytes());
            zos.closeEntry();
        }
        zos.close();
    }

```

前端接收

```js
//axios.js 小文件下载因为会将内容保存
export function generateAPIGeneratorAPI(mode) {
    return request({
        url: `/generate/api/{mode}`,
        method: 'get',
        params: mode,
        responseType: 'blob' //重点
    })

      
  data = await generateTypeJSGeneratorAPI('ts')
  const htmlAnchorElement = document.createElement('a');
  let objectURL = URL.createObjectURL(data);
  htmlAnchorElement.href = objectURL;
  htmlAnchorElement.download = 'xxx.zip' //文件名称
  htmlAnchorElement.click()
```





### 导入导出

excel导入或者导出

```xml
<dependency>
     <groupId>com.alibaba</groupId>
     <artifactId>easyexcel</artifactId>
     <version>3.3.3</version>
</dependency>
```

```java
  //导出
public void export(HttpServletResponse response) throws IOException {
        EasyExcel.write(response.getOutputStream(), User.class).sheet("模板").doWrite(userService.list());
   }

//导入
 public R upload(MultipartFile file) throws IOException {
     List<User> list = new ArrayList<>();
        try {
            //将数据读取到list里面
            EasyExcel.read(file.getInputStream(), User.class, new DataListener(list)).sheet().doRead();
        } catch (RuntimeException e) {
            throw new ServerException("业务异常");
        }
        System.out.println(list);
       return R.ok();
  }
```



## 4.3 自定义文件生成

思路：-> 反射获取当前类字节码文件路径，从源码根目录开始递归遍历，过滤目录为domain，vo，dto，form，pojo，

得到目录下的字节码对象，通class对象获取到定义的元信息（字段，方法，继承，接口，泛型），可以过滤方法名，字段名等



获取Ts的需要解决泛型（字段泛型，方法泛型，参数泛型）

**不是很推荐使用ts**

//todo

## 4.4 认证鉴权

原理：**redis+jwt+拦截器**

//todo



## 4.5 任务调度模块

```java
public class JobTemplate {

    @Job("print")
    public void print() {
        System.out.println("我打印一");
    }

    @Job("print2")
    public void print2() {
        System.out.println("我打印二");
    }
}
```

//todo



## 4.7 Restful风格

一般较为规范都是采用这种,

**get请求和 delete请求也可以将参数放请求体**，不过一般来说很少会这么使用



```java
    @GetMapping("/list")
    public TableInfo<List<Role>> list(Role role) {

    }

    @GetMapping("/{id}")
    public R get(@PathVariable("id") Long id) {
    }

    @PostMapping
    public R add(@RequestBody Role role) {

    }

    @PutMapping
    public R edit(@RequestBody Role role) {

    }

 // 参数的ids='1,2,3'这种类型
    @DeleteMapping("/{ids}")         
    public R<Integer> delete(@PathVariable Long[] ids) {
   
   }

```



## 4.8 分页

我们一般不会采用MybatisPlus的分页插件，过于繁琐，一般采用pageHelper。

```xml
        <dependency>
            <groupId>com.github.pagehelper</groupId>
            <artifactId>pagehelper-spring-boot-starter</artifactId>
            <version>2.1.0</version>
        </dependency>
```

```java
 
public static void startPage() {
      HttpServletRequest request = WebUtils.getRequest();
        PageObject pO = new PageObject();
        if (StringUtils.isNotBlank(request.getParameter("pageNum"))) {
            pO.setPageNum(Integer.valueOf(request.getParameter("pageNum")));
        }
        if (StringUtils.isNotBlank(request.getParameter("pageSize"))) {
            pO.setPageSize(Integer.valueOf(request.getParameter("pageSize")));
        }
        pO.setCondition(request.getParameter("column"));
        pO.setCondition(request.getParameter("condition"));

        PageHelper.startPage(pO.getPageNum(), pO.getPageSize(), pO.getOrderBy());
    }

 @GetMapping("/list")
 @PreAuth("system:role:query")
 public TableInfo<List<Role>> list(Role role) {
        PageUtils.startPage();
        List<Role> list = roleService.getList(role);
        return TableInfo.ok(list);
  }
```

//todo

## 4.9 异常处理

捕捉Controller层的异常，

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ServiceException.class)
    public R<String> exceptionHandler(ServiceException e) {
        return R.fail(e.getCode(), e.getMsg());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public R handleArgumentNotValid(MethodArgumentNotValidException e) {
        return R.fail(e.getBindingResult().getFieldError().getDefaultMessage());
    }

    @ExceptionHandler(AuthException.class)
    public void exceptionHandler(AuthException e, HttpServletResponse response) {
        e.printStackTrace();
        response.setStatus(403);
    }
}
```

//todo

## 4.10 参数普通校验

引入依赖

```xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
```

使用注解

```java
@Data
public class LoginForm {
    @NotBlank
    @Length(min = 6,max = 20,message = "用户名长度必须在6-20之间")
    private String username;

    @Length(min = 6,max = 20,message = "密码长度必须在6-20之间")
    private String password;
}
```

校验失败处理

```java
@ExceptionHandler(MethodArgumentNotValidException.class)
public R handleArgumentNotValid(MethodArgumentNotValidException e) {
    return R.fail(e.getBindingResult().getFieldError().getDefaultMessage());
}
```

//todo



## 4.11邮件发送

//todo



## 4.12 WebSocket

//todo



## 4.13 非依赖注入获取Bean

//todo



## 4.14 JSON 

```yaml
spring:
  jackson:
    date-format: yyyy-MM-dd HH:mm:ss
    time-zone: GMT+8
```

JackSon配置

```java
package com.chq.app.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.TimeZone;

@Configuration
public class JacksonConfig {

    @Value("${spring.jackson.time-zone}")
    private String timeZone;

    @Value("${spring.jackson.date-format}")
    private String datePattern;


    /**
     * 前端处理long类型会由精度丢失问题,所以将long类型序列化成
     * @param builder
     * @return
     */
    @Bean
    public ObjectMapper jacksonObjectMapper(Jackson2ObjectMapperBuilder builder) {
        ObjectMapper objectMapper = builder.createXmlMapper(false).build();
        SimpleModule module = new SimpleModule();
        module.addSerializer(Long.class, ToStringSerializer.instance);
        module.addSerializer(Long.TYPE, ToStringSerializer.instance);
        objectMapper.registerModule(module);
        return objectMapper;
    }

    /**
     * 处理日期类型的序列化和反序列化
     * @return
     */
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer customizeLocalDateTimeFormat() {
        return jacksonObjectMapperBuilder -> {
            jacksonObjectMapperBuilder.timeZone(timeZone);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(datePattern);
            LocalDateTimeDeserializer deserializer = new LocalDateTimeDeserializer(formatter);
            LocalDateTimeSerializer serializer = new LocalDateTimeSerializer(formatter);
            jacksonObjectMapperBuilder.serializerByType(LocalDateTime.class, serializer);
            jacksonObjectMapperBuilder.deserializerByType(LocalDateTime.class, deserializer);
        };
    }
}
```



//todo



## 4.15 多线程

//todo

## 4.16 流

//todo

## 4.17 注解

//todo



## 4.18 实体类

一般来说需要校验表单使用Form，返回字段需要扩展用Vo， pojo对应数据库表实体，也可以使用TableField（exist=false）来使用

其他情况都可以使用DTO

1. **DTO (Data Transfer Object)**:
   - 用途：DTO是一种设计模式，用于在不同层之间传输数据，尤其是在表现层和应用层之间。
   - 特点：DTO通常包含类的 getter/setter 方法，没有业务逻辑，且它的目的是减少网络交互次数。
   - 命名：通常以`Dto`或`DTO`结尾，例如`UserDto`或`OrderDTO`。
2. **VO (Value Object)**:
   - 用途：VO用于封装数据，通常用于表示UI组件的数据模型。
   - 特点：VO通常是无状态的，不可变的，且通常不包含任何业务逻辑。
   - 命名：通常以`Vo`或`VO`结尾，例如`CustomerVo`或`ProductVO`。
3. **Form**:
   - 用途：Form通常用于表示客户端提交的数据，与HTML表单紧密相关。
   - 特点：Form对象通常包含表单字段以及验证逻辑。
   - 命名：通常以`Form`结尾，例如`RegistrationForm`或`SearchForm`。
4. **POJO (Plain Old Java Object)**:
   - 用途：POJO是一种简单的Java对象，它不遵循任何特定的Java对象模型、框架或约定。
   - 特点：POJO可以有属性、getter/setter 方法，但不包含业务逻辑。
   - 命名：POJO没有特定的命名约定，它们通常直接反映它们所代表的领域概念，例如`Person`或

## 4.19 规范

一般查询使用xml形式写sql，因为需要做数据权限过滤处理，增，删，改是单表用的是MybatisPlus封装的方法



## 4.20 MybatisPlus

//todo

# 5.前端模块

## 页面展示

![image-20240823211322362](.\images\image-20240823211322362.png)

## 菜单

- 系统管理
  - 用户管理
  - 角色管理
  - 日志管理
  - 菜单管理
  - 文档生成
  - 权限管理
  - 缓存管理
  - 任务调度
    - 任务日志
    - 任务调度
- 接口文档

## 表单校验

//todo

element 表单验证

```js

//校验函数
export function checkUserName(rule, value, callback) {
    if (value.length < 5) {
        callback(new Error('用户名长度不能小于4'))
    } else {
        callback()
    }
}

export function checkPassword(rule, value, callback) {
    if (value.length < 6 || value.length > 20) {
        callback(new Error('密码长度不能小于6或大于20'))
    } else {
        callback()
    }
}

表单规则
const rules = reactive({
  username: [
    {validator: checkUserName, trigger: 'change'},
  ],
  password: [
    {validator: checkPassword, trigger: 'change'},
  ],
})

<el-form class="login-form" :model="loginForm" :rules="rules" ref="loginComponent">
  <h1>登录</h1>
  <h2>{{setting.logoTitle}}</h2>
  <el-form-item prop="username">
    <el-input prefix-icon="user" class="input-height" type="text" placeholder="请输入用户名"
              v-model="loginForm.username"></el-input>
  </el-form-item>
  <el-form-item prop="password">
    <el-input prefix-icon="lock" class="input-height" type="password" placeholder="请输入密码"
              v-model="loginForm.password" show-password></el-input>
  </el-form-item>
  <el-form-item>
    <el-button :loading="loading" class="login-btn input-box" type="primary" @click="login">登录
    </el-button>
  </el-form-item>
</el-form>


async function login() {
  const box = loginComponent.value
  await box.validate()
  //todo 校验之后的逻辑
}
```

## scss

//todo



## 路由

//todo

## axios

//todo

## 组件通信

//todo

## 插槽

//todo

## 递归

//todo

## 
