*&---------------------------------------------------------------------*
*& Include          YDEMO_APP_VIEW
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_view DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_view DEFINITION INHERITING FROM zcl_mvcfw_base_salv_list_view.
  PUBLIC SECTION.
    METHODS set_top_of_page REDEFINITION.


  PROTECTED SECTION.


  PRIVATE SECTION.


ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_view_alv IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_view IMPLEMENTATION.
  METHOD set_top_of_page.
    DATA: lo_header  TYPE REF TO cl_salv_form_layout_grid,
          lo_h_label TYPE REF TO cl_salv_form_label,
          lo_h_flow  TYPE REF TO cl_salv_form_layout_flow.

    CHECK lmv_current_stack EQ mc_stack_main.

*   header object
    CREATE OBJECT lo_header.
*
*   To create a Lable or Flow we have to specify the target
*     row and column number where we need to set up the output
*     text.
*
*   information in Bold
    lo_h_label = lo_header->create_label( row = 1 column = 1 ).
    lo_h_label->set_text( 'Header in Bold' ).
*
*   information in tabular format
    lo_h_flow = lo_header->create_flow( row = 2  column = 1 ).
    lo_h_flow->create_text( text = 'This is text of flow' ).
*
    lo_h_flow = lo_header->create_flow( row = 3  column = 1 ).
    lo_h_flow->create_text( text = 'Number of Records in the output' ).
*
    lo_h_flow = lo_header->create_flow( row = 3  column = 2 ).
    lo_h_flow->create_text( text = 20 ).
*
*   set the top of list using the header for Online.
*    me->lmo_salv->set_top_of_list_height( 10 ).
    me->lmo_salv->set_top_of_list( lo_header ).
*
*   set the top of list using the header for Print.
    me->lmo_salv->set_top_of_list_print( lo_header ).
  ENDMETHOD.
ENDCLASS.
