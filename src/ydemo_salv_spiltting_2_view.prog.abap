*&---------------------------------------------------------------------*
*& Include          YDEMO_SALV_SPILTTING_2_VIEW
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_view DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_view DEFINITION INHERITING FROM zcl_mvcfw_base_spiltting_simpl.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING io_model_1 TYPE REF TO lcl_model OPTIONAL
                io_model_2 TYPE REF TO lcl_model OPTIONAL.
    METHODS display_result.
    METHODS set_ref_table_to_instance REDEFINITION.
    METHODS set_new_functions REDEFINITION.
    METHODS set_events REDEFINITION.

    METHODS on_user_command FOR EVENT evt_added_function OF lcl_view "zcl_mvcfw_base_spiltting_simpl
      IMPORTING e_salv_function
                list_view
                model.

  PROTECTED SECTION.


  PRIVATE SECTION.


ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_view IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_view IMPLEMENTATION.
  METHOD constructor.
    super->constructor( EXPORTING io_model_1 = io_model_1
                                  io_model_2 = io_model_2 ).
  ENDMETHOD.

  METHOD display_result.
    CALL SCREEN '9000'.
  ENDMETHOD.

  METHOD set_ref_table_to_instance.
    CASE mv_adapter_name.
      WHEN c_salv_1.
        cv_rtname = 'MT_ALV_1'.
      WHEN c_salv_2.
        cv_rtname = 'MT_ALV_2'.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD set_new_functions.
    DATA lr_functions TYPE REF TO cl_salv_functions_list.
*    BREAK-POINT.

    CASE mv_adapter_name.
      WHEN c_salv_1.
        lr_functions ?= me->get_salv_instance( )->get_functions( ).
      WHEN c_salv_2.
        lr_functions ?= me->get_salv_instance( )->get_functions( ).
    ENDCASE.

    IF lr_functions IS BOUND.
* Add EDIT function
      TRY.
          lr_functions->add_function(
            EXPORTING
              name     = 'YE_QM_NOTE'
              icon     = CONV #( icon_toggle_display )
          "optionally add custom text and tooltip
              text     = 'Fullscreen'
              tooltip  = 'Fullscreen'
              position = if_salv_c_function_position=>right_of_salv_functions ).

        CATCH cx_salv_existing
              cx_salv_wrong_call.
      ENDTRY.
    ENDIF.
  ENDMETHOD.

  METHOD set_events.
    DATA lr_events TYPE REF TO cl_salv_events_table.

    lr_events ?= me->get_salv_instance( )->get_event( ).

    SET HANDLER me->_raise_evt_double_click
                me->_raise_evt_link_click
                me->_raise_evt_added_function
            FOR lr_events.

    SET HANDLER on_user_command
            FOR me.
  ENDMETHOD.

  METHOD on_user_command.
    DATA lo_view TYPE REF TO lcl_view.

*    BREAK-POINT.

    lo_view = CAST #( list_view ).

    CASE e_salv_function.
      WHEN 'YE_QM_NOTE'.
        TRY.
            CALL METHOD lo_view->show_fullscreen
              EXPORTING
                iv_id = COND #( WHEN lo_view->mv_adapter_name = c_salv_1 THEN 1
                                WHEN lo_view->mv_adapter_name = c_salv_2 THEN 2 ).
          CATCH zbcx_exception.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
