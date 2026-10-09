CLASS zcl_insert_emp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    CLASS-METHODS insert_employee.
ENDCLASS.



CLASS ZCL_INSERT_EMP IMPLEMENTATION.


  METHOD insert_employee.
*     DATA:
*      ls_employee TYPE ztest_employee,
*      lv_empid    TYPE ztest_employee-employee_id..
*
*    "Get the highest employee ID
*    SELECT MAX( employee_id )
*      FROM ztest_employee
*      INTO @lv_empid.
*
*    "If table is empty, start with 1
*    IF sy-subrc <> 0.
*      lv_empid = 1.
*    ELSE.
*      lv_empid = lv_empid + 1.
*    ENDIF.
*
*    "Prepare new record
*    ls_employee-employee_id   = lv_empid.
*    ls_employee-employee_name = 'Rakesh'.
*    ls_employee-date_of_birth = '20020420'.
*
*    "Insert record
*    INSERT ztest_employee FROM @ls_employee.


    DATA: lv_empid TYPE ztest_employee-employee_id.

    SELECT MAX( employee_id )
      FROM ztest_employee
      INTO @lv_empid.

    IF lv_empid IS INITIAL.
      lv_empid = 1.
    ELSE.
      lv_empid = lv_empid + 1.
    ENDIF.

    MODIFY ENTITIES OF zi_test_employee
      ENTITY zi_test_employee
      CREATE
      FROM VALUE #(
        (
          %cid          = '1'
          EmployeeId    = lv_empid
          EmployeeName  = 'Rakesh'
          DateOfBirth   = '20020420'
          Address       = 'Bangalore'
        )
      )
      MAPPED   DATA(mapped)
      FAILED   DATA(failed)
      REPORTED DATA(reported).

    COMMIT ENTITIES
      RESPONSE OF zi_test_employee
      FAILED   DATA(commit_failed)
      REPORTED DATA(commit_reported).


  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    DATA: lo_dest     TYPE REF TO if_http_destination,
          lo_client   TYPE REF TO if_web_http_client,
          lo_response TYPE REF TO if_web_http_response,
          lv_token    TYPE string,
          lv_json     TYPE string.

    TRY.

        "Create destination
        lo_dest = cl_http_destination_provider=>create_by_url(
          'https://my401381.s4hana.cloud.sap/sap/opu/odata4/sap/zui_test_emp_v4/srvd/sap/zui_test_emp/0001/ZC_TEST_EMPLOYEE' ).

        lo_client = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

        "---------------------------------------------------
        "Fetch CSRF Token
        "---------------------------------------------------
        lo_client->get_http_request( )->set_header_field(
          i_name  = 'X-CSRF-Token'
          i_value = 'Fetch' ).

        lo_response = lo_client->execute(
          i_method = if_web_http_client=>get ).

        lv_token = lo_response->get_header_field( 'X-CSRF-Token' ).

        "---------------------------------------------------
        "JSON Payload
        "Use your CDS field names here
        "---------------------------------------------------
        lv_json = '{"EmployeeId":"2","EmployeeName":"Rakesh","DateOfBirth":"2002-04-20","Address":"Bangalore"}'.

        lo_client->get_http_request( )->set_header_field(
          i_name  = 'Content-Type'
          i_value = 'application/json' ).

        lo_client->get_http_request( )->set_header_field(
          i_name  = 'Accept'
          i_value = 'application/json' ).

        lo_client->get_http_request( )->set_header_field(
          i_name  = 'X-CSRF-Token'
          i_value = lv_token ).

        lo_client->get_http_request( )->set_text( lv_json ).

        "---------------------------------------------------
        "POST
        "---------------------------------------------------
        lo_response = lo_client->execute(
          i_method = if_web_http_client=>post ).

        out->write( lo_response->get_status( ) ).
        out->write( lo_response->get_text( ) ).

      CATCH cx_root INTO DATA(lx_error).
        out->write( lx_error->get_text( ) ).
    ENDTRY.




*    DATA: ls_employee TYPE ztest_employee,
*          lv_age TYPE i.
*
*    ls_employee-employee_id   = '1'.
*    ls_employee-employee_name = 'Rakesh'.
*    ls_employee-date_of_birth = '20020420'.
*    ls_employee-address = 'Bangalore'.
*
*    INSERT ztest_employee FROM @ls_employee.
*
*    IF sy-subrc = 0.
*      out->write( 'Record inserted successfully' ).
*
*        TRY.
*
*            DATA(ls_start_info) =
*              VALUE cl_apj_rt_api=>ty_start_info(
*                start_immediately = abap_true ).
*
*            cl_apj_rt_api=>schedule_job(
*              EXPORTING
*                iv_job_template_name = 'ZTEST_JOB_TEMP'
*                iv_job_text          = 'Employee Age Calculation'
*                is_start_info        = ls_start_info
*              IMPORTING
*                ev_jobname           = DATA(lv_jobname)
*                ev_jobcount          = DATA(lv_jobcount)
*            ).
*
*          CATCH cx_apj_rt INTO DATA(lx_apj).
*
*            DATA(lv_error) = lx_apj->get_text( ).
*
*        ENDTRY.
*
*    ELSE.
*      out->write( 'Insert failed' ).
*    ENDIF.



*********Delete the records
*    DELETE FROM ztest_employee.
*    IF sy-subrc = 0.
*      COMMIT WORK.
*      out->write( 'All records deleted successfully.' ).
*    ELSE.
*      out->write( 'No records found or delete failed.' ).
*    ENDIF.


*    DATA: lv_empid TYPE ztest_employee-employee_id.
*
*    SELECT MAX( employee_id )
*      FROM ztest_employee
*      INTO @lv_empid.
*
*    IF lv_empid IS INITIAL.
*      lv_empid = 1.
*    ELSE.
*      lv_empid = lv_empid + 1.
*    ENDIF.
*
*    MODIFY ENTITIES OF zi_test_employee
*      ENTITY zi_test_employee
*      CREATE
*      FROM VALUE #(
*        (
*          %cid          = '1'
*          EmployeeId    = lv_empid
*          EmployeeName  = 'Rakesh'
*          DateOfBirth   = '20020420'
*          Address       = 'Bangalore'
*        )
*      )
*      MAPPED   DATA(mapped)
*      FAILED   DATA(failed)
*      REPORTED DATA(reported).
*
*    COMMIT ENTITIES
*      RESPONSE OF zi_test_employee
*      FAILED   DATA(commit_failed)
*      REPORTED DATA(commit_reported).
*
*    IF failed IS NOT INITIAL.
*      out->write( failed ).
*    ENDIF.
*
*    IF reported IS NOT INITIAL.
*      out->write( reported ).
*    ENDIF.
*
*    IF commit_failed IS NOT INITIAL.
*      out->write( commit_failed ).
*    ENDIF.
*
*    IF commit_reported IS NOT INITIAL.
*      out->write( commit_reported ).
*    ENDIF.
*
*    out->write( 'Finished' ).

  ENDMETHOD.
ENDCLASS.
