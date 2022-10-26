# SQL_Tuning_Advisor
SQL Tuning Advisor Design Project(Tuning Advisor 설계 프로젝트)

## Project Process
## 조사(Research)
### SQL Tuning Advisor 조사
==Tuning Advisor의 동작 원리를 알아보자==
==='''Input'''===
====Automatic Database Diagnostic Monitor (ADDM)====

*SQL Tuning Advisor의 핵심 input
*매 시간마다 돈다.
*'''Automatic Workload Repository (AWR)'''로 수집된 통계들을 기반으로 많은 비용이 발생하는 (high-load) SQL statement를 식별한다.
*많은 비용이 발생하는 SQL이 식별되면 SQL Tuning Advisor를 돌릴 것을 추천한다.
*의문점
**많은 비용이 발생하는 SQL statement의 기준점?
**Tibero에는 이에 대응하는 것이 있을까?
**Advisor가 recommendation을 뽑는데 도움을 주는게 아니라 Advisor를 사용해야 할 SQL statement를 뽑아주는 역할만 하는 것인가?

====Automatic Workload Repository (AWR)====

*System activity의 snapshot을 찍으며 여기에는 통계 기반의 (CPU Consumption, Wait time) high-load SQL statement가 rank 되어 있다.
*최근 8일 동안의 data를 저장
*AWR을 바탕으로 직접 high-load SQL statement를 파악하여 tuning advisor를 수행할 수 있다.
*의문점
**왠지 티베로에도 있을 것만 같은데... => TPR
**ADDM처럼 Advisor의 내부 동작에는 관여하지 않는 것 같고, high-load SQL statement를 파악하는데 도움을 주는 도구인가?
====Shared SQL area====

*AWR에 저장되지 않은 최근의 SQL statement들을 파악하기 위해 사용된다.
*AWR과 더불어 high-load SQL statement를 파악하는데 사용되는 듯 하다.

====SQL Tuning Set====

*Execution context와 함께 SQL statement를 저장하는 database object
*각 statement의 performance를 측정하거나 예상보다 성능이 시원찮은 statement를 식별하는 것이 목적
*DB는 SQL statement를 input으로 받으면 해당 tuning set을 먼저 구성해야 한다.

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
