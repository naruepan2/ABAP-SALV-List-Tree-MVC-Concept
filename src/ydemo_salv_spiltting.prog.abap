*&---------------------------------------------------------------------*
*& Report YTEST1234
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydemo_salv_spiltting.

*--------------------------------------------------------------------*
DATA: gt_alv_1 TYPE TABLE OF spfli,
      gt_alv_2 TYPE TABLE OF sflight.

*DATA: gr_salv_1 TYPE REF TO cl_salv_table,
*      gr_salv_2 TYPE REF TO cl_salv_table.
*DATA: gr_splitter TYPE REF TO cl_gui_splitter_container.
*DATA: gr_container_1 TYPE REF TO cl_gui_container,
*      gr_container_2 TYPE REF TO cl_gui_container.
*DATA: lr_column_1 TYPE REF TO cl_salv_column_list,
*      lr_column_2 TYPE REF TO cl_salv_column_list.
*DATA: lo_events  TYPE REF TO cl_salv_events_table.


START-OF-SELECTION.
*--------------------------------------------------------------------*
* ALV Data
*--------------------------------------------------------------------*
  SELECT * FROM spfli INTO TABLE @gt_alv_1.
  SELECT * FROM sflight INTO TABLE @gt_alv_2.

*--------------------------------------------------------------------*
* Create ALV screens
*--------------------------------------------------------------------*
  NEW zcl_mvcfw_base_list_split_view( )->display_as_split( CHANGING ct_table_1 = gt_alv_1
                                                                    ct_table_2 = gt_alv_2 ).



**--------------------------------------------------------------------*
** Create ALV screens
**--------------------------------------------------------------------*
*  TRY.
** Splitter - it is neccessary to specify the default_screen as parent
*      gr_splitter = NEW #( parent         = cl_gui_container=>screen0
*                           no_autodef_progid_dynnr = space "abap_true
*                           rows          = 2
*                           columns         = 1 ).
*
** Container 1 for header
*      gr_container_1 = gr_splitter->get_container( row  = 1
*                                                   column = 1 ).
*
** Container 2 for detail
*      gr_container_2 = gr_splitter->get_container( row  = 2
*                                                   column = 1 ).
*
**<< ALV1 - gt_alv_1 is the table with the data
*      cl_salv_table=>factory( EXPORTING r_container = gr_container_1
*                              IMPORTING r_salv_table = gr_salv_1
*                              CHANGING t_table   = gt_alv_1 ).
*
** Set ALV functions - should you wish to include any
*      DATA(gr_salv_func_1) = gr_salv_1->get_functions( ).
*      gr_salv_func_1->set_all( abap_true ).
*
** Set display settings as usual
*      DATA(lr_display_1) = gr_salv_1->get_display_settings( ).
*
** Selection - set as usual
*      gr_salv_1->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>multiple ).
*
** Layout - set as usual
*      DATA(ls_key_1) = VALUE salv_s_layout_key( report = sy-cprog
*                                                handle = '0001' ).
*      DATA(lr_layout_1) = gr_salv_1->get_layout( ).
*      lr_layout_1->set_key( ls_key_1 ).
**<< Display ALV_1
*
*      gr_salv_1->display( ).
*
**--------------------------------------------------------------------*
**<< ALV1 - gt_alv_1 is the table with the data
*      cl_salv_table=>factory( EXPORTING r_container = gr_container_2
*                              IMPORTING r_salv_table = gr_salv_2
*                              CHANGING t_table   = gt_alv_2 ).
*
** Set ALV functions - should you wish to include any
*      DATA(gr_salv_func_2) = gr_salv_2->get_functions( ).
*      gr_salv_func_2->set_all( abap_true ).
*
** Set display settings as usual
*      DATA(lr_display_2) = gr_salv_2->get_display_settings( ).
*
** Selection - set as usual
*      gr_salv_2->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>multiple ).
*
** Layout - set as usual
*      DATA(ls_key_2) = VALUE salv_s_layout_key( report = sy-cprog
*                                                handle = '0002' ).
*      DATA(lr_layout_2) = gr_salv_2->get_layout( ).
*      lr_layout_2->set_key( ls_key_2 ).
*
**<< Display ALV_2,
*      gr_salv_2->display( ).
*
**<< Have to be to display ALV in full screen mode
*
*      WRITE: space.
*
*    CATCH cx_salv_msg cx_salv_not_found cx_salv_data_error cx_salv_access_error INTO DATA(lx_alv).
*  ENDTRY.
