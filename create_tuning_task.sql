
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
