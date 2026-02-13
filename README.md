# SQL_Tuning_Advisor
SQL Tuning Advisor Design Project

[한국어 🇰🇷](README.ko.md)

# Purpose
+ Develop SQL Tuning Advisor functionality to provide basic SQL tuning support
+ Develop SQL_Tuning_Advisor packages and functions to support SQL tuning
+ Reference: [Oracle SQL Tuning Advisor](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgsql/sql-tuning-advisor.html#GUID-8E1A39CB-A491-4254-8B31-9B1DF7B52AA1)

# 👨‍👩‍👧‍👦 Members
+ Minwoo Jung (Researcher)
+ Eungchan Kang (Researcher)

# Tech Stack
+ RDBMS
+ PL/SQL
+ C language
+ Shell script

# Milestone
+ The SQL Tuning Advisor will initially support two levels: Limited Scope and Comprehensive Scope, with the primary goal being completion of the Limited Scope.
+ Research, basic interface design, and implementation
  + Week 1: Research SQL Tuning Advisor concepts (referencing Oracle Tuning Advisor)
  + Week 2: Reverse engineering of SQL Tuning Advisor components (packages, procedures, functions)
  + Week 3: Implement system tables and tuning package specification (`pkg_dbms_sqltune.sql`)
+ Implement tuning advisor package body
  + Week 4: Implement tuning package body (`pkg_dbms_sqltune_internal.sql`)
  + Week 5: Implement tuning package body (`pkg_dbms_sqltune_internal.sql`)
+ Implement tuning advisor utility components (implemented in C)
  + Week 6: Implement Structure Analysis (analyze parsed queries / parse trees for tuning)
  + Week 7: Implement Structure Analysis using parse trees
+ Add tuning advisor test cases
  + Week 8: Add create tuning task test cases
  + Week 8: Add execute tuning task test cases
+ Implement tuning advisor report

## LIMITED SCOPE
+ Implement package functions and objects that allow users to define Tuning Tasks and allow the database to manage these tasks
+ Implement logic to determine whether database object statistics accessed by the Tuning Task SQL are missing or stale
+ Implement logic to create virtual indexes on tables accessed by the Tuning Task SQL and calculate the benefit of applying those indexes
+ Implement logic to transform SQL structure and syntax without changing result sets, and calculate the benefit of each transformed query
  + Detect expensive NOT IN operations and suggest improvements
  + Detect expensive UNION set operations and suggest improvements
  + Detect index data type mismatches and suggest improvements
  + Detect join predicates that cause Cartesian products and suggest improvements
+ Implement Report Tuning Task functionality
+ Implement Update / Delete / Modify Tuning Task functionality

## COMPREHENSIVE
+ Implement logic to perform multiple rounds of dynamic sampling in tuning mode to calculate more accurate selectivity
+ Implement logic to perform partial execution in tuning mode to calculate more accurate selectivity
+ Implement logic to improve optimizer mode settings (e.g. `FIRST_ROWS`, `ALL_ROWS`) based on past execution history
+ Implement logic to search for alternative execution plans for Tuning Task SQL and compare costs with the original plan
+ Implement logic to provide tuning mode execution results in report format

## Design (Reference: Oracle Tuning Advisor)

### SQL Tuning Advisor Design

#### Design of Tuning Advisor Packages (Body & Specification)
+ PKG_DBMS_SQLTUNE package body & specification
  + Body: Declarations of procedures and functions to execute core tuning advisor features (create, execute, report, etc.)
  + Spec: Implementations of procedures and functions declared in the body
+ PKG_DBMS_SQLTUNE_INTERNAL package body & specification
  + Body: Declarations of functions required to perform operations during the Execute Tuning Task phase
  + Spec: Implementations of procedures and functions declared in the body
+ PKG_DBMS_SQLTUNE_UTIL
  + Package that separates subprograms implemented in C

#### Design of Tuning Advisor Tables and Views
+ Create system tables used by the Tuning Advisor (created during DB booting)
  + Advisor_Definitions
    + Table for managing various advisors in the database
      + ADDM
      + SQL Access Advisor
      + Undo Advisor
      + SQL Tuning Advisor
      + SQL Workload Manager
      + ...
  + Advisor_Tasks
    + Table for storing and managing advisor execution units (tasks)
  + Advisor_Object_Types
  + Advisor_Objects
    + Table for storing object_id and object_name combinations assigned per task
  + Advisor_Logs
    + Table for logging tuning processes at each stage
  + Design DBA_ADVISOR_DEFINITIONS view
  + Design DBA_ADVISOR_TASKS view
  + Design DBA_ADVISOR_OBJECTS view
  + Design DBA_ADVISOR_EXECUTIONS view
  + Design DBA_ADVISOR_LOG view
  + ...

#### Create Tuning Task Design
+ Create tuning tasks using user inputs (e.g. sql_id, scope, task_name)
+ Generate default values for null inputs
+ Validate input values
+ Store input values and generated values into system tables

#### Execute Tuning Task Design
+ Statistical Analysis
  + Identify missing or stale statistics for tables and indexes
+ Access Path Analysis
  + Determine execution cost optimization based on index availability
  + Suggest execution of SQL Access Advisor
+ SQL Structural Analysis (Detect performance degradation factors and suggest improvements at syntax/semantic level)
  + Suggest replacing NOT IN with NOT EXISTS or UNION with UNION ALL
  + Detect inefficiencies caused by datatype mismatches between index columns and WHERE clause columns
  + Detect missing join conditions (design mistakes)

#### Report Tuning Task Design
#### Accept SQL Profile Design

## Implementation

### SQL Tuning Advisor Implementation

#### Implementation of Tuning Advisor Tables and Views
+ sys._advisor_definitions - example
  ```
    create table sys._advisor_definitions (
			ADVISOR_ID        NUMBER  NOT NULL,
			ADVISOR_NAME      VARCHAR2(30) NOT NULL,
			PROPERTY          NUMBER   NOT NULL
    );
 ```
+ sys._advisor_tasks - example

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
```
tuning task 정보를 저장하는 테이블
sql_id를 입력받은 후에
create_tuning_task 당시 생성되는 값들(task_id, task_name, owner, created, last_modified..)
execute_tuning_task 당시 생성되는 값들(execute_start, execute_end, status, last_modified..)
status의 경우 create일 때 0, execute일 때 1
```
+ sys._advisor_objects - example

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
+ sys._advisor_object_types - example
```
create table sys._advisor_object_types (
    OBJ_TYPE_ID                   NUMBER,
    OBJ_TYPE                      varchar2(64)
);
```
+ sys._advisor_logs - example
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
+ Create_Tuning_Task test(아래 pl/sql을 수행시 tuning task가 생성되도록 로직 구현) - example
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
