CLASS zcl_update_age DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_apj_rt_exec_object.
    INTERFACES if_apj_dt_exec_object.
ENDCLASS.



CLASS ZCL_UPDATE_AGE IMPLEMENTATION.


    METHOD if_apj_rt_exec_object~execute.

*        DATA:
*          lt_employee TYPE TABLE OF ztest_employee,
*          lv_age      TYPE i.
*
*        SELECT *
*          FROM ztest_employee
*          INTO TABLE @lt_employee.
*
*        LOOP AT lt_employee ASSIGNING FIELD-SYMBOL(<ls_employee>).
*
*          lv_age = sy-datum+0(4) - <ls_employee>-date_of_birth+0(4).
*
*          IF sy-datum+4(4) < <ls_employee>-date_of_birth+4(4).
*            lv_age = lv_age - 1.
*          ENDIF.
*
*          <ls_employee>-age = lv_age.
*
*        ENDLOOP.
*
*        MODIFY ztest_employee FROM TABLE @lt_employee.




*        MODIFY ENTITIES OF zi_test_employee
*          ENTITY zi_test_employee
*          CREATE
*          FROM VALUE #(
*            (
*              %cid         = 'EMP1'
*              EmployeeId   = '1'
*              EmployeeName = 'Rakesh'
*              DateOfBirth  = '20020420'
*              Address      = 'Bangalore'
*            )
*          )
*          MAPPED   DATA(ls_mapped)
*          FAILED   DATA(ls_failed)
*          REPORTED DATA(ls_reported).
*
*        IF ls_failed IS INITIAL.
*
*            COMMIT ENTITIES.
*        ELSE.
*            ROLLBACK ENTITIES.
*        ENDIF.


        DATA: ls_employee TYPE ztest_employee,
              lv_age TYPE i.

        ls_employee-employee_id   = '2'.
        ls_employee-employee_name = 'Rakesh'.
        ls_employee-date_of_birth = '20020420'.
        ls_employee-address = 'Bangalore'.

        INSERT ztest_employee FROM @ls_employee.

        IF sy-subrc = 0.
            COMMIT WORK.
        ELSE.
            ROLLBACK WORK.
        ENDIF.

    ENDMETHOD.


    METHOD if_apj_dt_exec_object~get_parameters.

        " No parameters required

      ENDMETHOD.
ENDCLASS.
