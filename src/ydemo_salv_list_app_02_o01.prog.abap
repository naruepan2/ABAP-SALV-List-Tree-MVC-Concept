*----------------------------------------------------------------------*
***INCLUDE YDEMO_SALV_LIST_APP_02_O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_9000 OUTPUT.
  SET PF-STATUS 'D0100' OF PROGRAM 'SALV_DEMO_COMPLICATED_DATATYPE'.
* SET TITLEBAR 'xxx'.

  IF cl_salv_table=>is_offline( ) EQ if_salv_c_bool_sap=>false
 AND go_cust IS NOT BOUND.
    go_cust = NEW #( container_name = 'CUSTOM_GRID' ).
  ENDIF.

  go_control->display( EXPORTING ir_container = go_cust ).

ENDMODULE.
