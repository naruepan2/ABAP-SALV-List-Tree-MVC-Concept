*&---------------------------------------------------------------------*
*& Include          YDEMO_SALV_SPILTTING_2_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_9000 OUTPUT.
*  SET PF-STATUS 'STATUS_9000'.
* SET TITLEBAR 'xxx'.

  IF o_cust IS NOT BOUND.
    CREATE OBJECT o_cust
      EXPORTING
        container_name = 'CONTAINER'.
  ENDIF.

  IF o_split IS BOUND.
    o_split->display_as_split( EXPORTING ir_custom_container = o_cust
                                         it_table_1          = o_model->get_outtab_1( )
                                         it_table_2          = o_model->get_outtab_2( ) ).
  ENDIF.
ENDMODULE.
