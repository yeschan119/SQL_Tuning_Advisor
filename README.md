# SQL_Tuning_Advisor
SQL Tuning Advisor Design Project(Tuning Advisor 설계 프로젝트)

# Purpose
SQL Tuning Advisor Package를 개발하여 SQL Tunning 지원
Develop SQL_Tuning_Advisor package & Functions to use this for SQL tuning.

# 👨‍👩‍👧‍👦 Members
정민우(Researcher)
강응찬(Researcher)

# Tech Stack
+ RDBMS
+ PL/SQL
+ C language
+ shell script

# Milesstone
SQL Tuning Advisor기능 레벨은 Limited Scope와 Comprehensive로
일단 Limited Scope 개발 완료가 목표.
## 자료 조사 및 기본 인터페이스 설계, 구현
### week.1 : SQL Tuning Advisor관련 자료조사(Oracle Tuning Advisor 참조)
### week.2 : SQL Tuning Advisor 조사(pkg, procedure, function 들에 대해 reverge engineering)
### week.3 : system table, tuning package spec(pkg_dbms_sqltune.sql) 구현
## tuning advisor package body 구현
### week.4 : tuning package body(pkg_dbms_sqltune_internal.sql) 구현
### week.5 : tuning package body(pkg_dbms_sqltune_internal.sql) 구현
## tuning advisor package unility 구현(C언어로 구현)
### week.6 : Structure Analysis 구현(parsing된 query(parse tree)를 분석하여 tuning)
### week.7 : Structure Analysis 구현(parse tree를 이용)
### week.8 : SQL Tuning Advisor testcase 추가

## LIMITED SCOPE
+ 유저가 Tuning Task를 직접 정의하고 DB가 이 Task들을 관리할 수 있도록 관련 패키지 함수 및 오브젝트 구현하기
+ Tuning task의 SQL이 접근하는 DB 오브젝트 통계 missing 혹은 stale 여부 판별하는 로직 만들기
+ Tuning task의 SQL 수행 시 접근하는 table에 대한 가상 index를 생성하고, 해당 index 적용 시의 benefit 계산하는 로직 만들기
+ Tuning task의 SQL의 구조 및 문법들을 결과값이 바뀌지 않는 선에서 조작할 수 있는 로직을 구현하고, 조작된 각각의 쿼리들로부터 얻을 수 있는 benefit 계산하는 로직 만들기
  + 비용이 많이 드는 Not In operation을 찾고 개선 방안 제안
  + 비용이 많이 드는 UNION set operation을 찾고 개선 방안 제안
  + Index data type mismatch 찾고 개선 방안 제안
  + Cartesian product 형성하는 join predicate 찾고 개선 방안 제안
+ Report Tuning Task 구현
+ Update / Delete / Modify Tuning Task

## COMPREHENSIVE
+ Tuning mode에서 기존보다 더욱 정확한 selectivity를 계산할 수 있도록 동적 샘플링 여러 번 수행하는 로직 만들기
+ Tuning mode에서 기존보다 더욱 정확한 selectivity를 계산할 수 있도록 동적 샘플링 여러 번 수행하는 로직 만들기
+ Tuning mode에서 기존보다 더욱 정확한 selectivity를 계산할 수 있도록 partial execution을 수행하는 로직 만들기
+ Tuning mode에서 past execution history를 바탕으로 optimizer mode setting (e.g. <code>FIRST_ROW, ALL_ROWS</code>)을 개선할 수 있는 로직 만들기
+ Tuning task의 SQL에 대한 alternative plan을 search하고 original plan과의 비용을 비교하는 로직 만들기
+ 유저가 Tuning Mode 실행 결과를 리포트 형식으로 받아볼 수 있도록 로직 구현하기

## 설계(Design:Oracle Tuning Advisor 참조)
### SQL Tuning Advisor 설계
#### Tuning Advisor 관련 패키지 body & specification(spec) 설계
  + PKG_DBMS_SQLTUNE pkg body & spec
    + body : tuning advisor의 기본 기능들(create, execute, report..)을 실행할 수 있는 procedure, function 선언부
    + spec : body에 선언되어 있는 function, procedure 들의 구현부
  + PKG_DBMS_SQLTUNE_INTERNAL pkg body & spec
    + body : Execute Tuning Task 단계에서 진행하는 동작들을 수행하기 위한 함수 선언부
    + spec : body에 선언되어 있는 function, procedure들의 구현부
  + PKG_DBMS_SQLTUNE_UTIL C언어러 구현이 필요한 subprogram들을 별도로 분리한 패키지
#### Tuning Adviosr관련 Table들과 View들 설계
  + Tuning Advisor에 사용되는 System Table을 생성(DB Booting시 생성되는 테이블)
    + Advisor_Defitinions
      + DB에는 각종 Advisor들이 존재하는데 이 Advisor들을 관리하는 테이블 생성
        + ADDM
        + SQL Access Advisor
        + Undo Advisor
        + SQL Tuning Advisor
        + SQL Workload Manager
        + ...
    + Advisor_Tasks
      + 각종 Advisor 수행 단위를 Task라고 하는데, 이 Tasks를 저장하고 관리하는 테이블
    + Advisor_OBject_Types
    + Advisor_Objects
      + 각각의 Task에 따라 부과된 object_id, objec_name을 조합하여 저장하는 테이블
    + Advisor_Logs
      + Tuning과정을 각 단계별 Logging하는 테이블
    + DBA_ADVISOR_DEFINITIONS view 설계
    + DBA_ADVISOR_TASKS view 설계
    + DBA_ADVISOR_OBJECTS view 설계
    + DBA_ADVISOR_EXECUTIONS view 설계
    + DBA_ADVISOR_LOG view 설계
    + ...
#### Create Tuning Task 설계
  + user로부터 입력되는 값들을(ex: sql_id, scope, task_name...)이용해서 tuning task 생성.
  + null값들에 대해 default value 생성
  + input값들에 대해 valid check를 진행
  + input value와 생성되 값들을 system table에 저장.
#### Exectue Tuning Task 설계
  + Statistical Analysis
    + Table, Index에 대한 통계정보의 Missing or Stale 여부를 파악.
  + Access Path Analysis
    + Index 여부에 따른 실행 비용 최적화 여부를 판별하고 이를 제시
    + SQL Access Advisor를 실행할 것을 제안.
  + SQL Structural Analysis(Syntax / Semantic 단계에서 할 수 있는 쿼리 성능 저하 요소 판단 및 개선방안 제안)
    + NOT IN을 NOT EXIST로 대체하라고 제안하거나 UNION을 UNION ALL을 대체할 것을 제안
    + Index Column과 where절에 사용된 column의 datatype mismatch로 인한 비효율을 감지하고 이를 고칠 것을 제안
    + Missing Join Condition을 감지(Design Mistakes)
#### Report Tuning Task 설계
#### Accept Sql Profile 설계
## 구현(Implementation)
### SQL Tuning Advisor 구현
#### Tuning Advisor관련 Table들과 View들 구현
  + sys._advisor_definitions 
  ```
    create table sys._advisor_definitions (
			ADVISOR_ID        NUMBER  NOT NULL,
			ADVISOR_NAME      VARCHAR2(30) NOT NULL,
			PROPERTY          NUMBER   NOT NULL
    );
 ```
+ sys._advisor_tasks
```
create table sys._advisor_tasks (
    ID                      NUMBER NOT NULL,
    NAME                    VARCHAR2(128),
    OWNER_ID                NUMBER NOT NULL,
    OWNER_NAME              VARCHAR2(128),
    ADVISOR_ID              NUMBER NOT NULL,
    DESCRIPTION             VARCHAR2(256),
    CREATED                 DATE NOT NULL,
    LAST_MODIFIED           DATE NOT NULL,
    PARENT_TASK_ID          NUMBER,
    EXEC_START              DATE,
    EXEC_END                DATE,
    STATUS                  NUMBER NOT NULL,
    STATUS_MSG              varchar2(30),
    ERROR_MSG               VARCHAR2(2000),
    HOW_CREATED             VARCHAR2(30)
);
tuning task 정보를 저장하는 테이블
sql_id를 입력받은 후에
create_tuning_task 당시 생성되는 값들(task_id, task_name, owner, created, last_modified..)
execute_tuning_task 당시 생성되는 값들(execute_start, execute_end, status, last_modified..)
status의 경우 create일 때 0, execute일 때 1
```
+ sys._advisor_objects
```
create table sys._advisor_objects (
    OBJ_ID                          NUMBER NOT NULL,
    OBJ_TYPE                        VARCHAR2(64),
    TASK_ID                         NUMBER NOT NULL,
    EXEC_name                       VARCHAR2(128),
    ATTR1                           VARCHAR2(4000),
    ATTR2                           VARCHAR2(4000),
    ATTR3                           VARCHAR2(4000),
    ATTR4                           CLOB,
    ATTR5                           VARCHAR2(4000),
    ATTR6                           RAW(2000),
    ATTR7                           NUMBER,
    ATTR8                           NUMBER,
    ATTR9                           NUMBER,
    ATTR10                          NUMBER,
    OTHER                           CLOB
);
각각의 task에 따라서 부과된 object_id, object_name을 조합하여 저장하는 테이블
ATTR1 : sql_id
ATTR2 : plan_hash_value
ATTR3 : object_owner
ATTR4 : sql_text
```
+ sys._advisor_object_types
```
create table sys._advisor_object_types (
    OBJ_TYPE_ID                   NUMBER,
    OBJ_TYPE                      varchar2(64)
);
```
+ sys._advisor_logs
```
create table sys._advisor_logs (
    OWNER                           VARCHAR2(30),
    TASK_ID                         NUMBER NOT NULL,
    TASK_NAME                       VARCHAR2(30),
    EXECUTION_START                 DATE,
    EXECUTION_END                   DATE,
    STATUS                          VARCHAR2(11),
    STATUS_MESSAGE                  VARCHAR2(4000),
    PCT_COMPLETION_TIME             NUMBER,
    PROGRESS_METRIC                 NUMBER,
    METRIC_UNITS                    VARCHAR2(64),
    ACTIVITY_COUNTER                NUMBER,
    RECOMMENDATION_COUNT            NUMBER,
    ERROR_MESSAGE                   VARCHAR2(4000)
);
tuning advisor 진행과정에 생성되는 중요 요소(task_id, task_name, status, error_message ..)들을 기록하는 테이블
현재 log 테이블을 사용하는 로직은 없음
```
#### Create_Tuning_Task 구현
+ Create_Tuning_Task test
```
-- oracle처럼 sql_id를 찾아서 input값으로 넣어야 할지, 아니면 sql_text를 그대로 넣으면 알아서 sql_id를 찾아 실하도록 해야 할지 고민..

-- 1. Run sql tuning advisor for sql_id=5dkrnbx1z8gcb

GRANT ADVISOR TO USER;
set long 1000000000
Col recommendations for a200

DECLARE
  l_sql_tune_task_id VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
    sql_id => '5dkrnbx1z8gcb',
    scope => DBMS_SQLTUNE.scope_comprehensive,
    time_limit => 500,
    task_name => '5dkrnbx1z8gcb_tuning_task_1',
    description => 'Tuning task for statement 5dkrnbx1z8gcb');
  DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/
 ``` 
