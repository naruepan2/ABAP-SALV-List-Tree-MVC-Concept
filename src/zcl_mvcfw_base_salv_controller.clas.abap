CLASS zcl_mvcfw_base_salv_controller DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_os_clone .

    ALIASES clone
      FOR if_os_clone~clone .

    TYPES:
      BEGIN OF ts_list_view_param,
        stack_name     TYPE	dfies-tabname,
        list_display   TYPE	sap_bool,
        container      TYPE REF TO cl_gui_container,
        container_name TYPE	string,
        pfstatus       TYPE	sypfkey,
        variant        TYPE slis_vari,
        start_column   TYPE	i,
        end_column     TYPE	i,
        start_line     TYPE	i,
        end_line       TYPE	i,
        triggered_evt  TYPE seocpdname,
      END OF ts_list_view_param .
    TYPES:
      BEGIN OF ts_tree_view_param,
        stack_name    TYPE dfies-tabname,
        container     TYPE REF TO cl_gui_container,
        hide_header   TYPE sap_bool,
        pfstatus      TYPE sypfkey,
        variant       TYPE slis_vari,
        start_column  TYPE i,
        end_column    TYPE i,
        start_line    TYPE i,
        end_line      TYPE i,
        triggered_evt TYPE seocpdname,
      END OF ts_tree_view_param .
    TYPES:
      BEGIN OF ts_stack,
        name       TYPE dfies-tabname,
        list_view  TYPE REF TO zcl_mvcfw_base_salv_list_view,
        list_param TYPE REF TO ts_list_view_param,
        tree_view  TYPE REF TO zcl_mvcfw_base_salv_tree_view,
        tree_param TYPE REF TO ts_tree_view_param,
        model      TYPE REF TO zcl_mvcfw_base_salv_model,
        controller TYPE REF TO zcl_mvcfw_base_salv_controller,
        is_main    TYPE flag,
        is_current TYPE flag,
        line       TYPE sy-index,
      END OF ts_stack .
    TYPES:
      BEGIN OF ts_stack_name,
        line TYPE sy-index,
        name TYPE dfies-tabname,
      END OF ts_stack_name .
    TYPES:
      tt_stack TYPE TABLE OF ts_stack WITH EMPTY KEY
                                               WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .
    TYPES:
      tt_stack_name TYPE TABLE OF ts_stack_name WITH EMPTY KEY
                                                         WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .

    CONSTANTS c_stack_main TYPE dfies-tabname VALUE 'MAIN' ##NO_TEXT.
    CONSTANTS c_deflt_cntl TYPE seoclsname VALUE 'LCL_CONTROLLER' ##NO_TEXT.
    CONSTANTS c_deflt_model TYPE seoclsname VALUE 'LCL_MODEL' ##NO_TEXT.
    CONSTANTS c_deflt_view TYPE seoclsname VALUE 'LCL_VIEW' ##NO_TEXT.
    CONSTANTS c_deflt_list_view TYPE seoclsname VALUE 'LCL_LIST_VIEW' ##NO_TEXT.
    CONSTANTS c_deflt_tree_view TYPE seoclsname VALUE 'LCL_TREE_VIEW' ##NO_TEXT.
    CONSTANTS c_deflt_sscr TYPE seoclsname VALUE 'LCL_SSCR' ##NO_TEXT.
    CONSTANTS c_deflt_outtab TYPE dfies-tabname VALUE 'MT_OUTTAB' ##NO_TEXT.
    CONSTANTS c_display_salv_list TYPE salv_de_constant VALUE 1 ##NO_TEXT.
    CONSTANTS c_display_salv_tree TYPE salv_de_constant VALUE 2 ##NO_TEXT.
    CONSTANTS c_display_salv_hierseq TYPE salv_de_constant VALUE 3 ##NO_TEXT.
    DATA o_sscr TYPE REF TO zcl_mvcfw_base_sscr READ-ONLY .
    DATA o_model TYPE REF TO zcl_mvcfw_base_salv_model READ-ONLY .
    DATA o_list_view TYPE REF TO zcl_mvcfw_base_salv_list_view READ-ONLY .
    DATA o_tree_view TYPE REF TO zcl_mvcfw_base_salv_tree_view READ-ONLY .
    CONSTANTS c_list_link_click TYPE seocpdname VALUE 'HANDLE_LIST_LINK_CLICK' ##NO_TEXT.
    CONSTANTS c_list_double_click TYPE seocpdname VALUE 'HANDLE_LIST_DOUBLE_CLICK' ##NO_TEXT.
    CONSTANTS c_list_add_function TYPE seocpdname VALUE 'HANDLE_LIST_ADD_FUNCTION' ##NO_TEXT.
    CONSTANTS c_list_after_function TYPE seocpdname VALUE 'HANDLE_LIST_AFTER_FUNCTION' ##NO_TEXT.
    CONSTANTS c_list_before_function TYPE seocpdname VALUE 'HANDLE_LIST_BEFORE_FUNCTION' ##NO_TEXT.
    CONSTANTS c_list_end_of_page TYPE seocpdname VALUE 'HANDLE_LIST_END_OF_PAGE' ##NO_TEXT.
    CONSTANTS c_list_top_of_page TYPE seocpdname VALUE 'HANDLE_LIST_TOP_OF_PAGE' ##NO_TEXT.
    CONSTANTS c_list_check_changed_data TYPE seocpdname VALUE 'HANDLE_LIST_CHECK_CHANGED_DATA' ##NO_TEXT.
    CONSTANTS c_tree_link_click TYPE seocpdname VALUE 'HANDLE_TREE_LINK_CLICK' ##NO_TEXT.
    CONSTANTS c_tree_double_click TYPE seocpdname VALUE 'HANDLE_TREE_DOUBLE_CLICK' ##NO_TEXT.
    CONSTANTS c_tree_keypress TYPE seocpdname VALUE 'HANDLE_TREE_KEYPRESS' ##NO_TEXT.
    CONSTANTS c_tree_checkbox_change TYPE seocpdname VALUE 'HANDLE_TREE_CHECKBOX_CHANGE' ##NO_TEXT.
    CONSTANTS c_tree_expand_empty_foldr TYPE seocpdname VALUE 'HANDLE_TREE_EXPAND_EMPTY_FOLDR' ##NO_TEXT.
    CONSTANTS c_tree_add_function TYPE seocpdname VALUE 'HANDLE_TREE_ADD_FUNCTION' ##NO_TEXT.
    CONSTANTS c_tree_after_function TYPE seocpdname VALUE 'HANDLE_TREE_AFTER_FUNCTION' ##NO_TEXT.
    CONSTANTS c_tree_before_function TYPE seocpdname VALUE 'HANDLE_TREE_BEFORE_FUNCTION' ##NO_TEXT.
    CONSTANTS c_tree_end_of_page TYPE seocpdname VALUE 'HANDLE_TREE_END_OF_PAGE' ##NO_TEXT.
    CONSTANTS c_tree_top_of_page TYPE seocpdname VALUE 'HANDLE_TREE_TOP_OF_PAGE' ##NO_TEXT.

    METHODS constructor
      IMPORTING
        !iv_stack_name TYPE dfies-tabname DEFAULT c_stack_main
        !iv_cntl_name  TYPE seoclsname DEFAULT c_deflt_cntl
        !iv_modl_name  TYPE seoclsname DEFAULT c_deflt_model
        !iv_view_name  TYPE seoclsname DEFAULT c_deflt_view
        !iv_sscr_name  TYPE seoclsname DEFAULT c_deflt_sscr .
    METHODS display
      IMPORTING
        !iv_display_type     TYPE salv_de_constant DEFAULT c_display_salv_list
        !iv_list_display     TYPE sap_bool OPTIONAL
        !ir_container        TYPE REF TO cl_gui_container OPTIONAL
        !iv_container_name   TYPE string OPTIONAL
        !iv_hide_header      TYPE sap_bool OPTIONAL
        !iv_pfstatus         TYPE sypfkey OPTIONAL
        !iv_variant          TYPE slis_vari OPTIONAL
        !iv_start_column     TYPE i OPTIONAL
        !iv_end_column       TYPE i OPTIONAL
        !iv_start_line       TYPE i OPTIONAL
        !iv_end_line         TYPE i OPTIONAL
      CHANGING
        !ct_data             TYPE REF TO data OPTIONAL
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller
      RAISING
        zbcx_exception .
    METHODS create_new_view_instance
      IMPORTING
        !iv_display_type     TYPE salv_de_constant DEFAULT c_display_salv_list
        !iv_stack_name       TYPE dfies-tabname OPTIONAL
        !io_model            TYPE REF TO zcl_mvcfw_base_salv_model OPTIONAL
        !io_list_view        TYPE REF TO zcl_mvcfw_base_salv_list_view OPTIONAL
        !io_tree_view        TYPE REF TO zcl_mvcfw_base_salv_tree_view OPTIONAL
        !io_controller       TYPE REF TO zcl_mvcfw_base_salv_controller OPTIONAL
        !ir_event_list       TYPE REF TO zcl_mvcfw_base_salv_model=>ts_evt_list_param OPTIONAL
        !ir_event_tree       TYPE REF TO zcl_mvcfw_base_salv_model=>ts_evt_tree_param OPTIONAL
        !iv_display          TYPE flag OPTIONAL
        !iv_destroy          TYPE flag OPTIONAL
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
    METHODS populate_setup_before_display
      IMPORTING
        !iv_display_type TYPE salv_de_constant OPTIONAL
        !iv_stack_name   TYPE dfies-tabname OPTIONAL
      CHANGING
        !cr_list_param   TYPE REF TO ts_list_view_param OPTIONAL
        !cr_tree_param   TYPE REF TO ts_tree_view_param OPTIONAL
        !ct_data         TYPE REF TO data OPTIONAL .
    METHODS get_current_stack_name
      RETURNING
        VALUE(rv_current_stack) TYPE dfies-tabname .
    METHODS set_stack_name
      IMPORTING
        !iv_stack_name       TYPE dfies-tabname
        !io_model            TYPE REF TO zcl_mvcfw_base_salv_model OPTIONAL
        !io_list_view        TYPE REF TO zcl_mvcfw_base_salv_list_view OPTIONAL
        !io_tree_view        TYPE REF TO zcl_mvcfw_base_salv_tree_view OPTIONAL
        !io_controller       TYPE REF TO zcl_mvcfw_base_salv_controller OPTIONAL
        !iv_not_checked      TYPE flag OPTIONAL
      EXPORTING
        VALUE(ev_stack_name) TYPE dfies-tabname
        !eo_controller       TYPE REF TO zcl_mvcfw_base_salv_controller .
    METHODS destroy_stack
      IMPORTING
        !iv_name         TYPE dfies-tabname OPTIONAL
        !iv_current_name TYPE dfies-tabname OPTIONAL .
    METHODS set_extended_grid_api_events
      IMPORTING
        !iv_stack_name TYPE dfies-tabname OPTIONAL
        !ir_view       TYPE REF TO zcl_mvcfw_base_salv_list_view .
    METHODS get_stack_by_name
      IMPORTING
        !iv_stack_name  TYPE dfies-tabname
      RETURNING
        VALUE(rs_stack) TYPE REF TO ts_stack .
    METHODS get_all_stack
      RETURNING
        VALUE(rt_stack) TYPE tt_stack .
    METHODS get_salv_parameters
      RETURNING
        VALUE(ro_salv_param) TYPE REF TO ts_list_view_param .
    METHODS get_instance_by_stack_name
      IMPORTING
        !iv_stack_name       TYPE dfies-tabname OPTIONAL
        !iv_create_new       TYPE flag DEFAULT abap_true
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
    METHODS process_any_model
      IMPORTING
        !iv_method TYPE seoclsname
        !it_param  TYPE abap_parmbind_tab OPTIONAL
        !it_excpt  TYPE abap_excpbind_tab OPTIONAL
      RAISING
        zbcx_exception .
    METHODS handle_sscr_pbo
      IMPORTING
        !iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr .
    METHODS handle_sscr_pai
      IMPORTING
        !iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr .
    METHODS handle_list_link_click
      FOR EVENT evt_link_click OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !row
        !column
        !list_view
        !model .
    METHODS handle_list_double_click
      FOR EVENT evt_double_click OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !row
        !column
        !list_view
        !model .
    METHODS handle_list_add_function
      FOR EVENT evt_added_function OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !e_salv_function
        !list_view
        !model .
    METHODS handle_list_after_function
      FOR EVENT evt_after_salv_function OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !e_salv_function
        !list_view
        !model .
    METHODS handle_list_before_function
      FOR EVENT evt_before_salv_function OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !e_salv_function
        !list_view
        !model .
    METHODS handle_list_end_of_page
      FOR EVENT evt_end_of_page OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !r_end_of_page
        !page
        !list_view
        !model .
    METHODS handle_list_top_of_page
      FOR EVENT evt_top_of_page OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !r_top_of_page
        !page
        !table_index
        !list_view
        !model .
    METHODS handle_list_check_changed_data
      FOR EVENT evt_check_changed_data OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !t_modified_cells
        !t_good_cells
        !t_deleted_rows
        !t_inserted_rows
        !rt_modified_data_rows
        !o_ui_data_modify
        !o_ui_edit_protocol
        !o_editable_restricted
        !list_view
        !model .
    METHODS handle_list_f4_request
      FOR EVENT evt_f4_request OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !fieldname
        !fieldvalue
        !s_row_no
        !t_bad_cells
        !display
        !xrt_f4_data
        !event_handled
        !list_view
        !model .
    METHODS handle_list_context_menu
      FOR EVENT evt_context_menu OF zcl_mvcfw_base_salv_list_view
      IMPORTING
        !xo_context_menu
        !list_view
        !model .
    METHODS handle_tree_link_click
      FOR EVENT evt_link_click OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !columnname
        !node_key
        !tree_view
        !model .
    METHODS handle_tree_double_click
      FOR EVENT evt_double_click OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !node_key
        !columnname
        !tree_view
        !model .
    METHODS handle_tree_keypress
      FOR EVENT evt_keypress OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !node_key
        !columnname
        !key
        !tree_view
        !model .
    METHODS handle_tree_checkbox_change
      FOR EVENT evt_checkbox_change OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !columnname
        !node_key
        !checked
        !tree_view
        !model .
    METHODS handle_tree_expand_empty_foldr
      FOR EVENT evt_expand_empty_folder OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !node_key
        !tree_view
        !model .
    METHODS handle_tree_add_function
      FOR EVENT evt_added_function OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !e_salv_function
        !tree_view
        !model .
    METHODS handle_tree_after_function
      FOR EVENT evt_after_salv_function OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !e_salv_function
        !tree_view
        !model .
    METHODS handle_tree_before_function
      FOR EVENT evt_before_salv_function OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !e_salv_function
        !tree_view
        !model .
    METHODS handle_tree_end_of_page
      FOR EVENT evt_end_of_page OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !r_end_of_page
        !page
        !tree_view
        !model .
    METHODS handle_tree_top_of_page
      FOR EVENT evt_top_of_page OF zcl_mvcfw_base_salv_tree_view
      IMPORTING
        !r_top_of_page
        !page
        !table_index
        !tree_view
        !model .
    METHODS auto_generated_stack_name
      RETURNING
        VALUE(rv_stack_name) TYPE dfies-tabname .
    METHODS redraw_salv_list
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
    METHODS get_list_parameters
      RETURNING
        VALUE(rv_value) TYPE ts_list_view_param .
    METHODS get_tree_parameters
      RETURNING
        VALUE(rv_value) TYPE ts_tree_view_param .
    METHODS get_direct_outtab
      EXPORTING
        !er_data             TYPE REF TO data
        !ev_is_direct_outtab TYPE flag .
    METHODS set_direct_outtab
      IMPORTING
        !ir_data             TYPE REF TO data
      EXPORTING
        !er_data             TYPE REF TO data
        !ev_is_direct_outtab TYPE flag .
    METHODS clear_direct_outtab .
  PROTECTED SECTION.

    CLASS-DATA mt_stack_called TYPE tt_stack_name .
    DATA mo_controller TYPE REF TO zcl_mvcfw_base_salv_controller .
    CLASS-DATA mt_stack TYPE tt_stack .
    CONSTANTS mc_obj_model TYPE seoclsname VALUE 'MODEL' ##NO_TEXT.
    CONSTANTS mc_obj_list_view TYPE seoclsname VALUE 'LIST_VIEW' ##NO_TEXT.
    CONSTANTS mc_obj_tree_view TYPE seoclsname VALUE 'TREE_VIEW' ##NO_TEXT.
    DATA mv_cl_view_name TYPE char30 .
    DATA mv_cl_modl_name TYPE char30 .
    DATA mv_cl_sscr_name TYPE char30 .
    DATA mv_cl_cntl_name TYPE char30 .
    DATA mt_direct_outtab TYPE REF TO data .
    DATA mv_current_stack TYPE dfies-tabname VALUE 'MAIN' ##NO_TEXT.

    METHODS _display_salv_list
      CHANGING
        !ct_data TYPE REF TO data OPTIONAL
      RAISING
        zbcx_exception .
    METHODS _display_salv_tree
      IMPORTING
        !iv_create_directly TYPE sap_bool OPTIONAL
      CHANGING
        !ct_data            TYPE REF TO data OPTIONAL
      RAISING
        zbcx_exception .
    METHODS _set_salv_list_events
      IMPORTING
        !io_view             TYPE REF TO zcl_mvcfw_base_salv_list_view
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
    METHODS _set_salv_tree_events
      IMPORTING
        !io_view             TYPE REF TO zcl_mvcfw_base_salv_tree_view
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
    METHODS _get_current_stack
      RETURNING
        VALUE(re_current_stack) TYPE dfies-tabname .
    METHODS _set_checkbox_on_click
      IMPORTING
        !row       TYPE salv_de_row
        !column    TYPE salv_de_column
        !list_view TYPE REF TO zcl_mvcfw_base_salv_list_view OPTIONAL
        !model     TYPE REF TO zcl_mvcfw_base_salv_model OPTIONAL .
  PRIVATE SECTION.

    TYPES:
      BEGIN OF lty_class_type,
        sscr       TYPE flag,
        model      TYPE flag,
        salv_view  TYPE flag,
        tree_view  TYPE flag,
        controller TYPE flag,
      END OF lty_class_type .

    DATA mr_list_param TYPE REF TO ts_list_view_param .
    DATA mr_tree_param TYPE REF TO ts_tree_view_param .
    DATA mv_triggered_evt TYPE seocpdname .
    CONSTANTS mc_base_cntl TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_SALV_CONTROLLER' ##NO_TEXT.
    CONSTANTS mc_base_model TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_SALV_MODEL' ##NO_TEXT.
    CONSTANTS mc_base_salv_view TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_SALV_LIST_VIEW' ##NO_TEXT.
    CONSTANTS mc_base_tree_view TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_SALV_TREE_VIEW' ##NO_TEXT.
    CONSTANTS mc_base_sscr TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_SSCR' ##NO_TEXT.
    DATA mv_is_direct_outtab TYPE flag .
    DATA mv_set_destroy TYPE flag .

    METHODS _validate_display_type
      IMPORTING
        !iv_display_type       TYPE salv_de_constant
      RETURNING
        VALUE(rv_display_type) TYPE salv_de_constant .
    METHODS _setup_parameters_to_list
      IMPORTING
        !iv_stack_name       TYPE dfies-tabname OPTIONAL
        !iv_list_display     TYPE sap_bool OPTIONAL
        !ir_container        TYPE REF TO cl_gui_container OPTIONAL
        !iv_container_name   TYPE string OPTIONAL
        !iv_pfstatus         TYPE sypfkey OPTIONAL
        !iv_variant          TYPE slis_vari OPTIONAL
        !iv_start_column     TYPE i OPTIONAL
        !iv_end_column       TYPE i OPTIONAL
        !iv_start_line       TYPE i OPTIONAL
        !iv_end_line         TYPE i OPTIONAL
      EXPORTING
        !er_stack            TYPE REF TO ts_stack
        !er_view_param       TYPE REF TO ts_list_view_param
      CHANGING
        !ct_data             TYPE REF TO data OPTIONAL
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller
      RAISING
        zbcx_exception .
    METHODS _setup_parameters_to_tree
      IMPORTING
        !iv_stack_name       TYPE dfies-tabname OPTIONAL
        !ir_container        TYPE REF TO cl_gui_container OPTIONAL
        !iv_hide_header      TYPE sap_bool OPTIONAL
        !iv_pfstatus         TYPE sypfkey OPTIONAL
        !iv_variant          TYPE slis_vari OPTIONAL
        !iv_start_column     TYPE i OPTIONAL
        !iv_end_column       TYPE i OPTIONAL
        !iv_start_line       TYPE i OPTIONAL
        !iv_end_line         TYPE i OPTIONAL
      EXPORTING
        !er_stack            TYPE REF TO ts_stack
      CHANGING
        !ct_data             TYPE REF TO data OPTIONAL
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller
      RAISING
        zbcx_exception .
    METHODS _check_setup_before_display
      IMPORTING
        !iv_display_type TYPE salv_de_constant
      CHANGING
        !cr_list_param   TYPE REF TO ts_list_view_param OPTIONAL
        !cr_tree_param   TYPE REF TO ts_tree_view_param OPTIONAL .
    METHODS _create_any_object
      IMPORTING
        !iv_class_name  TYPE seoclsname
        !is_class_type  TYPE lty_class_type
      EXPORTING
        !ev_class_name  TYPE seoclsname
      RETURNING
        VALUE(ro_class) TYPE REF TO object .
    METHODS _build_stack
      IMPORTING
        !iv_name            TYPE dfies-tabname
        !io_model           TYPE REF TO zcl_mvcfw_base_salv_model OPTIONAL
        !io_list_view       TYPE REF TO zcl_mvcfw_base_salv_list_view OPTIONAL
        !ir_list_view_param TYPE REF TO ts_list_view_param OPTIONAL
        !io_tree_view       TYPE REF TO zcl_mvcfw_base_salv_tree_view OPTIONAL
        !ir_tree_view_param TYPE REF TO ts_tree_view_param OPTIONAL
        !io_controller      TYPE REF TO zcl_mvcfw_base_salv_controller OPTIONAL .
    METHODS _get_stack
      IMPORTING
        !iv_name        TYPE dfies-tabname
      RETURNING
        VALUE(rs_stack) TYPE REF TO ts_stack .
    METHODS _set_dynp_stack_name
      IMPORTING
        !io_stack            TYPE REF TO ts_stack
        !iv_object_name      TYPE dfies-tabname
        !iv_stack_name       TYPE dfies-tabname
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
    METHODS _get_outtab_model
      IMPORTING
        !iv_force_model  TYPE flag OPTIONAL
      RETURNING
        VALUE(ro_outtab) TYPE REF TO data .
    METHODS _set_model
      IMPORTING
        !io_model         TYPE REF TO zcl_mvcfw_base_salv_model
      EXPORTING
        !eo_model         TYPE REF TO zcl_mvcfw_base_salv_model
        !eo_current_model TYPE REF TO zcl_mvcfw_base_salv_model .
    METHODS _set_view
      IMPORTING
        !io_list_view         TYPE REF TO zcl_mvcfw_base_salv_list_view OPTIONAL
        !io_tree_view         TYPE REF TO zcl_mvcfw_base_salv_tree_view OPTIONAL
      EXPORTING
        !eo_list_view         TYPE REF TO zcl_mvcfw_base_salv_list_view
        !eo_current_list_view TYPE REF TO zcl_mvcfw_base_salv_list_view
        !eo_tree_view         TYPE REF TO zcl_mvcfw_base_salv_tree_view
        !eo_current_tree_view TYPE REF TO zcl_mvcfw_base_salv_tree_view .
    METHODS _get_abap_call_stack
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
    METHODS _get_instance
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
    METHODS _set_events_param_to_model
      IMPORTING
        !io_model            TYPE REF TO zcl_mvcfw_base_salv_model
        !ir_event_list       TYPE REF TO zcl_mvcfw_base_salv_model=>ts_evt_list_param OPTIONAL
        !ir_event_tree       TYPE REF TO zcl_mvcfw_base_salv_model=>ts_evt_tree_param OPTIONAL
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_SALV_CONTROLLER IMPLEMENTATION.


  METHOD constructor.
*--------------------------------------------------------------------*
*
*   Parent_Class =  Child_Class   (Narrow/Up Casting)
*   Child_Class  ?= Parent_Class  (Widening/Down Casting)
*
*--------------------------------------------------------------------*
    TRY.
        o_sscr  = CAST #( _create_any_object( EXPORTING iv_class_name = iv_sscr_name
                                                        is_class_type = VALUE #( sscr = abap_true )
                                              IMPORTING ev_class_name = mv_cl_sscr_name ) ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        o_model = CAST #( _create_any_object( EXPORTING iv_class_name = iv_modl_name
                                                        is_class_type = VALUE #( model = abap_true )
                                              IMPORTING ev_class_name = mv_cl_modl_name ) ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        o_list_view  = CAST #( _create_any_object( EXPORTING iv_class_name = iv_view_name
                                                             is_class_type = VALUE #( salv_view = abap_true )
                                                   IMPORTING ev_class_name = mv_cl_view_name ) ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        o_tree_view  = CAST #( _create_any_object( EXPORTING iv_class_name = iv_view_name
                                                             is_class_type = VALUE #( tree_view = abap_true )
                                                   IMPORTING ev_class_name = mv_cl_view_name ) ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.

    mv_current_stack = COND #( WHEN iv_stack_name IS NOT INITIAL THEN |{ iv_stack_name CASE = UPPER }|
                                ELSE auto_generated_stack_name( ) ).
    mo_controller    = me.
  ENDMETHOD.


  METHOD create_new_view_instance.
    DATA: lo_model_imp     TYPE REF TO zcl_mvcfw_base_salv_model,
          lo_list_view_imp TYPE REF TO zcl_mvcfw_base_salv_list_view,
          lo_tree_view_imp TYPE REF TO zcl_mvcfw_base_salv_tree_view.
    DATA: lo_model      TYPE REF TO zcl_mvcfw_base_salv_model,
          lo_list_view  TYPE REF TO zcl_mvcfw_base_salv_list_view,
          lo_tree_view  TYPE REF TO zcl_mvcfw_base_salv_tree_view,
          lo_controller TYPE REF TO zcl_mvcfw_base_salv_controller.
    DATA: lv_stack_name TYPE dfies-tabname.

    ro_controller = me.

    lv_stack_name = COND #( WHEN iv_stack_name IS NOT INITIAL THEN |{ iv_stack_name CASE = UPPER }|
                            ELSE auto_generated_stack_name( ) ).
    lo_controller = COND #( WHEN io_controller  IS BOUND THEN io_controller
                            ELSE _get_instance( ) ).

    "--------------------------------------------------------------------"
    TRY.
        lo_model_imp = COND #( WHEN io_model IS BOUND THEN io_model
                               ELSE o_model ).
      CATCH cx_sy_move_cast_error.
        lo_model_imp = o_model.
    ENDTRY.

    lo_model = CAST #( lo_model_imp ).

    "--------------------------------------------------------------------"
    TRY.
        lo_list_view_imp = COND #( WHEN io_list_view IS BOUND THEN io_list_view
                                   ELSE o_list_view ).
      CATCH cx_sy_move_cast_error.
        lo_list_view_imp = o_list_view.
    ENDTRY.
    TRY.
        lo_tree_view_imp = COND #( WHEN io_tree_view IS BOUND THEN io_tree_view
                                   ELSE o_tree_view ).
      CATCH cx_sy_move_cast_error.
        lo_tree_view_imp = o_tree_view.
    ENDTRY.

    IF lo_list_view_imp IS BOUND.
      lo_list_view = CAST #( lo_list_view_imp->clone( ) ).
    ENDIF.
    IF lo_tree_view_imp IS BOUND.
      lo_tree_view = CAST #( lo_tree_view_imp->clone( ) ).
    ENDIF.

    "--------------------------------------------------------------------"
    _get_abap_call_stack( )->_set_events_param_to_model( io_model      = lo_model
                                                         ir_event_list = ir_event_list
                                                         ir_event_tree = ir_event_tree ).

    "--------------------------------------------------------------------"
    set_stack_name( EXPORTING iv_stack_name  = lv_stack_name
                              io_model       = lo_model
                              io_list_view   = lo_list_view
                              io_tree_view   = lo_tree_view
                              io_controller  = lo_controller
                              iv_not_checked = space ).
    IF iv_display    IS NOT INITIAL
   AND lo_controller IS BOUND.
      TRY.
          lo_controller->display( EXPORTING iv_display_type = iv_display_type ).

          IF iv_destroy    IS NOT INITIAL
         AND lo_controller IS BOUND.
            lo_controller->destroy_stack( ).
            mv_set_destroy = iv_destroy.
          ENDIF.
        CATCH zbcx_exception.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD destroy_stack.
    DATA: ls_stack_called LIKE LINE OF mt_stack_called,
          ls_stack        LIKE LINE OF mt_stack.
    FIELD-SYMBOLS <lfs_stack_called> LIKE LINE OF mt_stack_called.

    "--------------------------------------------------------------------"
    " Delete lastest stack
    "--------------------------------------------------------------------"
    IF iv_name IS INITIAL.
      READ TABLE mt_stack_called INTO ls_stack_called INDEX lines( mt_stack_called ).
      IF sy-subrc EQ 0.
        DELETE: mt_stack_called WHERE line EQ ls_stack_called-line,
                mt_stack        WHERE name EQ ls_stack_called-name.
      ENDIF.

      "--------------------------------------------------------------------"
      " Read and set previous stack
      "--------------------------------------------------------------------"
      READ TABLE mt_stack_called INTO ls_stack_called INDEX lines( mt_stack_called ).
      IF sy-subrc EQ 0.
        READ TABLE mt_stack INTO ls_stack
          WITH KEY k2
            COMPONENTS name = ls_stack_called-name.
        IF sy-subrc EQ 0.
          mo_controller  = ls_stack-controller.
          o_model        = ls_stack-model.
          o_list_view    = ls_stack-list_view.
          o_tree_view    = ls_stack-tree_view.

          set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                    io_model       = o_model
                                    io_list_view   = o_list_view
                                    io_tree_view   = o_tree_view
                                    iv_not_checked = abap_true ).
        ENDIF.
      ENDIF.
    ELSE.
      "--------------------------------------------------------------------"
      " Delete stack with specific stack name
      "--------------------------------------------------------------------"
      READ TABLE mt_stack_called INTO ls_stack_called
        WITH KEY k2
          COMPONENTS name = |{ iv_name CASE = UPPER }|.
      IF sy-subrc EQ 0.
        DELETE: mt_stack_called WHERE line EQ ls_stack_called-line,
                mt_stack        WHERE name EQ ls_stack_called-name.
      ENDIF.

      "--------------------------------------------------------------------"
      " Read and set previous stack
      "--------------------------------------------------------------------"
      SORT mt_stack_called BY line.

      LOOP AT mt_stack_called ASSIGNING <lfs_stack_called>.
        <lfs_stack_called>-line = sy-tabix.
      ENDLOOP.

      IF iv_current_name IS NOT INITIAL.
        READ TABLE mt_stack_called  INTO ls_stack_called
          WITH KEY k2
            COMPONENTS name = |{ iv_current_name CASE = UPPER }|.
        IF sy-subrc NE 0.
          READ TABLE mt_stack_called INTO ls_stack_called INDEX lines( mt_stack_called ).
        ENDIF.
        IF sy-subrc EQ 0.
          READ TABLE mt_stack INTO ls_stack
            WITH KEY k2
              COMPONENTS name = ls_stack_called-name.
          IF sy-subrc EQ 0.
            mo_controller  = ls_stack-controller.
            o_model        = ls_stack-model.
            o_list_view    = ls_stack-list_view.
            o_tree_view    = ls_stack-tree_view.

            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = o_model
                                      io_list_view   = o_list_view
                                      io_tree_view   = o_tree_view
                                      iv_not_checked = abap_true ).
          ENDIF.
        ENDIF.
      ELSE.
        READ TABLE mt_stack_called INTO ls_stack_called INDEX lines( mt_stack_called ).
        IF sy-subrc EQ 0.
          READ TABLE mt_stack INTO ls_stack
            WITH KEY k2
              COMPONENTS name = ls_stack_called-name.
          IF sy-subrc EQ 0.
            mo_controller  = ls_stack-controller.
            o_model        = ls_stack-model.
            o_list_view    = ls_stack-list_view.
            o_tree_view    = ls_stack-tree_view.

            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = o_model
                                      io_list_view   = o_list_view
                                      io_tree_view   = o_tree_view
                                      iv_not_checked = abap_true ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

    "--------------------------------------------------------------------"
    " Try to replace SALV parameters with previous parameters
    "--------------------------------------------------------------------"
    READ TABLE mt_stack INTO ls_stack WITH KEY is_current = abap_true.
    IF sy-subrc EQ 0.
      mr_list_param = COND #( WHEN ls_stack-list_param IS BOUND THEN ls_stack-list_param ELSE NEW #( ) ).
    ENDIF.
  ENDMETHOD.


  METHOD display.
    DATA lo_except TYPE REF TO zbcx_exception.
    DATA lv_display_type TYPE salv_de_constant.

    ro_controller   = me.
    lv_display_type = _validate_display_type( iv_display_type ).

    IF ct_data IS SUPPLIED AND ct_data IS BOUND.
      me->set_direct_outtab( EXPORTING ir_data             = ct_data
                             IMPORTING er_data             = me->mt_direct_outtab
                                       ev_is_direct_outtab = me->mv_is_direct_outtab ).
    ELSE.
      me->clear_direct_outtab( ).
    ENDIF.

    CASE lv_display_type.
      WHEN c_display_salv_list.
        TRY.
            me->_setup_parameters_to_list(
              EXPORTING
                iv_stack_name     = mv_current_stack
                iv_list_display   = iv_list_display
                ir_container      = ir_container
                iv_container_name = iv_container_name
                iv_pfstatus       = iv_pfstatus
                iv_variant        = iv_variant
                iv_start_column   = iv_start_column
                iv_end_column     = iv_end_column
                iv_start_line     = iv_start_line
                iv_end_line       = iv_end_line
              CHANGING
                ct_data           = me->mt_direct_outtab ).

            me->_display_salv_list(
              CHANGING
                ct_data = me->mt_direct_outtab ).
          CATCH zbcx_exception INTO lo_except.
            RAISE EXCEPTION TYPE zbcx_exception
              EXPORTING
                msgv1 = lo_except->msgv1.
        ENDTRY.
      WHEN c_display_salv_tree.
        TRY.
            me->_setup_parameters_to_tree(
              EXPORTING
                iv_stack_name     = mv_current_stack
                ir_container      = ir_container
                iv_hide_header    = iv_hide_header
                iv_pfstatus       = iv_pfstatus
                iv_variant        = iv_variant
                iv_start_column   = iv_start_column
                iv_end_column     = iv_end_column
                iv_start_line     = iv_start_line
                iv_end_line       = iv_end_line
              CHANGING
                ct_data           = me->mt_direct_outtab ).

            me->_display_salv_tree(
              EXPORTING
                iv_create_directly = COND #( WHEN ct_data IS SUPPLIED THEN abap_true ELSE abap_false )
              CHANGING
                ct_data            = me->mt_direct_outtab ).
          CATCH zbcx_exception INTO lo_except.
            RAISE EXCEPTION TYPE zbcx_exception
              EXPORTING
                msgv1 = lo_except->msgv1.
        ENDTRY.
*      WHEN mc_display_salv_hierseq.
*        "Not Avaiable
      WHEN OTHERS.
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'Invalid display list type'.
    ENDCASE.

    IF mv_set_destroy IS NOT INITIAL.
      me->destroy_stack( ).
      CLEAR mv_set_destroy.
    ENDIF.
  ENDMETHOD.


  METHOD get_all_stack.
    rt_stack = mt_stack.
  ENDMETHOD.


  METHOD get_current_stack_name.
    rv_current_stack = _get_current_stack( ).
  ENDMETHOD.


  METHOD get_salv_parameters.
    ro_salv_param = mr_list_param.
  ENDMETHOD.


  METHOD get_stack_by_name.
    CHECK iv_stack_name IS NOT INITIAL.

    rs_stack = me->_get_stack( EXPORTING iv_name = iv_stack_name ).
  ENDMETHOD.


  METHOD handle_list_add_function.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_list_after_function.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_list_before_function.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_list_check_changed_data.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_list_context_menu.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_list_double_click.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_list_end_of_page.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_list_f4_request.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_list_link_click.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
    IF column = 'CHKBOX'.
      me->_set_checkbox_on_click( row       = row
                                  column    = column
                                  list_view = list_view
                                  model     = model ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_list_top_of_page.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_LIST_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_sscr_pai.
    IF o_sscr IS NOT BOUND.
      o_sscr = NEW #( ).
    ENDIF.
    IF o_sscr IS BOUND.
      o_sscr->pai( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_sscr_pbo.
    IF o_sscr IS NOT BOUND.
      o_sscr = NEW #( ).
    ENDIF.
    IF o_sscr IS BOUND.
      o_sscr->pbo( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_tree_add_function.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_tree_after_function.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_tree_before_function.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_tree_checkbox_change.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_tree_double_click.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_tree_end_of_page.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_tree_expand_empty_foldr.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_tree_keypress.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_tree_link_click.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD handle_tree_top_of_page.
*--------------------------------------------------------------------*
* Handler event from ZCL_MVCFW_BASE_SALV_TREE_VIEW
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD populate_setup_before_display.
  ENDMETHOD.


  METHOD process_any_model.
    DATA lv_method TYPE seoclsname.

    IF o_model IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Model was not created'.
    ENDIF.

    TRY.
        lv_method = |{ iv_method CASE = UPPER }|.

        IF it_param IS SUPPLIED AND it_param IS NOT INITIAL
       AND it_excpt IS SUPPLIED AND it_excpt IS NOT INITIAL.
          CALL METHOD o_model->(lv_method)
            PARAMETER-TABLE it_param
            EXCEPTION-TABLE it_excpt.
        ELSEIF it_param IS SUPPLIED AND it_param IS NOT INITIAL.
          CALL METHOD o_model->(lv_method)
            PARAMETER-TABLE it_param.
        ELSE.
          CALL METHOD o_model->(lv_method).
        ENDIF.
      CATCH cx_sy_no_handler
            cx_sy_dyn_call_excp_not_found
            cx_sy_dyn_call_illegal_class
            cx_sy_dyn_call_illegal_method
            cx_sy_dyn_call_illegal_type
            cx_sy_dyn_call_param_missing
            cx_sy_dyn_call_param_not_found
            cx_sy_ref_is_initial
        INTO DATA(lo_except).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = CONV #( lo_except->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD set_stack_name.
    CHECK iv_stack_name IS NOT INITIAL.

    mv_current_stack = |{ iv_stack_name CASE = UPPER }|.
    ev_stack_name     = _get_current_stack( ).

    IF io_model IS BOUND.
      io_model->set_stack_name( mv_current_stack ).
    ENDIF.

    IF io_list_view IS BOUND.
      io_list_view->set_stack_name( mv_current_stack ).
    ENDIF.

    IF io_tree_view IS BOUND.
      io_tree_view->set_stack_name( mv_current_stack ).
    ENDIF.

    IF iv_not_checked IS INITIAL.
      _build_stack( iv_name       = _get_current_stack( )   "'MAIN'
                    io_model      = io_model
                    io_list_view  = io_list_view
                    io_tree_view  = io_tree_view
                    io_controller = io_controller ).
    ELSE.
      LOOP AT mt_stack ASSIGNING FIELD-SYMBOL(<lfs_stack>).
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( mt_stack ) THEN abap_true ).
      ENDLOOP.
    ENDIF.

    IF eo_controller IS SUPPLIED.
      eo_controller = get_instance_by_stack_name( ).
    ENDIF.
  ENDMETHOD.


  METHOD _build_stack.
    DATA: lo_list_view  TYPE REF TO zcl_mvcfw_base_salv_list_view,
          lo_tree_view  TYPE REF TO zcl_mvcfw_base_salv_tree_view,
          lo_model      TYPE REF TO zcl_mvcfw_base_salv_model,
          lo_controller TYPE REF TO zcl_mvcfw_base_salv_controller.
    DATA: lv_line TYPE sy-index.
    FIELD-SYMBOLS: <lfs_stack> TYPE ts_stack.

    DATA(lv_name) = |{ iv_name CASE = UPPER }|.

    IF NOT line_exists( mt_stack[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR: lo_list_view, lo_tree_view, lo_model, lo_controller, lv_line.

      lo_model      = io_model.
      lo_list_view  = io_list_view.
      lo_tree_view  = io_tree_view.
      lo_controller = COND #( WHEN io_controller  IS BOUND THEN io_controller
                              ELSE _get_instance( ) ).
      lv_line        = lines( mt_stack ) + 1.

      INSERT VALUE #( name       = COND #( WHEN lv_line EQ 1 THEN c_stack_main ELSE lv_name )
                      list_view  = lo_list_view
                      list_param = ir_list_view_param
                      tree_view  = lo_tree_view
                      tree_param = ir_tree_view_param
                      model      = lo_model
                      controller = lo_controller
                      is_main    = COND #( WHEN lv_line EQ 1 THEN abap_true )
                      line       = lv_line
                    ) INTO TABLE mt_stack.

      LOOP AT mt_stack ASSIGNING <lfs_stack>.
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( mt_stack ) THEN abap_true ).
      ENDLOOP.
    ELSE.
      IF ir_list_view_param IS SUPPLIED.
        READ TABLE mt_stack ASSIGNING <lfs_stack> WITH TABLE KEY k2 COMPONENTS name = lv_name.
        IF sy-subrc EQ 0.
          <lfs_stack>-list_param = ir_list_view_param.
        ENDIF.
      ENDIF.
      IF ir_tree_view_param IS SUPPLIED.
        READ TABLE mt_stack ASSIGNING <lfs_stack> WITH TABLE KEY k2 COMPONENTS name = lv_name.
        IF sy-subrc EQ 0.
          <lfs_stack>-tree_param = ir_tree_view_param.
        ENDIF.
      ENDIF.
    ENDIF.

    IF NOT line_exists( mt_stack_called[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR lv_line.

      lv_line = lines( mt_stack_called ) + 1.

      INSERT VALUE #( line = lv_line
                      name = COND #( WHEN lv_line EQ 1 THEN c_stack_main ELSE lv_name )
                    ) INTO TABLE mt_stack_called.
    ENDIF.
  ENDMETHOD.


  METHOD _check_setup_before_display.
    IF cr_list_param IS SUPPLIED.
      CHECK cr_list_param IS BOUND.

      IF cr_list_param->stack_name NE mv_current_stack.
        cr_list_param->stack_name = _get_current_stack( ).
      ENDIF.

      IF cr_list_param->container IS BOUND.
        CLEAR cr_list_param->list_display.
      ELSE.
        CLEAR cr_list_param->container.
        CLEAR cr_list_param->container_name.
      ENDIF.
    ELSEIF cr_tree_param IS SUPPLIED.
      CHECK cr_tree_param IS BOUND.

      IF cr_tree_param->stack_name NE mv_current_stack.
        cr_tree_param->stack_name = _get_current_stack( ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _create_any_object.
    DATA: ls_class_type TYPE lty_class_type.
    DATA: lv_object     TYPE string,
          lv_class_name TYPE char30.

    lv_class_name = |{ iv_class_name CASE = UPPER }|.
    lv_object     = |\\PROGRAM={ sy-cprog }\\CLASS={ lv_class_name }|.
    ls_class_type = is_class_type.

    TRY.
        CREATE OBJECT ro_class TYPE (lv_object).
        ev_class_name = lv_class_name.
      CATCH cx_sy_create_object_error.
        TRY.
            lv_object = COND #( WHEN ls_class_type-sscr       IS NOT INITIAL THEN mc_base_sscr
                                WHEN ls_class_type-model      IS NOT INITIAL THEN mc_base_model
                                WHEN ls_class_type-salv_view  IS NOT INITIAL THEN mc_base_salv_view
                                WHEN ls_class_type-tree_view  IS NOT INITIAL THEN mc_base_tree_view
                                WHEN ls_class_type-controller IS NOT INITIAL THEN mc_base_cntl ).
            CHECK lv_object IS NOT INITIAL.

            CREATE OBJECT ro_class TYPE (lv_object).
            ev_class_name = lv_object.
          CATCH cx_sy_create_object_error.
        ENDTRY.
    ENDTRY.
  ENDMETHOD.


  METHOD _display_salv_tree.
    DATA: lo_out TYPE REF TO data.
    DATA: lo_exct_dyn TYPE REF TO cx_root.

    mv_current_stack = COND #( WHEN mr_tree_param IS BOUND
                                 AND mr_tree_param->stack_name IS NOT INITIAL THEN mr_tree_param->stack_name
                                WHEN mv_current_stack IS NOT INITIAL THEN mv_current_stack
                                ELSE c_stack_main ).

    me->_build_stack( iv_name            = _get_current_stack( )   "Default with 'MAIN'
                      io_model           = o_model
                      io_tree_view       = o_tree_view
                      ir_tree_view_param = COND #( WHEN mr_tree_param IS BOUND THEN mr_tree_param ELSE NEW #( ) )
                      io_controller      = _get_instance( ) ).

    DATA(lo_stack) = me->_get_stack( mv_current_stack ).

    IF lo_stack IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Stack name was not found'.
    ELSE.
      o_model          = lo_stack->model.
      o_tree_view      = lo_stack->tree_view.
      mo_controller    = lo_stack->controller.
      mr_tree_param    = lo_stack->tree_param.
      mv_current_stack = lo_stack->name.
    ENDIF.

    "Set Object name for Model
    _set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                    iv_object_name = mc_obj_model
                                    iv_stack_name  = _get_current_stack( ) ).

    IF ct_data IS SUPPLIED
   AND ct_data IS BOUND.
      lo_out = ct_data.
    ELSE.
      IF lo_stack->model IS NOT BOUND.
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'Model was not found'.
      ENDIF.

      TRY.
          lo_out = lo_stack->model->get_outtab( iv_stack_name = _get_current_stack( ) ).
        CATCH cx_root INTO lo_exct_dyn.
          RAISE EXCEPTION TYPE zbcx_exception
            EXPORTING
              msgv1 = CONV #( lo_exct_dyn->get_text( ) ).
      ENDTRY.
    ENDIF.
    IF lo_out IS BOUND.
      ASSIGN lo_out->* TO FIELD-SYMBOL(<lft_out>).
      CHECK <lft_out> IS NOT INITIAL.


      "Set Object name for View
      me->_set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                          iv_object_name = mc_obj_tree_view
                                          iv_stack_name  = _get_current_stack( )
                               )->_set_salv_tree_events( EXPORTING io_view = lo_stack->tree_view ).

      IF lo_stack->tree_view IS BOUND.
        TRY.
            IF mr_tree_param IS NOT BOUND.
              mr_tree_param = NEW #( ).
            ENDIF.

            "Display ALV Tree
            lo_stack->tree_view->set_controller_listener( me )->display( EXPORTING iv_create_directly = iv_create_directly
                                                                                   ir_container       = mr_tree_param->container
                                                                                   iv_hide_header     = mr_tree_param->hide_header
                                                                                   iv_pfstatus        = mr_tree_param->pfstatus
                                                                                   iv_variant         = mr_tree_param->variant
                                                                                   iv_start_column    = mr_tree_param->start_column
                                                                                   iv_end_column      = mr_tree_param->end_column
                                                                                   iv_start_line      = mr_tree_param->start_line
                                                                                   iv_end_line        = mr_tree_param->end_line
                                                                         CHANGING  ct_data            = <lft_out> ).
          CATCH zbcx_exception INTO DATA(lo_except).
            RAISE EXCEPTION TYPE zbcx_exception
              EXPORTING
                msgv1 = CONV #( lo_except->get_text( ) ).
        ENDTRY.
      ELSE.
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'SALV Tree was not created'.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _get_abap_call_stack.
    DATA: lt_abap_callstack TYPE abap_callstack.

    CLEAR mv_triggered_evt.

    ro_controller = me.

    CALL FUNCTION 'SYSTEM_CALLSTACK'
      IMPORTING
        callstack = lt_abap_callstack.

    DELETE lt_abap_callstack WHERE mainprogram NP 'ZCL_MVCFW*'
                               AND mainprogram NE sy-cprog.
    DELETE lt_abap_callstack WHERE blocktype NE 'METHOD'.
    DELETE lt_abap_callstack WHERE blockname NP '*HANDLE*'.

    READ TABLE lt_abap_callstack INTO DATA(ls_abap_callstack) INDEX 1.
    IF sy-subrc EQ 0.
      mv_triggered_evt = ls_abap_callstack-blockname.
    ENDIF.
  ENDMETHOD.


  METHOD _get_current_stack.
    re_current_stack = mv_current_stack.
  ENDMETHOD.


  METHOD _get_outtab_model.
    DATA: lr_out TYPE REF TO data.

    CASE iv_force_model.
      WHEN abap_true.
        CHECK o_model IS BOUND.

        lr_out = o_model->get_outtab( ).
        IF lr_out IS BOUND.
          ro_outtab = lr_out.
        ENDIF.
      WHEN OTHERS.
        CASE me->mv_is_direct_outtab.
          WHEN abap_true.
            CHECK me->mt_direct_outtab IS BOUND.

            ro_outtab = me->mt_direct_outtab.
          WHEN OTHERS.
            CHECK o_model IS BOUND.

            lr_out = o_model->get_outtab( ).
            IF lr_out IS BOUND.
              ro_outtab = lr_out.
            ENDIF.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.


  METHOD _get_stack.
    TRY.
        rs_stack = REF #( mt_stack[ KEY k2 COMPONENTS name = iv_name ] ).

        IF rs_stack IS BOUND.
          me->_set_model( io_model = rs_stack->model ).
          me->_set_view( io_list_view = rs_stack->list_view
                         io_tree_view = rs_stack->tree_view ).
        ENDIF.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.


  METHOD _setup_parameters_to_tree.
    ro_controller = me.

    mr_tree_param = NEW #( stack_name   = iv_stack_name
                            container    = ir_container
                            hide_header  = iv_hide_header
                            pfstatus     = iv_pfstatus
                            variant      = iv_variant
                            start_column = iv_start_column
                            end_column   = iv_end_column
                            start_line   = iv_start_line
                            end_line     = iv_end_line ).

    populate_setup_before_display( EXPORTING iv_display_type = c_display_salv_tree
                                             iv_stack_name   = iv_stack_name
                                   CHANGING  cr_tree_param   = mr_tree_param
                                             ct_data         = ct_data ).
    _check_setup_before_display( EXPORTING iv_display_type = c_display_salv_tree
                                 CHANGING  cr_tree_param   = mr_tree_param ).
  ENDMETHOD.


  METHOD _set_dynp_stack_name.
    ro_controller = me.

    CHECK io_stack IS BOUND.

    TRY.
        CASE iv_object_name.
          WHEN mc_obj_model.
            IF io_stack->model IS BOUND.
              io_stack->model->set_stack_name( iv_stack_name ).
            ENDIF.
          WHEN mc_obj_list_view.
            IF io_stack->list_view IS BOUND.
              io_stack->list_view->set_stack_name( iv_stack_name ).

              IF io_stack->model IS BOUND.
                io_stack->list_view->set_model( io_stack->model ).
              ENDIF.
            ENDIF.
          WHEN mc_obj_tree_view.
            IF io_stack->tree_view IS BOUND.
              io_stack->tree_view->set_stack_name( iv_stack_name ).

              IF io_stack->model IS BOUND.
                io_stack->tree_view->set_model( io_stack->model ).
              ENDIF.
            ENDIF.
        ENDCASE.
      CATCH cx_sy_no_handler
            cx_sy_dyn_call_excp_not_found
            cx_sy_dyn_call_illegal_class
            cx_sy_dyn_call_illegal_method
            cx_sy_dyn_call_illegal_type
            cx_sy_dyn_call_param_missing
            cx_sy_dyn_call_param_not_found
            cx_sy_ref_is_initial
       INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD _set_events_param_to_model.
    IF io_model IS BOUND.
      "--------------------------------------------------------------------"
      " Handler for SALV List
      "--------------------------------------------------------------------"
      IF ir_event_list IS BOUND.
        CASE mv_triggered_evt.
          WHEN c_list_link_click.
            io_model->set_link_double_click_to_list( event_type = c_list_link_click
                                                     row        = ir_event_list->row_link_click
                                                     column     = ir_event_list->column_link_click ).
          WHEN c_list_double_click.
            io_model->set_link_double_click_to_list( event_type = c_list_double_click
                                                     row        = ir_event_list->row_double_click
                                                     column     = ir_event_list->column_double_click ).
          WHEN c_list_add_function
            OR c_list_after_function
            OR c_list_before_function.
            io_model->set_function_paramter( display_type  = c_display_salv_list
                                             salv_function = ir_event_list->salv_function ).
          WHEN c_list_end_of_page.
            io_model->set_top_end_of_page_paramter( display_type  = c_display_salv_list
                                                    r_end_of_page = ir_event_list->r_end_of_page
                                                    page          = ir_event_list->page ).
          WHEN c_list_top_of_page.
            io_model->set_top_end_of_page_paramter( display_type  = c_display_salv_list
                                                    r_top_of_page = ir_event_list->r_top_of_page
                                                    page          = ir_event_list->page
                                                    table_index   = ir_event_list->table_index ).
          WHEN c_list_check_changed_data.
            io_model->set_check_changed_data_list( t_modified_cells      = ir_event_list->t_modified_cells
                                                   t_good_cells          = ir_event_list->t_good_cells
                                                   t_deleted_rows        = ir_event_list->t_deleted_rows
                                                   t_inserted_rows       = ir_event_list->t_inserted_rows
                                                   rt_modified_data_rows = ir_event_list->rt_modified_data_rows
                                                   o_ui_data_modify      = ir_event_list->o_ui_data_modify
                                                   o_ui_edit_protocol    = ir_event_list->o_ui_edit_protocol ).
        ENDCASE.
      ENDIF.

      "--------------------------------------------------------------------"
      " Handler for SALV Tree
      "--------------------------------------------------------------------"
      IF ir_event_tree IS BOUND.
        CASE mv_triggered_evt.
          WHEN c_tree_link_click.
            io_model->set_link_double_key_check_expd( event_type = c_tree_link_click
                                                      columnname = ir_event_tree->columnname_link_click
                                                      node_key   = ir_event_tree->node_key_link_click ).
          WHEN c_tree_double_click.
            io_model->set_link_double_key_check_expd( event_type = c_tree_double_click
                                                      columnname = ir_event_tree->columnname_double_click
                                                      node_key   = ir_event_tree->node_key_double_click ).
          WHEN c_tree_keypress.
            io_model->set_link_double_key_check_expd( event_type = c_tree_keypress
                                                      columnname = ir_event_tree->columnname_keypress
                                                      node_key   = ir_event_tree->node_key_keypress
                                                      key        = ir_event_tree->keypress ).
          WHEN c_tree_checkbox_change.
            io_model->set_link_double_key_check_expd( event_type = c_tree_checkbox_change
                                                      columnname = ir_event_tree->columnname_chkbox_change
                                                      node_key   = ir_event_tree->node_key_checkbox_change
                                                      checked    = ir_event_tree->checked ).
          WHEN c_tree_expand_empty_foldr.
            io_model->set_link_double_key_check_expd( event_type = c_tree_expand_empty_foldr
                                                      node_key   = ir_event_tree->node_key_exp_empty_foldr ).
          WHEN c_tree_add_function
            OR c_tree_after_function
            OR c_tree_before_function.
            io_model->set_function_paramter( display_type  = c_display_salv_tree
                                             salv_function = ir_event_tree->salv_function ).
          WHEN c_tree_end_of_page.
            io_model->set_top_end_of_page_paramter( display_type  = c_display_salv_tree
                                                    r_end_of_page = ir_event_tree->r_end_of_page
                                                    page          = ir_event_tree->page ).
          WHEN c_tree_top_of_page.
            io_model->set_top_end_of_page_paramter( display_type  = c_display_salv_tree
                                                    r_top_of_page = ir_event_tree->r_top_of_page
                                                    page          = ir_event_tree->page
                                                    table_index   = ir_event_tree->table_index ).
        ENDCASE.
      ENDIF.
    ENDIF.

    ro_controller = me.
  ENDMETHOD.


  METHOD _set_model.
    DATA: lo_model TYPE REF TO zcl_mvcfw_base_salv_model.

    TRY.
        IF io_model IS BOUND.
          lo_model = io_model.
        ENDIF.

        IF lo_model IS BOUND.
          o_model = lo_model.
        ENDIF.
      CATCH cx_sy_move_cast_error.
    ENDTRY.
  ENDMETHOD.


  METHOD _set_salv_list_events.
    CHECK io_view IS BOUND.

    ro_controller = me.

    SET HANDLER me->handle_list_link_click
                me->handle_list_double_click
                me->handle_list_add_function
                me->handle_list_after_function
                me->handle_list_before_function
                me->handle_list_end_of_page
                me->handle_list_top_of_page
                me->handle_list_check_changed_data
            FOR io_view.
  ENDMETHOD.


  METHOD _set_salv_tree_events.
    CHECK io_view IS BOUND.

    ro_controller = me.

    SET HANDLER me->handle_tree_link_click
                me->handle_tree_double_click
                me->handle_tree_keypress
                me->handle_tree_checkbox_change
                me->handle_tree_expand_empty_foldr
                me->handle_tree_add_function
                me->handle_tree_after_function
                me->handle_tree_before_function
                me->handle_tree_end_of_page
                me->handle_tree_top_of_page
            FOR io_view.
  ENDMETHOD.


  METHOD _set_view.
    DATA: lo_list_view TYPE REF TO zcl_mvcfw_base_salv_list_view,
          lo_tree_view TYPE REF TO zcl_mvcfw_base_salv_tree_view.

    IF io_list_view IS SUPPLIED.
      TRY.
          IF io_list_view IS BOUND.
            lo_list_view = CAST #( io_list_view ).
          ENDIF.
          IF lo_list_view IS BOUND.
            o_list_view = CAST #( lo_list_view ).
          ENDIF.
        CATCH cx_sy_move_cast_error.
      ENDTRY.
    ENDIF.

    IF io_tree_view IS SUPPLIED.
      TRY.
          IF io_list_view IS BOUND.
            lo_tree_view = CAST #( io_tree_view ).
          ENDIF.
          IF lo_list_view IS BOUND.
            o_tree_view = CAST #( lo_tree_view ).
          ENDIF.
        CATCH cx_sy_move_cast_error.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD _validate_display_type.
    rv_display_type = COND #( WHEN iv_display_type IS NOT INITIAL THEN iv_display_type
                              ELSE c_display_salv_list ).

    IF me->o_list_view IS BOUND
   AND rv_display_type  EQ c_display_salv_list.
      rv_display_type = c_display_salv_list.
    ELSEIF me->o_tree_view IS BOUND
       AND rv_display_type  EQ c_display_salv_tree.
      rv_display_type = c_display_salv_tree.
    ELSEIF me->o_list_view IS BOUND
       AND me->o_tree_view IS NOT BOUND.
      rv_display_type = c_display_salv_list.
    ELSEIF me->o_list_view IS NOT BOUND
       AND me->o_tree_view IS BOUND.
      rv_display_type = c_display_salv_tree.
    ELSE.
      rv_display_type = iv_display_type.
    ENDIF.
  ENDMETHOD.


  METHOD clone.
    SYSTEM-CALL OBJMGR CLONE me TO result.
  ENDMETHOD.


  METHOD get_list_parameters.
    rv_value = mr_list_param->*.
  ENDMETHOD.


  METHOD get_tree_parameters.
    rv_value = mr_tree_param->*.
  ENDMETHOD.


  METHOD set_extended_grid_api_events.
*    CHECK ir_view IS BOUND.
*
*    SET HANDLER me->handle_list_context_menu
*                me->handle_list_f4_request
*                me->handle_list_check_changed_data
*            FOR ir_view.
  ENDMETHOD.


  METHOD clear_direct_outtab.
    CLEAR me->mv_is_direct_outtab.
    CLEAR me->mt_direct_outtab.
  ENDMETHOD.


  METHOD get_direct_outtab.
    er_data             = me->mt_direct_outtab.
    ev_is_direct_outtab = me->mv_is_direct_outtab.
  ENDMETHOD.


  METHOD set_direct_outtab.
    me->mt_direct_outtab    = ir_data.
    me->mv_is_direct_outtab = abap_true.

    er_data             = me->mt_direct_outtab.
    ev_is_direct_outtab = me->mv_is_direct_outtab.
  ENDMETHOD.


  METHOD _set_checkbox_on_click.
    FIELD-SYMBOLS: <lft_outtab> TYPE table,
                   <lfs_out>    TYPE any,
                   <lf_value>   TYPE any.

    CASE me->mv_is_direct_outtab.
      WHEN abap_true.
        CHECK me->mt_direct_outtab IS BOUND.

        ASSIGN me->mt_direct_outtab->* TO <lft_outtab>.
        CHECK <lft_outtab> IS ASSIGNED.

        READ TABLE <lft_outtab> ASSIGNING <lfs_out> INDEX row.
        IF sy-subrc EQ 0.
          ASSIGN COMPONENT column OF STRUCTURE <lfs_out> TO <lf_value>.
          IF sy-subrc EQ 0.
            <lf_value> = COND #( WHEN <lf_value> IS INITIAL THEN abap_true ELSE abap_false ).
          ENDIF.
        ENDIF.
      WHEN OTHERS.
        DATA(lr_out) = _get_outtab_model( iv_force_model = abap_true ).
        CHECK lr_out IS BOUND.

        ASSIGN lr_out->* TO <lft_outtab>.
        CHECK <lft_outtab> IS ASSIGNED.

        READ TABLE <lft_outtab> ASSIGNING <lfs_out> INDEX row.
        IF sy-subrc EQ 0.
          ASSIGN COMPONENT column OF STRUCTURE <lfs_out> TO <lf_value>.
          IF sy-subrc EQ 0.
            <lf_value> = COND #( WHEN <lf_value> IS INITIAL THEN abap_true ELSE abap_false ).
          ENDIF.
        ENDIF.
    ENDCASE.

    IF list_view IS BOUND.
      list_view->get_view_instance( )->refresh( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_instance_by_stack_name.
    DATA lv_stack_name TYPE dfies-tabname.

    lv_stack_name = COND #( WHEN iv_stack_name IS NOT INITIAL THEN iv_stack_name ELSE mv_current_stack ).

    READ TABLE mt_stack INTO DATA(ls_stack)
      WITH KEY k2 COMPONENTS name = lv_stack_name.
    IF sy-subrc EQ 0.
      IF ls_stack-controller IS BOUND.
        ro_controller = CAST #( ls_stack-controller ).
      ELSEIF iv_create_new IS NOT INITIAL.
        IF mo_controller IS NOT BOUND.
          mo_controller = me.
        ENDIF.

        ro_controller = CAST #( mo_controller ).
      ENDIF.
    ELSE.
      IF iv_create_new IS NOT INITIAL.
        IF mo_controller IS NOT BOUND.
          mo_controller = me.
        ENDIF.

        ro_controller = CAST #( mo_controller ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _get_instance.
    ro_controller  = mo_controller.
  ENDMETHOD.


  METHOD _setup_parameters_to_list.
    ro_controller = me.

    mr_list_param = NEW #( stack_name      = iv_stack_name
                            list_display    = iv_list_display
                            container       = ir_container
                            container_name  = COND #( WHEN iv_container_name IS NOT INITIAL THEN iv_container_name
                                                      WHEN ir_container IS BOUND THEN ir_container->get_name( ) )
                            pfstatus        = iv_pfstatus
                            variant         = iv_variant
                            start_column    = iv_start_column
                            end_column      = iv_end_column
                            start_line      = iv_start_line
                            end_line        = iv_end_line ).

    populate_setup_before_display( EXPORTING iv_display_type = c_display_salv_list
                                             iv_stack_name   = iv_stack_name
                                   CHANGING  cr_list_param   = mr_list_param
                                             ct_data         = ct_data ).
    _check_setup_before_display( EXPORTING iv_display_type = c_display_salv_list
                                 CHANGING  cr_list_param   = mr_list_param ).

    er_view_param = mr_list_param.
  ENDMETHOD.


  METHOD auto_generated_stack_name.
    DATA: lc_stack_sub_init TYPE dfies-tabname VALUE 'SUB01',
          lc_stack_sub      TYPE dfies-tabname VALUE 'SUB'.
    DATA: lv_next_stack TYPE n LENGTH 2,
          lv_htype      TYPE dd01v-datatype.

    DATA(lt_stack) = me->get_all_stack( ).

    IF NOT line_exists( lt_stack[ KEY k2 COMPONENTS name = c_stack_main ] ).
      rv_stack_name = c_stack_main.
    ELSE.
      LOOP AT lt_stack INTO DATA(ls_stack) WHERE name CP |{ lc_stack_sub }*|.
        EXIT.
      ENDLOOP.
      IF sy-subrc EQ 0.
        DELETE lt_stack WHERE NOT name CP |{ lc_stack_sub }*|.
        SORT lt_stack BY name DESCENDING.

        TRY.
            lv_next_stack = substring_after( val = lt_stack[ 1 ]-name  sub = lc_stack_sub ).

            CALL FUNCTION 'NUMERIC_CHECK'
              EXPORTING
                string_in = lv_next_stack
              IMPORTING
                htype     = lv_htype.

            lv_next_stack = COND #( WHEN lv_htype EQ 'NUMC' THEN lv_next_stack + 1 ELSE '01' ).
            rv_stack_name = |{ lc_stack_sub }{ lv_next_stack }|.
          CATCH cx_sy_itab_line_not_found.
            rv_stack_name = lc_stack_sub_init.
        ENDTRY.
      ELSE.
        rv_stack_name = lc_stack_sub_init.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD redraw_salv_list.
    DATA: lo_grid TYPE REF TO cl_gui_alv_grid,
          lo_salv TYPE REF TO	cl_salv_table.
    DATA: ls_layo TYPE lvc_s_layo.

    ro_controller = me.

*--------------------------------------------------------------------*
*    IF o_list_view IS BOUND.
*      lo_salv = o_list_view->get_salv_instance( ).
*      lo_salv->get_columns( )->set_optimize( if_salv_c_bool_sap=>false ).
*
*      LOOP AT lo_salv->get_columns( )->get( ) REFERENCE INTO DATA(lr_cols).
*        lr_cols->r_column->set_optimized( if_salv_c_bool_sap=>true ).
*      ENDLOOP.
*
*      lo_salv->get_columns( )->set_optimize( if_salv_c_bool_sap=>true ).
*      lo_salv->refresh( EXPORTING s_stable     = VALUE lvc_s_stbl( row = abap_true
*                                                                   col = abap_true )
*                                  refresh_mode = if_salv_c_refresh=>full ).
*    ENDIF.
*--------------------------------------------------------------------*

    CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
      IMPORTING
        lo_grid = lo_grid.

    IF lo_grid IS BOUND.
      lo_grid->get_frontend_layout( IMPORTING es_layout = ls_layo ).
      ls_layo-cwidth_opt = abap_true.
      lo_grid->set_frontend_layout( EXPORTING is_layout = ls_layo ).
      lo_grid->refresh_table_display( EXPORTING is_stable = VALUE lvc_s_stbl( row = abap_true
                                                                              col = abap_true ) ).
    ENDIF.

  ENDMETHOD.


  METHOD _display_salv_list.
    DATA: lo_out TYPE REF TO data.
    DATA: lo_exct_dyn TYPE REF TO cx_root.

    mv_current_stack = COND #( WHEN mr_list_param IS BOUND
                                 AND mr_list_param->stack_name IS NOT INITIAL THEN mr_list_param->stack_name
                                WHEN mv_current_stack IS INITIAL THEN c_stack_main
                                ELSE mv_current_stack ).

    me->_build_stack( iv_name            = _get_current_stack( )  "Default with 'MAIN'
                      io_model           = o_model
                      io_list_view       = o_list_view
                      ir_list_view_param = COND #( WHEN mr_list_param IS BOUND THEN mr_list_param ELSE NEW #( ) )
                      io_controller      = _get_instance( ) ).

    DATA(lo_stack) = me->_get_stack( mv_current_stack ).

    IF lo_stack IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Stack name was not found'.
    ELSE.
      o_model          = lo_stack->model.
      o_list_view      = lo_stack->list_view.
      mo_controller    = lo_stack->controller.
      mr_list_param    = lo_stack->list_param.
      mv_current_stack = lo_stack->name.

      me->set_extended_grid_api_events( EXPORTING iv_stack_name = _get_current_stack( )
                                                  ir_view       = o_list_view ).
    ENDIF.

    "Set Object name for Model
    me->_set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                        iv_object_name = mc_obj_model
                                        iv_stack_name  = _get_current_stack( ) ).

    IF ct_data IS SUPPLIED
   AND ct_data IS BOUND.
      lo_out = ct_data.
    ELSE.
      IF lo_stack->model IS NOT BOUND.
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'Model was not found'.
      ENDIF.

      TRY.
          lo_out = lo_stack->model->get_outtab( iv_stack_name = _get_current_stack( ) ).
        CATCH cx_root INTO lo_exct_dyn.
          RAISE EXCEPTION TYPE zbcx_exception
            EXPORTING
              msgv1 = CONV #( lo_exct_dyn->get_text( ) ).
      ENDTRY.
    ENDIF.
    IF lo_out IS BOUND.
      ASSIGN lo_out->* TO FIELD-SYMBOL(<lft_out>).
      CHECK <lft_out> IS NOT INITIAL.


      "Set Object name for View
      me->_set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                          iv_object_name = mc_obj_list_view
                                          iv_stack_name  = _get_current_stack( )
                              )->_set_salv_list_events( EXPORTING io_view = lo_stack->list_view ).

      IF lo_stack->list_view IS BOUND.
        TRY.
            IF mr_list_param IS NOT BOUND.
              mr_list_param = NEW #( ).
            ENDIF.

            "Display ALV Grid
            lo_stack->list_view->set_controller_listener( me )->display( EXPORTING iv_list_display   = mr_list_param->list_display
                                                                                   ir_container      = mr_list_param->container
                                                                                   iv_container_name = mr_list_param->container_name
                                                                                   iv_pfstatus       = mr_list_param->pfstatus
                                                                                   iv_variant        = mr_list_param->variant
                                                                                   iv_start_column   = mr_list_param->start_column
                                                                                   iv_end_column     = mr_list_param->end_column
                                                                                   iv_start_line     = mr_list_param->start_line
                                                                                   iv_end_line       = mr_list_param->end_line
                                                                         CHANGING  ct_data           = <lft_out> ).
          CATCH zbcx_exception INTO DATA(lo_except).
            RAISE EXCEPTION TYPE zbcx_exception
              EXPORTING
                msgv1 = CONV #( lo_except->get_text( ) ).
        ENDTRY.
      ELSE.
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'SALV List was not created'.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
