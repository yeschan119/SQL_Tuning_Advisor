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
  + user로부터 입력되는 값들을(ex: sql_text)
#### Exectue Tuning Task 설계
#### Report Tuning Task 설계
#### Accept Sql Profile 설계
## 구현(Implementation)
