*&---------------------------------------------------------------------*
*& Include          YDEMO_APP_CNTL
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_controller DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_controller DEFINITION INHERITING FROM zcl_mvcfw_base_salv_controller.
  PUBLIC SECTION.
    METHODS handle_list_double_click REDEFINITION.
    METHODS handle_list_link_click REDEFINITION.
    METHODS handle_list_check_changed_data REDEFINITION.
    METHODS populate_setup_before_display REDEFINITION.

  PROTECTED SECTION.


  PRIVATE SECTION.


ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_controller IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_controller IMPLEMENTATION.
  METHOD handle_list_double_click.
    CASE get_current_stack_name( ).
      WHEN 'MAIN'.
        CASE column.
          WHEN 'CHKBOX'.
            IF row GT 0.

            ENDIF.
          WHEN OTHERS.
            IF row GT 0.
              TRY.
                  me->create_new_view_instance( iv_stack_name = 'SUB01'
                                                ir_event_list = NEW #( row_double_click    = row
                                                                       column_double_click = column )
                                              )->display( )->destroy_stack( ).
                CATCH zbcx_exception.
              ENDTRY.
            ENDIF.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_list_link_click.
    CASE get_current_stack_name( ).
      WHEN 'MAIN'.
        CASE column.
          WHEN'CHKBOX'.
            me->_set_checkbox_on_click( row       = row
                                        column    = column
                                        list_view = list_view
                                        model     = model ).
        ENDCASE.
      WHEN 'SUB01'.
        CASE column.
          WHEN 'CARRID'.
            DATA(lv_msg) = |Column { column } Row { row } is clicked|.
            MESSAGE i000(38) WITH lv_msg.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_list_check_changed_data.
  ENDMETHOD.

  METHOD populate_setup_before_display.
    IF cr_list_param->stack_name EQ 'SUB01'.
      cr_list_param->start_column = 1.
      cr_list_param->start_line   = 1.
      cr_list_param->end_column   = 100.
      cr_list_param->end_line     = 20.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_controller DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_controller2 DEFINITION INHERITING FROM lcl_controller.
  PUBLIC SECTION.


  PROTECTED SECTION.


  PRIVATE SECTION.


ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_controller2 IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_controller2 IMPLEMENTATION.


ENDCLASS.
