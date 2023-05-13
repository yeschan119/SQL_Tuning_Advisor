# SQL_Tuning_Advisor
SQL Tuning Advisor Design Project(Tuning Advisor 설계 프로젝트)
# Purpose
SQL Tuning Advisor Package를 개발하여 SQL Tunning 지원
# 👨‍👩‍👧‍👦 Members
정민우(Researcher)
강응찬(Researcher)
# Milesstone
SQL Tuning Advisor기능 레벨은 Limited Scope와 Comprehensive로
## LIMITED SCOPE
+ 유저가 Tuning Task를 직접 정의하고 DB가 이 Task들을 관리할 수 있도록 관련 패키지 함수 및 오브젝트 구현하기
+ Tuning task의 SQL이 접근하는 DB 오브젝트 통계 missing 혹은 stale 여부 판별하는 로직 만들기
+ Tuning task의 SQL 수행 시 접근하는 table에 대한 가상 index를 생성하고, 해당 index 적용 시의 benefit 계산하는 로직 만들기
+ Tuning task의 SQL의 구조 및 문법들을 결과값이 바뀌지 않는 선에서 조작할 수 있는 로직을 구현하고, 조작된 각각의 쿼리들로부터 얻을 수 있는 benefit 계산하는 로직 만들기
+ 비용이 많이 드는 Not In operation을 찾고 개선 방안 제안
비용이 많이 드는 UNION set operation을 찾고 개선 방안 제안
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
#### Create Tuning Task 조사
#### Exectue Tuning Task 조사
#### Report Tuning Task 조사
#### Accept Sql Profile 조사
## 설계(Design)
### SQL Tuning Advisor 설계
#### Create Tuning Task 설계
#### Exectue Tuning Task 설계
#### Report Tuning Task 설계
#### Accept Sql Profile 설계
## 구현(Implementation)
