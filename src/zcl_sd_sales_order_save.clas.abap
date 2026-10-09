CLASS zcl_sd_sales_order_save DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_sd_sls_end_of_finalize .

    METHODS insert_employee.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SD_SALES_ORDER_SAVE IMPLEMENTATION.


  METHOD if_sd_sls_end_of_finalize~modify_fields.

*    DATA :
*    lt_employee TYPE TABLE OF ztest_employee,
*    lv_age      TYPE i.
*
*    SELECT single *
*      FROM ztest_employee
*      INTO @Data(ls_employee).

*      insert ztest_employee from @ls_employee.

*    TRY.
*
*      DATA(ls_start_info) =
*        VALUE cl_apj_rt_api=>ty_start_info(
*            start_immediately = abap_true ).
*
*            cl_apj_rt_api=>schedule_job(
*              EXPORTING
*                iv_job_template_name = 'ZTEST_JOB_TEMP'
*                iv_job_text          = 'Employee Insertion'
*                is_start_info        = ls_start_info
*              IMPORTING
*                ev_jobname           = DATA(lv_jobname)
*                ev_jobcount          = DATA(lv_jobcount)
*            ).
*
*        CATCH cx_apj_rt INTO DATA(lx_apj).
*
*        DATA(lv_error) = lx_apj->get_text( ).
*
*    ENDTRY.



*    insert_employee( ).

*    zcl_insert_emp=>insert_employee( ).


  ENDMETHOD.


  METHOD insert_employee.

    DATA:
      ls_employee TYPE ztest_employee,
      lv_empid    TYPE ztest_employee-employee_id..

    "Get the highest employee ID
    SELECT MAX( employee_id )
      FROM ztest_employee
      INTO @lv_empid.

    "If table is empty, start with 1
    IF sy-subrc <> 0.
      lv_empid = 1.
    ELSE.
      lv_empid = lv_empid + 1.
    ENDIF.

    "Prepare new record
    ls_employee-employee_id   = lv_empid.
    ls_employee-employee_name = 'Rakesh'.
    ls_employee-date_of_birth = '20020420'.

    "Insert record
    INSERT ztest_employee FROM @ls_employee.

*    IF sy-subrc = 0.
*      COMMIT WORK.
*    ELSE.
*      ROLLBACK WORK.
*    ENDIF.

  ENDMETHOD.
ENDCLASS.
