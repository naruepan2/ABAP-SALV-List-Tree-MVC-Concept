*&---------------------------------------------------------------------*
*& Report YTEST1234
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydemo_salv_spiltting_2.

*&---------------------------------------------------------------------*
*&  I N C L U D E  P R O G R A M                                       *
*&---------------------------------------------------------------------*
INCLUDE ydemo_salv_spiltting_2_topz.
INCLUDE ydemo_salv_spiltting_2_modl.
INCLUDE ydemo_salv_spiltting_2_view.
INCLUDE ydemo_salv_spiltting_2_cntl.
INCLUDE ydemo_salv_spiltting_2_o01.
INCLUDE ydemo_salv_spiltting_2_i01.

*&---------------------------------------------------------------------*
*&  I N I T I A L I Z A T I O N                                        *
*&---------------------------------------------------------------------*
INITIALIZATION.

  o_model  = NEW #( ).
  o_zsplit = NEW #( ir_model_1 = o_model ).

*&---------------------------------------------------------------------*
*&  A T  S E L E C T I O N   S C R E E N   O U T P U T                 *
*&---------------------------------------------------------------------*
*AT SELECTION-SCREEN OUTPUT.

*----------------------------------------------------------------------*
*   A T  S E L E C T I O N   S C R E E N   O N   V A L U E ...         *
*----------------------------------------------------------------------*
*AT SELECTION-SCREEN ON VALUE-REQUEST FOR .

*&---------------------------------------------------------------------*
*&  A T  S E L E C T I O N   S C R E E N                               *
*&---------------------------------------------------------------------*
*AT SELECTION-SCREEN.


*&---------------------------------------------------------------------*
*&  S T A R T - O F - S E L E C T I O N                                *
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  TRY.
* Get selection data
      o_model->select_data( ).

* Process data
      o_model->process_data( ).

* Display result
      o_zsplit->display_result( ).

    CATCH zbcx_exception INTO DATA(go_except).
      go_except->display_msg( ).
  ENDTRY.
