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

*--------------------------------------------------------------------*
* Sample code
*--------------------------------------------------------------------*
*  IF go_cust IS BOUND.
*    CREATE OBJECT dg_dyndoc_id
*      EXPORTING
*        style = 'ALV_GRID'.
*
*    CREATE OBJECT dg_splitter
*      EXPORTING
*        parent  = go_cust
*        rows    = 2
*        columns = 1.
*
**    CALL METHOD dg_splitter->get_container
**      EXPORTING
**        row       = 1
**        column    = 1
**      RECEIVING
**        container = dg_parent_html.
*
*    CALL METHOD dg_splitter->get_container
*      EXPORTING
*        row       = 2
*        column    = 1
*      RECEIVING
*        container = dg_parent_grid.
*
*    CALL METHOD dg_splitter->set_row_height
*      EXPORTING
*        id     = 1
*        height = 10.
*  ENDIF.
*
*  IF dg_dyndoc_id IS BOUND.
** Initializing document
*    CALL METHOD dg_dyndoc_id->initialize_document.
*
*    DATA : dl_text(255) TYPE c. "Text
*    DATA: lv_date TYPE char10.
*
*    CALL METHOD dg_dyndoc_id->add_text
*      EXPORTING
*        text      = 'This is Demo of Top of Page'
*        sap_style = cl_dd_area=>heading.
*    CALL METHOD dg_dyndoc_id->new_line.
*
*    CONCATENATE sy-datum+6(2) sy-datum+4(2) sy-datum+0(4) INTO lv_date SEPARATED BY '.'.
*    CONCATENATE 'Date : ' lv_date INTO dl_text SEPARATED BY space.
*    CALL METHOD dg_dyndoc_id->add_text
*      EXPORTING
*        text      = dl_text
*        sap_style = cl_dd_area=>heading.
*
*    DATA : dl_length        TYPE i,                           " Length
*           dl_background_id TYPE sdydo_key VALUE space. " Background_id
** Creating html control
**    IF dg_html_cntrl IS INITIAL.
**      CREATE OBJECT dg_html_cntrl
**        EXPORTING
**          parent = dg_parent_html.
**    ENDIF.
*** Reuse_alv_grid_commentary_set
**    CALL FUNCTION 'REUSE_ALV_GRID_COMMENTARY_SET'
**      EXPORTING
**        document = dg_dyndoc_id
**        bottom   = space
**      IMPORTING
**        length   = dl_length.
*
** Set wallpaper
*    CALL METHOD dg_dyndoc_id->set_document_background
*      EXPORTING
*        picture_id = dl_background_id.
*
** Get TOP->HTML_TABLE ready
*    CALL METHOD dg_dyndoc_id->merge_document.
*    CALL METHOD dg_dyndoc_id->merge_document.
*
*** Set wallpaper
**    CALL METHOD dg_dyndoc_id->set_document_background
**      EXPORTING
**        picture_id = dl_background_id.
*
**--------------------------------------------------------------------*
*    CALL METHOD dg_splitter->get_container
*      EXPORTING
*        row       = 1
*        column    = 1
*      RECEIVING
*        container = dg_parent_html.
*
** Creating html control
*    IF dg_html_cntrl IS INITIAL.
*      CREATE OBJECT dg_html_cntrl
*        EXPORTING
*          parent = dg_parent_html.
*    ENDIF.
**--------------------------------------------------------------------*
*
** Connect TOP document to HTML-Control
*    dg_dyndoc_id->html_control = dg_html_cntrl.
*
*    DATA lg_dyndoc_id TYPE REF TO cl_dd_document.
*
*    lg_dyndoc_id = dg_dyndoc_id.
*
** Display TOP document
*    CALL METHOD lg_dyndoc_id->display_document
*      EXPORTING
*        reuse_control      = 'X'
*        parent             = dg_parent_html
*      EXCEPTIONS
*        html_display_error = 1.
*  ENDIF.
*
*  IF dg_parent_grid IS BOUND .
*    go_control->display( EXPORTING ir_container = dg_parent_grid ).
*  ENDIF.

ENDMODULE.
