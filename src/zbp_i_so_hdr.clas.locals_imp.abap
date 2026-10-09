CLASS lhc_ZI_SO_HDR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_so_hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_so_hdr RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
       IMPORTING keys REQUEST requested_features FOR zi_so_hdr RESULT result.

    METHODS calculateTotals FOR MODIFY
      IMPORTING keys FOR ACTION zi_so_hdr~calculateTotals.

    METHODS setInitialCreditLimit FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_so_hdr~setInitialCreditLimit.

    METHODS setInitialCreditLimit1 FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_so_hdr~setInitialCreditLimit1.

    METHODS addRow FOR MODIFY
        IMPORTING keys FOR ACTION zi_so_hdr~addRow RESULT result.

ENDCLASS.

CLASS lhc_ZI_SO_HDR IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

**To hide the Add Button from display mode
  METHOD get_instance_features.
    READ ENTITIES OF zi_so_hdr IN LOCAL MODE
    ENTITY zi_so_hdr
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    result = VALUE #(
        FOR ls_hdr IN lt_hdr
        (
            %tky = ls_hdr-%tky
            %features-%action-addRow = COND #(
                WHEN ls_hdr-%is_draft = if_abap_behv=>mk-on
                    THEN if_abap_behv=>fc-o-enabled
                ELSE if_abap_behv=>fc-o-disabled
            )
        )
    ).

  ENDMETHOD.

**To calculate the Total Pricing items dynamically based on items
  METHOD calculateTotals.
    READ ENTITIES OF zi_so_hdr IN LOCAL MODE
    ENTITY zi_so_hdr BY \_items
    FIELDS (
        Grossvalue
        Taxdiscountpercent
        Discountpercent
        Netvalue
    )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_items).

    LOOP AT keys INTO DATA(ls_key).

      DATA(lv_totalitems) = 0.
      DATA(lv_grossvalue) = CONV zdt_so_hdr-grossvalue( 0 ).
      DATA(lv_discount)   = CONV zdt_so_hdr-discountpercent( 0 ).
      DATA(lv_tax)        = CONV zdt_so_hdr-tax( 0 ).
      DATA(lv_netvalue)   = CONV zdt_so_hdr-netvalue( 0 ).

      LOOP AT lt_items USING KEY entity INTO DATA(ls_item)
        WHERE Customerid = ls_key-Customerid.

        lv_totalitems = lv_totalitems + 1.
        lv_grossvalue = lv_grossvalue + ls_item-Grossvalue.
        lv_discount   = lv_discount   + ls_item-Discountpercent.
        lv_tax        = lv_tax        + ls_item-Taxdiscountpercent.
        lv_netvalue   = lv_netvalue   + ls_item-Netvalue.

      ENDLOOP.

      MODIFY ENTITIES OF zi_so_hdr IN LOCAL MODE
        ENTITY zi_so_hdr
        UPDATE FIELDS (
          Totalitems
          Grossvalue
          Discountpercent
          Tax
          Netvalue
        )
        WITH VALUE #(
          (
            %tky            = ls_key-%tky
            Totalitems      = lv_totalitems
            Grossvalue      = lv_grossvalue
            Discountpercent = lv_discount
            Tax             = lv_tax
            Netvalue        = lv_netvalue
          )
        ).

    ENDLOOP.

  ENDMETHOD.

**To set Initial value and Criticality as error for CreditLimit
  METHOD setInitialCreditLimit.
    MODIFY ENTITIES OF zi_so_hdr IN LOCAL MODE
    ENTITY zi_so_hdr
    UPDATE FIELDS ( CreditLimitText CreditLimitCriticality )
    WITH VALUE #(
        FOR key IN keys
        (
            %tky = key-%tky
            CreditLimitText = 'Unavailable'
            CreditLimitCriticality = 1
        )
    ).

  ENDMETHOD.

  METHOD setInitialCreditLimit1.

    DATA:
        lo_dest      TYPE REF TO if_http_destination,
        lo_client    TYPE REF TO if_web_http_client,
        lo_response  TYPE REF TO if_web_http_response,
        lv_json      TYPE string.

      TYPES: BEGIN OF ty_user,
               id    TYPE i,
               name  TYPE string,
               email TYPE string,
             END OF ty_user.

      DATA ls_user TYPE ty_user.

      TRY.

          lo_dest = cl_http_destination_provider=>create_by_url(
                      'https://jsonplaceholder.typicode.com' ).

          lo_client = cl_web_http_client_manager=>create_by_http_destination(
                        lo_dest ).

          lo_client->get_http_request( )->set_uri_path(
            '/users/1' ).

          lo_response = lo_client->execute(
                          i_method = if_web_http_client=>get ).

          lv_json = lo_response->get_text( ).

          /ui2/cl_json=>deserialize(
            EXPORTING json = lv_json
            CHANGING  data = ls_user ).

          APPEND VALUE #(
            %msg = new_message_with_text(
                     severity = if_abap_behv_message=>severity-success
                     text     = |ID: { ls_user-id }, Name: { ls_user-name }, Email: { ls_user-email }|
                   )
          ) TO reported-zi_so_hdr.

        CATCH cx_root INTO DATA(lx_error).

          APPEND VALUE #(
            %msg = new_message_with_text(
                     severity = if_abap_behv_message=>severity-error
                     text     = lx_error->get_text( )
                   )
          ) TO reported-zi_so_hdr.

      ENDTRY.





*    DATA:
*    lo_dest      TYPE REF TO if_http_destination,
*    lo_client    TYPE REF TO if_web_http_client,
*    lo_response  TYPE REF TO if_web_http_response,
*    lv_json      TYPE string.
*
*  TYPES: BEGIN OF ty_user,
*           id    TYPE i,
*           name  TYPE string,
*           email TYPE string,
*         END OF ty_user.
*
*  DATA ls_user TYPE ty_user.
*
*  TRY.
*
*      lo_dest = cl_http_destination_provider=>create_by_url( 'https://jsonplaceholder.typicode.com/users' ).
*
*      lo_client = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
*
*      lo_response = lo_client->execute( i_method = if_web_http_client=>get ).
*
*      lv_json = lo_response->get_text( ).
*
*      /ui2/cl_json=>deserialize( EXPORTING json = lv_json
*        CHANGING  data = ls_user ).
*    CATCH cx_root INTO DATA(lx_error).
*
*      DATA(lv_error) = lx_error->get_text( ).
*
*  ENDTRY.


************************Post

*    DATA:
*      lo_dest      TYPE REF TO if_http_destination,
*      lo_client    TYPE REF TO if_web_http_client,
*      lo_request   TYPE REF TO if_web_http_request,
*      lo_response  TYPE REF TO if_web_http_response,
*      lv_response  TYPE string.
*
*    TRY.
*
*        lo_dest = cl_http_destination_provider=>create_by_url(
*          'https://jsonplaceholder.typicode.com' ).
*
*        lo_client = cl_web_http_client_manager=>create_by_http_destination(
*          lo_dest ).
*
*        lo_request = lo_client->get_http_request( ).
*
*        lo_request->set_uri_path( '/users' ).
*
*        lo_request->set_header_field(
*          i_name  = 'Content-Type'
*          i_value = 'application/json' ).
*
*        lo_request->set_text(
*          '{"name":"Rakesh","username":"rakesh123","email":"rakesh@test.com", "id": 11}' ).
*
*        lo_response = lo_client->execute(
*          i_method = if_web_http_client=>post ).
*
*        lv_response = lo_response->get_text( ).
*
*        DATA(ls_status) = lo_response->get_status( ).
*
*          IF ls_status-code = 201.
*            APPEND VALUE #(
*              %msg = new_message_with_text(
*                       severity = if_abap_behv_message=>severity-success
*                       text     = 'API called Successfully' )
*            ) TO reported-zi_so_hdr.
*          ELSE.
*            APPEND VALUE #(
*              %msg = new_message_with_text(
*                       severity = if_abap_behv_message=>severity-error
*                       text     = lv_response )
*            ) TO reported-zi_so_hdr.
*          ENDIF.
*
*        CATCH cx_root INTO DATA(lx_error).
*
*          DATA(lv_error) = lx_error->get_text( ).
*
*        ENDTRY.

  ENDMETHOD.

**To add one row in item list report
  METHOD addRow.

      DATA lt_create TYPE TABLE FOR CREATE zi_so_hdr\_items.

      LOOP AT keys INTO DATA(ls_key).

        DATA lv_itemno TYPE sysuuid_x16.

          TRY.
              lv_itemno = cl_system_uuid=>create_uuid_x16_static( ).
            CATCH cx_uuid_error INTO DATA(lx_uuid).
          ENDTRY.


*        APPEND VALUE #(
*          %key = VALUE #(
*            Customerid = ls_key-%key-Customerid
*          )
*
*          %target = VALUE #(
*            (
*                %cid = |New_{ sy-tabix }|
*                Customerid  = ls_key-Customerid
*                Itemno = lv_itemno
*                Material           = ''
*                Unitprice          = 0
*                Quantity           = 0
*                Itemcategory       = ''
*                Shippingmode       = ''
*                Discountpercent    = 0
*                Taxdiscountpercent = 0
*                Deliveryplant      = ''
*                Storagelocation    = ''
*                Netprice           = 0
*                Netvalue           = 0
*                Grossvalue         = 0
*                Priceelements      = ''
*            )
*          )
*        ) TO lt_create.

        APPEND VALUE #(
        %tky = ls_key-%tky

        %target = VALUE #(
          (
            %cid     = |NEW_ITEM_{ sy-tabix }|
            %is_draft  = if_abap_behv=>mk-on
            Customerid = ls_key-Customerid
            Itemno   = lv_itemno
            Material = ''
            Quantity = 0
          )
        )
      ) TO lt_create.

      ENDLOOP.

        MODIFY ENTITIES OF zi_so_hdr IN LOCAL MODE
        ENTITY zi_so_hdr
        CREATE BY \_items
        FROM lt_create
        MAPPED   DATA(ls_mapped)
        FAILED DATA(ls_failed)
        REPORTED DATA(ls_reported).

        READ ENTITIES OF zi_so_hdr IN LOCAL MODE
        ENTITY zi_so_hdr
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_hdr).

      result = VALUE #(
        FOR ls_hdr IN lt_hdr
        (
          %tky   = ls_hdr-%tky
          %param = ls_hdr
        )
      ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_SO_ITEMS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS updateHeaderTotals FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_so_items~updateHeaderTotals.

ENDCLASS.

CLASS lhc_ZI_SO_ITEMS IMPLEMENTATION.



**Determination on modify method
  METHOD updateHeaderTotals.
*    MODIFY ENTITIES OF zi_so_hdr IN LOCAL MODE
*    ENTITY zi_so_hdr
*    EXECUTE calculateTotals
*    FROM VALUE #(
*        FOR key in keys
*        (
*            %tky = CORRESPONDING #( key )
*        )
*    ).

     DATA lt_hdr_keys TYPE TABLE FOR ACTION IMPORT zi_so_hdr~calculateTotals.

      lt_hdr_keys = VALUE #(
        FOR key IN keys
        (
          %tky = VALUE #(
            Customerid = key-Customerid
          )
        )
      ).

      SORT lt_hdr_keys BY %tky.
      DELETE ADJACENT DUPLICATES FROM lt_hdr_keys COMPARING %tky.

      MODIFY ENTITIES OF zi_so_hdr IN LOCAL MODE
        ENTITY zi_so_hdr
        EXECUTE calculateTotals
        FROM lt_hdr_keys.

  ENDMETHOD.

ENDCLASS.
