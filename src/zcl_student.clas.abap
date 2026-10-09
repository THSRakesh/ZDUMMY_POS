CLASS zcl_student DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_STUDENT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lt_student TYPE TABLE OF zsc_student=>tys_student_type.

      out->write( 'Service Consumption Model generated successfully' ).
      "Fetch Student Data
*      lt_student = zsc_student=>get_students( ).
      out->write( 'Student Data' ).
      out->write( lt_student ).
  ENDMETHOD.
ENDCLASS.
