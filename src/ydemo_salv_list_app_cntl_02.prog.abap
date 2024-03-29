*&---------------------------------------------------------------------*
*& Include          YDEMO_APP_CNTL
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_controller DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_controller DEFINITION INHERITING FROM zcl_mvcfw_base_salv_controller.
  PUBLIC SECTION.
    DATA o_lcl_model TYPE REF TO lcl_model.

    METHODS constructor.
    METHODS handle_list_double_click REDEFINITION.
    METHODS handle_list_top_of_page REDEFINITION.
    METHODS populate_setup_before_display REDEFINITION.
    METHODS handle_list_add_function REDEFINITION.

  PROTECTED SECTION.


  PRIVATE SECTION.


ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_controller IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_controller IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).

    IF o_model IS BOUND.
      o_lcl_model = CAST #( o_model ).
    ENDIF.
  ENDMETHOD.

  METHOD handle_list_add_function.
*BREAK-POINT.
  ENDMETHOD.

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
                                                iv_destroy    = abap_true
                                              )->display( )->destroy_stack( ).
                CATCH zbcx_exception.
              ENDTRY.
            ENDIF.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_list_top_of_page.
BREAK-POINT.
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
