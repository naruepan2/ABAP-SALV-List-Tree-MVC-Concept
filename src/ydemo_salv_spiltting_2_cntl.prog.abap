*&---------------------------------------------------------------------*
*& Include          YDEMO_SALV_SPILTTING_2_CNTL
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_controller DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_controller DEFINITION INHERITING FROM zcl_mvcfw_base_spiltting_simpl.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING ir_model_1 TYPE REF TO lcl_model OPTIONAL
                ir_model_2 TYPE REF TO lcl_model OPTIONAL.
    METHODS display_result.
    METHODS set_ref_table_to_instance REDEFINITION.


  PROTECTED SECTION.


  PRIVATE SECTION.


ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_controller IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_controller IMPLEMENTATION.
  METHOD constructor.
    super->constructor( EXPORTING ir_model_1 = ir_model_1
                                  ir_model_2 = ir_model_2 ).
  ENDMETHOD.

  METHOD display_result.
    CALL SCREEN '9000'.
  ENDMETHOD.

  METHOD set_ref_table_to_instance.
    CASE iv_adapter_name.
      WHEN c_salv_1.
        cv_rtname = 'MT_ALV_1'.
      WHEN c_salv_2.
        cv_rtname = 'MT_ALV_2'.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
