# SQL_Tuning_Advisor
SQL Tuning Advisor Design Project(Tuning Advisor 설계 프로젝트)

## Project Process
## 조사(Research)
### SQL Tuning Advisor 조사

# Automatic Workload Repository (AWR)

## Shared SQL area

+ AWR에 저장되지 않은 최근의 SQL statement들을 파악하기 위해 사용된다.
+ AWR과 더불어 high-load SQL statement를 파악하는데 사용되는 듯 하다.

# SQL Tuning Set

+ Execution context와 함께 SQL statement를 저장하는 database object
+ 각 statement의 performance를 측정하거나 예상보다 성능이 시원찮은 statement를 식별하는 것이 목적
+ DB는 SQL statement를 input으로 받으면 해당 tuning set을 먼저 구성해야 한다.

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
