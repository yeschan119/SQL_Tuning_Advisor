--sys.advisor_tasks

create table sys._advisor_definitions (
			ADVISOR_ID        NUMBER  NOT NULL,
			ADVISOR_NAME      VARCHAR2(30) NOT NULL,
			PROPERTY          NUMBER   NOT NULL
);

--sys._advisor_tasks

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

--sys._advisor_objects
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

--sys._advisor_object_types
create table sys._advisor_object_types (
    OBJ_TYPE_ID                   NUMBER,
    OBJ_TYPE                      varchar2(64)
);

--sys._advisor_logs

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
