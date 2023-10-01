class ZCL_MVCFW_BASE_SALV_LIST_VIEW definition
  public
  create public .

public section.

  interfaces IF_OS_CLONE .
  interfaces IF_SALV_GUI_OM_GRID_LISTENER .
  interfaces IF_SALV_GUI_OM_EDIT_STRCT_LSTR .
  interfaces IF_SALV_GUI_OM_CTXT_MENU_LSTR .
  interfaces ZIF_MVCFW_BASE_SALV_VIEW .

  aliases BEFORE_DISPLAY_CTXT_MENU
    for IF_SALV_GUI_OM_CTXT_MENU_LSTR~BEFORE_DISPLAY_CONTEXT_MENU .
  aliases CLONE
    for IF_OS_CLONE~CLONE .
  aliases CLOSE_SCREEN
    for ZIF_MVCFW_BASE_SALV_VIEW~CLOSE_SCREEN .
  aliases GET_DATA
    for ZIF_MVCFW_BASE_SALV_VIEW~GET_DATA .
  aliases GET_MODEL
    for ZIF_MVCFW_BASE_SALV_VIEW~GET_MODEL .
  aliases GET_STACK_NAME
    for ZIF_MVCFW_BASE_SALV_VIEW~GET_STACK_NAME .
  aliases MODIFY_COLUMNS
    for ZIF_MVCFW_BASE_SALV_VIEW~MODIFY_COLUMNS .
  aliases ON_CHECK_CHANGED_DATA
    for IF_SALV_GUI_OM_EDIT_STRCT_LSTR~ON_CHECK_CHANGED_DATA .
  aliases ON_F4_REQUEST
    for IF_SALV_GUI_OM_EDIT_STRCT_LSTR~ON_F4_REQUEST .
  aliases SETUP_CONTAINER
    for ZIF_MVCFW_BASE_SALV_VIEW~SETUP_CONTAINER .
  aliases SET_AGGREGATIONS
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_AGGREGATIONS .
  aliases SET_CELL_TYPE
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_CELL_TYPE .
  aliases SET_COLUMN_TEXT
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_COLUMN_TEXT .
  aliases SET_CONTAINER_END_OF_PAGE
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_CONTAINER_END_OF_PAGE .
  aliases SET_CONTAINER_ROW_HEIGHT
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_CONTAINER_ROW_HEIGHT .
  aliases SET_CONTAINER_TOP_OF_PAGE
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_CONTAINER_TOP_OF_PAGE .
  aliases SET_DATA
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_DATA .
  aliases SET_DISPLAY_SETTINGS
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_DISPLAY_SETTINGS .
  aliases SET_END_OF_PAGE
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_END_OF_PAGE .
  aliases SET_EVENTS
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_EVENTS .
  aliases SET_FUNCTIONS
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_FUNCTIONS .
  aliases SET_LAYOUT
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_LAYOUT .
  aliases SET_MODEL
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_MODEL .
  aliases SET_NEW_FUNCTIONS
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_NEW_FUNCTIONS .
  aliases SET_PF_STATUS
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_PF_STATUS .
  aliases SET_PF_STATUS_NAME
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_PF_STATUS_NAME .
  aliases SET_SCREEN_POPUP
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_SCREEN_POPUP .
  aliases SET_STACK_NAME
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_STACK_NAME .
  aliases SET_TOP_OF_PAGE
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_TOP_OF_PAGE .
  aliases SET_VARIANT
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_VARIANT .
  aliases SET_VARIANT_NAME
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_VARIANT_NAME .

  types:
    BEGIN OF ts_attributes_columnname,
        drop_down_handle_columnname	TYPE lvc_fname,
        s_register_f4_help          TYPE if_salv_gui_om_edit_restricted=>ys_f4_help_attributes,
        urge_foreign_key_check      TYPE abap_bool,
        all_cells_input_enabled	    TYPE abap_bool,
      END OF ts_attributes_columnname .

  constants C_STACK_MAIN type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  constants C_DEFLT_CNTL type SEOCLSNAME value 'LCL_CONTROLLER' ##NO_TEXT.
  constants C_DEFLT_VIEW type SEOCLSNAME value 'LCL_VIEW' ##NO_TEXT.
  constants C_DEFLT_MODEL type SEOCLSNAME value 'LCL_MODEL' ##NO_TEXT.
  data REF_TABLE_NAME type LVC_RTNAME read-only .
  data O_GRID_API type ref to IF_SALV_GUI_OM_EXTEND_GRID_API .
  data O_EDITABLE type ref to IF_SALV_GUI_OM_EDIT_RESTRICTED .

  events EVT_DOUBLE_CLICK
    exporting
      value(ROW) type SALV_DE_ROW optional
      value(COLUMN) type SALV_DE_COLUMN optional
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .
  events EVT_LINK_CLICK
    exporting
      value(ROW) type SALV_DE_ROW optional
      value(COLUMN) type SALV_DE_COLUMN optional
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .
  events EVT_ADDED_FUNCTION
    exporting
      value(E_SALV_FUNCTION) type SALV_DE_FUNCTION optional
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .
  events EVT_AFTER_SALV_FUNCTION
    exporting
      value(E_SALV_FUNCTION) type SALV_DE_FUNCTION optional
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .
  events EVT_BEFORE_SALV_FUNCTION
    exporting
      value(E_SALV_FUNCTION) type SALV_DE_FUNCTION optional
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .
  events EVT_END_OF_PAGE
    exporting
      value(R_END_OF_PAGE) type ref to CL_SALV_FORM optional
      value(PAGE) type SYPAGNO optional
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .
  events EVT_TOP_OF_PAGE
    exporting
      value(R_TOP_OF_PAGE) type ref to CL_SALV_FORM optional
      value(PAGE) type SYPAGNO optional
      value(TABLE_INDEX) type SYINDEX optional
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .
  events EVT_CHECK_CHANGED_DATA
    exporting
      value(T_MODIFIED_CELLS) type LVC_T_MODI optional
      value(T_GOOD_CELLS) type LVC_T_MODI optional
      value(T_DELETED_ROWS) type LVC_T_MOCE optional
      value(T_INSERTED_ROWS) type LVC_T_MOCE optional
      value(RT_MODIFIED_DATA_ROWS) type ref to DATA optional
      value(O_UI_DATA_MODIFY) type ref to IF_SALV_GUI_OM_EDIT_UI_MODIFY optional
      value(O_UI_EDIT_PROTOCOL) type ref to IF_SALV_GUI_OM_EDIT_UI_PROTCOL optional
      value(O_EDITABLE_RESTRICTED) type ref to IF_SALV_GUI_OM_EDIT_RESTRICTED optional
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .
  events EVT_F4_REQUEST
    exporting
      value(FIELDNAME) type LVC_FNAME optional
      value(FIELDVALUE) type LVC_VALUE optional
      value(S_ROW_NO) type LVC_S_ROID optional
      value(T_BAD_CELLS) type LVC_T_MODI optional
      value(DISPLAY) type CHAR01 optional
      value(XRT_F4_DATA) type ref to DATA
      value(EVENT_HANDLED) type ref to ABAP_BOOL optional
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .
  events EVT_CONTEXT_MENU
    exporting
      value(XO_CONTEXT_MENU) type ref to CL_CTMENU
      value(LIST_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      value(ADAPTER_NAME) type STRING optional .

  methods CONSTRUCTOR
    importing
      !IV_CNTL_NAME type SEOCLSNAME optional
      !IV_VIEW_NAME type SEOCLSNAME optional
      !IV_PFSTATUS type SYPFKEY optional
      !IV_VARIANT type SLIS_VARI optional .
  methods DISPLAY
    importing
      !IV_LIST_DISPLAY type SAP_BOOL optional
      !IR_CONTAINER type ref to CL_GUI_CONTAINER optional
      !IV_CONTAINER_NAME type STRING optional
      !IV_PFSTATUS type SYPFKEY optional
      !IV_VARIANT type SLIS_VARI optional
      !IV_START_COLUMN type I optional
      !IV_END_COLUMN type I optional
      !IV_START_LINE type I optional
      !IV_END_LINE type I optional
      !IV_ADAPTER_NAME type STRING optional
      !IV_NO_DISPLAY type SAP_BOOL optional
    changing
      !CT_DATA type TABLE
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW
    raising
      ZBCX_EXCEPTION .
  methods REFRESH
    importing
      !IS_STABLE type LVC_S_STBL optional
      !IV_REFRESH_MODE type SALV_DE_CONSTANT default IF_SALV_C_REFRESH=>SOFT
      !IV_TABNAME type TABNAME optional .
  methods SET_COLUMN_SPECIFIC_GROUP .
  methods SET_FILTERS .
  methods SET_SORTS .
  methods SET_SELECTIONS_MODE .
  methods SET_SELECTIONS .
  methods GET_SELECTIONS
    returning
      value(RE_VALUE) type ref to CL_SALV_SELECTIONS .
  methods SET_OPTIMIZED
    importing
      !IV_VALUE type SAP_BOOL default ABAP_TRUE
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW .
  methods GET_VIEW_INSTANCE
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW .
  methods GET_SALV_INSTANCE
    returning
      value(RO_SALV) type ref to CL_SALV_TABLE .
  methods EXPORT_VIEW_DATA_TO_XLS
    importing
      !IT_DATA type TABLE
      !IV_FILENAME type STRING optional
      !IV_EXECUTE type ABAP_BOOL default ABAP_TRUE
    raising
      ZBCX_EXCEPTION .
  methods SET_CONTROLLER_LISTENER
    importing
      !IO_CONTROLLER type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW .
  methods SET_CONTEXT_MENU
    importing
      !IR_CONTEXT_MENU type ref to CL_CTMENU .
  methods SET_F4_REQUEST
    importing
      !XRT_F4_DATA type ref to DATA
      !EVENT_HANDLED type ABAP_BOOL .
  methods SET_ATTRIBUTES_FOR_COLUMNNAME
    importing
      !IV_COLUMNNAME type LVC_FNAME
    changing
      !CS_ATTRIBUTES_COLUMN type TS_ATTRIBUTES_COLUMNNAME .
  methods SET_REF_TABLE_NAME
    importing
      !IV_RTNAME type LVC_RTNAME optional
      !IV_ADAPTER_NAME type STRING optional .
  methods GET_ADAPTER_NAME
    returning
      value(RV_ADAPTER_NAME) type STRING .
  methods SET_ADAPTER_NAME
    importing
      !IV_ADAPTER_NAME type STRING .
  methods SET_LIST_COLUMN_TEXT
    importing
      !IR_COLUMN_REF type ref to SALV_S_COLUMN_REF .
protected section.

  aliases END_HEIGHT
    for ZIF_MVCFW_BASE_SALV_VIEW~END_HEIGHT .
  aliases O_END_DYNDOC_ID
    for ZIF_MVCFW_BASE_SALV_VIEW~O_END_DYNDOC_ID .
  aliases O_HTML_END_CNTRL
    for ZIF_MVCFW_BASE_SALV_VIEW~O_HTML_END_CNTRL .
  aliases O_HTML_END_OF_PAGE
    for ZIF_MVCFW_BASE_SALV_VIEW~O_HTML_END_OF_PAGE .
  aliases O_HTML_TOP_CNTRL
    for ZIF_MVCFW_BASE_SALV_VIEW~O_HTML_TOP_CNTRL .
  aliases O_HTML_TOP_OF_PAGE
    for ZIF_MVCFW_BASE_SALV_VIEW~O_HTML_TOP_OF_PAGE .
  aliases O_PARENT_GRID
    for ZIF_MVCFW_BASE_SALV_VIEW~O_PARENT_GRID .
  aliases O_SPLITTER
    for ZIF_MVCFW_BASE_SALV_VIEW~O_SPLITTER .
  aliases O_TOP_DYNDOC_ID
    for ZIF_MVCFW_BASE_SALV_VIEW~O_TOP_DYNDOC_ID .
  aliases TOP_HEIGHT
    for ZIF_MVCFW_BASE_SALV_VIEW~TOP_HEIGHT .
  aliases CREATE_CONTAINER
    for ZIF_MVCFW_BASE_SALV_VIEW~CREATE_CONTAINER .
  aliases CREATE_CONTAINER_END_OF_PAGE
    for ZIF_MVCFW_BASE_SALV_VIEW~CREATE_CONTAINER_END_OF_PAGE .
  aliases CREATE_CONTAINER_TOP_OF_PAGE
    for ZIF_MVCFW_BASE_SALV_VIEW~CREATE_CONTAINER_TOP_OF_PAGE .

  data MV_REPID type SY-CPROG .
  data MT_FCAT type LVC_T_FCAT .
  data MT_OUTTAB type ref to DATA .
  data MO_CONTROLLER type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER .
  data MO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  data MV_CL_VIEW_NAME type CHAR30 .
  data MV_CL_CNTL_NAME type CHAR30 .
  data MO_SALV type ref to CL_SALV_TABLE .
  data MV_ADAPTER_NAME type STRING .
  data MV_CURRENT_STACK type DFIES-TABNAME .

  methods _SETTING_COLUMNS
    exporting
      !EO_VALUE type ref to CL_SALV_COLUMNS_TABLE
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW .
  methods _RAISE_EVT_DOUBLE_CLICK
    for event DOUBLE_CLICK of CL_SALV_EVENTS_TABLE
    importing
      !ROW
      !COLUMN .
  methods _RAISE_EVT_LINK_CLICK
    for event LINK_CLICK of CL_SALV_EVENTS_TABLE
    importing
      !ROW
      !COLUMN .
  methods _RAISE_EVT_ADDED_FUNCTION
    for event ADDED_FUNCTION of CL_SALV_EVENTS_TABLE
    importing
      !E_SALV_FUNCTION .
  methods _RAISE_EVT_AFTER_SALV_FUNC
    for event AFTER_SALV_FUNCTION of CL_SALV_EVENTS_TABLE
    importing
      !E_SALV_FUNCTION .
  methods _RAISE_EVT_BEFORE_SALV_FUNC
    for event BEFORE_SALV_FUNCTION of CL_SALV_EVENTS_TABLE
    importing
      !E_SALV_FUNCTION .
  methods _RAISE_EVT_END_OF_PAGE
    for event END_OF_PAGE of CL_SALV_EVENTS_TABLE
    importing
      !R_END_OF_PAGE
      !PAGE .
  methods _RAISE_EVT_TOP_OF_PAGE
    for event TOP_OF_PAGE of CL_SALV_EVENTS_TABLE
    importing
      !R_TOP_OF_PAGE
      !PAGE
      !TABLE_INDEX .
private section.

  data MO_CTMENU type ref to CL_CTMENU .
  data MR_XRT_F4_DATA type ref to DATA .
  data MV_PF_STATUS type SYPFKEY .
  data MV_VARIANT type SLIS_VARI .
  data MV_IS_EDITABLE type FLAG .
  data MV_EVENT_HANDLED type ABAP_BOOL .

  methods _POPULATE_SETTING_COLUMNS
    importing
      !IO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW .
  methods _POPULATE_SETTING_COLUMNS_OLD
    importing
      !IO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW .
  methods _CHECK_SALV_PF_STATUS
    importing
      !IV_PFSTATUS type SYPFKEY optional .
  methods _CHECK_SALV_VARIANT_EXISTENCE
    importing
      !IV_VARIANT type SLIS_VARI optional .
  methods _SET_TECHNICAL_FIELD
    importing
      !IR_COLUMNS_TABLE type ref to CL_SALV_COLUMNS_TABLE
      !IV_COLUMNNAME type LVC_FNAME .
  methods _SET_PF_STATUS
    importing
      !IV_PFSTATUS type SYPFKEY optional
      !IV_REPID type SY-CPROG default 'SY-CPROG' .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_SALV_LIST_VIEW IMPLEMENTATION.


  METHOD constructor.
    me->mv_cl_cntl_name = COND #( WHEN iv_cntl_name IS INITIAL THEN iv_cntl_name ELSE c_deflt_cntl ).
    me->mv_cl_view_name = COND #( WHEN iv_view_name IS INITIAL THEN iv_view_name ELSE c_deflt_view ).
    me->mv_pf_status    = COND #( WHEN iv_pfstatus  IS NOT INITIAL THEN iv_pfstatus ELSE me->mv_pf_status ).
    me->mv_variant      = COND #( WHEN iv_variant   IS NOT INITIAL THEN iv_variant  ELSE me->mv_variant ).
  ENDMETHOD.


  METHOD display.
    DATA: lr_container TYPE REF TO cl_gui_container.
    DATA: lv_is_container TYPE flag.
    DATA: lv_pfstatus	TYPE sypfkey,
          lv_repid    TYPE sycprog.


    ro_view = me.
*--------------------------------------------------------------------*
* Create new ALV instance
*--------------------------------------------------------------------*
    TRY.
        IF ir_container IS BOUND.
          me->set_container_top_of_page( ).
          me->set_container_end_of_page( ).
          me->create_container( EXPORTING  ir_container      = ir_container
                                IMPORTING  er_parent_grid    = lr_container
                                           ev_is_container   = lv_is_container
                                EXCEPTIONS cntl_error        = 1
                                           cntl_system_error = 2
                                           OTHERS            = 3 ).

          cl_salv_table=>factory( EXPORTING list_display   = iv_list_display
                                            r_container    = lr_container
                                            container_name = iv_container_name
                                  IMPORTING r_salv_table   = me->mo_salv
                                  CHANGING  t_table        = ct_data ).
        ELSE.
          cl_salv_table=>factory( EXPORTING list_display   = iv_list_display
                                  IMPORTING r_salv_table   = me->mo_salv
                                  CHANGING  t_table        = ct_data ).
        ENDIF.
      CATCH cx_salv_msg INTO DATA(lx_msg).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = CONV #( lx_msg->get_text( ) ).
    ENDTRY.

*--------------------------------------------------------------------*
* Provide parameters to SALV before display
*   - Can be redefinition
*--------------------------------------------------------------------*
* Set program and outtab
    me->mv_repid        = sy-cprog.
    me->mt_outtab       = REF #( ct_data ).
    me->mv_adapter_name = iv_adapter_name.

* Set PF-Status
    lv_pfstatus = iv_pfstatus.
    lv_repid    = sy-cprog.

    set_pf_status( CHANGING cv_pfstatus = lv_pfstatus
                            cv_repid    = lv_repid ).
    set_pf_status_name( lv_pfstatus ).
    _set_pf_status( iv_pfstatus = lv_pfstatus
                    iv_repid    = lv_repid ).

    IF lv_is_container IS INITIAL.
* Calling the top of page method, Can redefine method
      set_top_of_page( ).

* Calling the End of Page method, Can redefine method
      set_end_of_page( ).
    ENDIF.

* Setting and modify columns
    _setting_columns(
    )->set_optimized(
    )->modify_columns( it_columns        = me->mo_salv->get_columns( )->get( )
                       it_ref_cols_table = me->mo_salv->get_columns( ) ).

* Add custom functions
    set_new_functions( ).

* Set Layout
    set_layout( ).

* Set variant
    set_variant_name( iv_variant ).
    set_variant( iv_variant ).

* Set display settings
    set_display_settings( ).

* Set additional functions list
    set_functions( ).

* Create the Groups
    set_column_specific_group( ).

* Set_aggregation
    set_aggregations( ).

* Set filter
    set_filters( ).

* Set sorting fields
    set_sorts( ).
*
* Set all events
    set_events( ).

* Set selection mode
    set_selections_mode( ).

* Set ALV as popup
    IF iv_start_column IS NOT INITIAL
   AND iv_start_line   IS NOT INITIAL.
      set_screen_popup( EXPORTING iv_start_column = iv_start_column
                                  iv_end_column   = iv_end_column
                                  iv_start_line   = iv_start_line
                                  iv_end_line     = iv_end_line ).
    ENDIF.

*--------------------------------------------------------------------*
* Displaying the SALV List
*--------------------------------------------------------------------*
    IF iv_no_display IS INITIAL.
      me->mo_salv->display( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_salv_instance.
    ro_salv = me->mo_salv.
  ENDMETHOD.


  METHOD get_selections.
    CHECK me->mo_salv IS BOUND.

    re_value = me->mo_salv->get_selections( ).
  ENDMETHOD.


  METHOD get_view_instance.
    ro_view = me.
  ENDMETHOD.


  METHOD if_salv_gui_om_ctxt_menu_lstr~before_display_context_menu.
    CLEAR me->mo_ctmenu.

    xo_context_menu->hide_functions( VALUE ui_functions( ( cl_gui_alv_grid=>mc_fc_loc_append_row )
                                                         ( cl_gui_alv_grid=>mc_fc_loc_copy )
                                                         ( cl_gui_alv_grid=>mc_fc_loc_copy_row )
                                                         ( cl_gui_alv_grid=>mc_fc_loc_cut )
                                                         ( cl_gui_alv_grid=>mc_fc_loc_delete_row )
                                                         ( cl_gui_alv_grid=>mc_fc_loc_insert_row )
                                                         ( cl_gui_alv_grid=>mc_fc_loc_move_row )
                                                         ( cl_gui_alv_grid=>mc_fc_loc_paste )
                                                         ( cl_gui_alv_grid=>mc_fc_loc_paste_new_row )
                                                         ( cl_gui_alv_grid=>mc_fc_loc_undo ) ) ).

    RAISE EVENT evt_context_menu
      EXPORTING
        xo_context_menu = xo_context_menu
        list_view       = me.

    IF me->mo_ctmenu IS BOUND.
      xo_context_menu = me->mo_ctmenu.
    ENDIF.
  ENDMETHOD.


  METHOD if_salv_gui_om_edit_strct_lstr~on_check_changed_data.
    DATA: t_modified_cells     TYPE lvc_t_modi,
          t_good_cells         TYPE lvc_t_modi,
          t_deleted_rows       TYPE lvc_t_moce,
          t_inserted_rows      TYPE lvc_t_moce,
          t_modified_data_rows TYPE REF TO data.

    IF o_ui_data_modify IS BOUND.
      o_ui_data_modify->get_ui_changes( IMPORTING t_modified_cells      = t_modified_cells
                                                  t_good_cells          = t_good_cells
                                                  t_deleted_rows        = t_deleted_rows
                                                  t_inserted_rows       = t_inserted_rows
                                                  rt_modified_data_rows = t_modified_data_rows ).
    ENDIF.

    RAISE EVENT evt_check_changed_data
      EXPORTING
        t_modified_cells      = t_modified_cells
        t_good_cells          = t_good_cells
        t_deleted_rows        = t_deleted_rows
        t_inserted_rows       = t_inserted_rows
        rt_modified_data_rows = t_modified_data_rows
        o_ui_data_modify      = o_ui_data_modify
        o_ui_edit_protocol    = o_ui_edit_protocol
        o_editable_restricted = me->o_editable
        list_view             = me
        model                 = mo_model.
  ENDMETHOD.


  METHOD if_salv_gui_om_edit_strct_lstr~on_f4_request.
    CLEAR: me->mr_xrt_f4_data,
           me->mv_event_handled.

    RAISE EVENT evt_f4_request
      EXPORTING
        fieldname     = fieldname
        fieldvalue    = fieldvalue
        s_row_no      = s_row_no
        t_bad_cells   = t_bad_cells
        display       = display
        xrt_f4_data   = xrt_f4_data
        event_handled = REF #( event_handled )
        list_view     = me.

    IF me->mr_xrt_f4_data IS BOUND.
      xrt_f4_data = me->mr_xrt_f4_data.
    ENDIF.
    IF me->mv_event_handled IS NOT INITIAL.
      event_handled = me->mv_event_handled.
    ENDIF.
  ENDMETHOD.


  METHOD refresh.
    DATA: ls_stable	TYPE lvc_s_stbl.

    CHECK me->mo_salv IS BOUND.

    ls_stable = COND #( WHEN is_stable IS SUPPLIED THEN is_stable ELSE VALUE #( row = abap_true col = abap_true ) ).

    me->mo_salv->refresh( EXPORTING s_stable     = ls_stable
                                     refresh_mode = iv_refresh_mode ).
  ENDMETHOD.


  METHOD set_column_specific_group.
*--------------------------------------------------------------------*
*   Sample code
*--------------------------------------------------------------------*
*    DATA: lr_functional_settings TYPE REF TO cl_salv_functional_settings,
*          lr_specific_groups     TYPE REF TO cl_salv_specific_groups,
*          lv_text                TYPE cl_salv_specific_groups=>y_text.
*
*    CHECK me->mo_salv IS BOUND.
*
*    lr_functional_settings = me->mo_salv->get_functional_settings( ).
*    lr_specific_groups = lr_functional_settings->get_specific_groups( ).
*
**--------------------------------------------------------------------*
**   Create the Groups
**--------------------------------------------------------------------*
** Group for column which start with HSL, as group ID GRP1
*    TRY.
*        lv_text = 'HSL Amounts'.
*        lr_specific_groups->add_specific_group( id   = 'GRP1'
*                                                text = lv_text ).
*      CATCH cx_salv_existing.                           "#EC NO_HANDLER
*    ENDTRY.
** Group for column which start with TSL, as group ID GRP2
*    TRY.
*        lv_text = 'TSL Amounts'.
*        lr_specific_groups->add_specific_group( id   = 'GRP2'
*                                                text = lv_text ).
*      CATCH cx_salv_existing.                           "#EC NO_HANDLER
*    ENDTRY.
*
*
**--------------------------------------------------------------------*
**   Assign the group to columns
**--------------------------------------------------------------------*
*    DATA: lo_columns TYPE REF TO cl_salv_columns_table,
*          lo_column  TYPE REF TO cl_salv_column_list,
*          lt_cols    TYPE        salv_t_column_ref,
*          ls_cols    LIKE LINE OF lt_cols.
*
*
*    lo_columns = me->mo_salv->get_columns( ).
*    lt_cols    = lo_columns->get( ).
*    TRY.
*        lo_column ?= lo_columns->get_column( 'MANDT' ).
*        lo_column->set_technical( if_salv_c_bool_sap=>true ).
*      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
*    ENDTRY.
*
*    LOOP AT lt_cols INTO ls_cols.
*      lo_column ?= ls_cols-r_column.    "Narrow casting
*      CASE ls_cols-columnname+0(3).
*          " GRP1 to HSL columns
*        WHEN 'HSL'.
*          lo_column->set_specific_group( id = 'GRP1' ).
*          lo_column->set_visible(  ).
*          " GRP2 to TSL columns
*        WHEN 'TSL'.
*          lo_column->set_specific_group( id = 'GRP2' ).
*          lo_column->set_visible( ).
*      ENDCASE.
*    ENDLOOP.
  ENDMETHOD.


  METHOD set_controller_listener.
    ro_view = me.

    IF io_controller IS BOUND.
      me->mo_controller = io_controller.
    ENDIF.
  ENDMETHOD.


  METHOD set_filters.
*--------------------------------------------------------------------*
*   Sample code
*--------------------------------------------------------------------*
*    DATA: lr_filters TYPE REF TO cl_salv_filters.
*
*    CHECK me->mo_salv IS BOUND.
*
*    lr_filters = me->mo_salv->get_filters( ).
*
**   Set the filter for the column ERDAT
**     the filter criteria works exactly same as any
**     RANGE or SELECT-OPTIONS works.
*    TRY.
*        CALL METHOD lr_filters->add_filter
*          EXPORTING
*            columnname = 'ERDAT'
*            sign       = 'I'
*            option     = 'EQ'
*            low        = '20091214'
**           high       =
*          .
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*    ENDTRY.
  ENDMETHOD.


  METHOD set_optimized.
    CHECK me->mo_salv IS BOUND.

    ro_view  = me.

    me->mo_salv->get_columns( )->set_optimize( abap_true ).
  ENDMETHOD.


  METHOD set_selections.
*    DATA: lr_selections TYPE REF TO cl_salv_selections.
*
*    CHECK me->mo_salv IS BOUND.
*
*    lr_selections = me->mo_salv->get_selections( ).
  ENDMETHOD.


  METHOD set_selections_mode.
    DATA: lr_selections TYPE REF TO cl_salv_selections.

    CHECK me->mo_salv IS BOUND.

    lr_selections = me->mo_salv->get_selections( ).

    "--------------------------------------------------------------------"
    " Set selection mode:
    "   - single
    "   - multiple
    "   - cell
    "   - row_column
    "   - none
    "--------------------------------------------------------------------"
*    lr_selections->set_selection_mode( if_salv_c_selection_mode=>none ).
    lr_selections->set_selection_mode( if_salv_c_selection_mode=>none ).
  ENDMETHOD.


  METHOD set_sorts.
*--------------------------------------------------------------------*
*   Sample code
*--------------------------------------------------------------------*
*    DATA: lr_sort TYPE REF TO cl_salv_sorts.
*
*    CHECK me->mo_salv IS BOUND.
*
**   get Sort object
*    lr_sort = me->mo_salv->get_sorts( ).
**
**   Set the SORT on the AUART with Subtotal
*    TRY.
*        CALL METHOD lr_sort->add_sort
*          EXPORTING
*            columnname = 'AUART'
*            subtotal   = if_salv_c_bool_sap=>true.
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*    ENDTRY.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~close_screen.
    CHECK me->mo_salv IS BOUND.

    me->mo_salv->close_screen( ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~modify_columns.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_aggregations.
*--------------------------------------------------------------------*
*   Sample code
*--------------------------------------------------------------------*
*    DATA: lr_aggrs TYPE REF TO cl_salv_aggregations.
*
*    CHECK me->mo_salv IS BOUND.
*
*    lr_aggrs = me->mo_salv->get_aggregations( ).
**
**   Add TOTAL for COLUMN NETWR
*    TRY.
*        CALL METHOD lr_aggrs->add_aggregation
*          EXPORTING
*            columnname  = 'NETWR'
*            aggregation = if_salv_c_aggregation=>total.
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*    ENDTRY.
**
**   Bring the total line to top
*    lr_aggrs->set_aggregation_before_items( ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_column_text.
    CHECK ir_column IS BOUND.

    IF iv_all_text IS SUPPLIED.
      ir_column->set_short_text( CONV #( iv_all_text ) ).
      ir_column->set_medium_text( CONV #( iv_all_text ) ).
      ir_column->set_long_text( CONV #( iv_all_text ) ).
    ELSE.
      IF iv_scrtext_s IS NOT INITIAL.
        ir_column->set_short_text( iv_scrtext_s ).
      ENDIF.
      IF iv_scrtext_m IS NOT INITIAL.
        ir_column->set_medium_text( iv_scrtext_m ).
      ENDIF.
      IF iv_scrtext_l IS NOT INITIAL.
        ir_column->set_long_text( iv_scrtext_l ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_display_settings.
    DATA: lr_disp_setting TYPE REF TO cl_salv_display_settings.

    CHECK me->mo_salv IS BOUND.

* Get display object
    lr_disp_setting = me->mo_salv->get_display_settings( ).

* Set ZEBRA pattern
    lr_disp_setting->set_striped_pattern( abap_true ).

*Set title to ALV
*    lr_disp_setting->set_list_header( 'ALV Test for Display Settings' ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_end_of_page.
*--------------------------------------------------------------------*
*   Sample code
*--------------------------------------------------------------------*
*    DATA: lr_footer  TYPE REF TO cl_salv_form_layout_grid,
*          lr_f_label TYPE REF TO cl_salv_form_label,
*          lr_f_flow  TYPE REF TO cl_salv_form_layout_flow.
**
**   footer object
*    CREATE OBJECT lr_footer.
**
**   information in bold
*    lr_f_label = lr_footer->create_label( row = 1 column = 1 ).
*    lr_f_label->set_text( 'Footer .. here it goes' ).
**
**   tabular information
*    lr_f_flow = lr_footer->create_flow( row = 2  column = 1 ).
*    lr_f_flow->create_text( text = 'This is text of flow in footer' ).
**
*    lr_f_flow = lr_footer->create_flow( row = 3  column = 1 ).
*    lr_f_flow->create_text( text = 'Footer number' ).
**
*    lr_f_flow = lr_footer->create_flow( row = 3  column = 2 ).
*    lr_f_flow->create_text( text = 1 ).
**
**   Online footer
*    me->mo_salv->set_end_of_list( lr_footer ).
**
**   Footer in print
*    me->mo_salv->set_end_of_list_print( lr_footer ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_events.
*   Get the event object
    DATA: lr_events TYPE REF TO cl_salv_events_table.

    CHECK me->mo_salv IS BOUND.

    lr_events = me->mo_salv->get_event( ).

    SET HANDLER me->_raise_evt_double_click
                me->_raise_evt_link_click
                me->_raise_evt_added_function
*                me->_raise_evt_after_salv_func
*                me->_raise_evt_before_salv_func
*                me->_raise_evt_end_of_page
*                me->_raise_evt_top_of_page
            FOR lr_events.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_functions.
*    DATA: lr_functions TYPE REF TO cl_salv_functions_list.
*
*    CHECK me->mo_salv IS BOUND.
*
*    lr_functions = me->mo_salv->get_functions( ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_layout.
    DATA: lr_layout  TYPE REF TO cl_salv_layout.
    DATA: lf_variant TYPE slis_vari,
          ls_key     TYPE salv_s_layout_key.

    CHECK me->mo_salv IS BOUND.

* Get layout object
    lr_layout = me->mo_salv->get_layout( ).

* Set Layout save restriction
    ls_key-report = mv_repid.
    lr_layout->set_key( ls_key ).

*--------------------------------------------------------------------*
*    if_salv_c_layout=>restrict_user_independant.
*      save = 'X'.
*    if_salv_c_layout=>restrict_user_dependant.
*      save = 'U'.
*    if_salv_c_layout=>restrict_none.
*      save = 'A'.
*--------------------------------------------------------------------*
* Save layout the restriction.
    lr_layout->set_save_restriction( if_salv_c_layout=>restrict_none ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_model.
    IF io_model IS BOUND.
      mo_model = io_model.
    ENDIF.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_new_functions.
*--------------------------------------------------------------------*
*   Sample code
*--------------------------------------------------------------------*
*    DATA: lr_functions TYPE REF TO cl_salv_functions_list.
*
*    CHECK me->mo_salv IS BOUND.
*
*    lr_functions ?= me->mo_salv->get_functions( ).
*
** Add EDIT function
*    lr_functions->add_function(
*      EXPORTING
*        name     = 'YE_QM_NOTE'
*    "optionally add custom text and tooltip
*        text     = lv_edit_text
*        tooltip  = lv_edit_tip
*        position = if_salv_c_function_position=>right_of_salv_functions ).
*
** add save function
*    lr_functions->add_function(
*      EXPORTING
*        name     = 'YE_QM_SAVE'
*    "optionally add custom text and tooltip
*        text     = lv_save_text
*        tooltip  = lv_save_tip
*        position = if_salv_c_function_position=>right_of_salv_functions ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_pf_status.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_pf_status_name.
    IF iv_pfstatus IS NOT INITIAL.
      me->mv_pf_status = iv_pfstatus.
    ENDIF.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_screen_popup.
    CHECK me->mo_salv IS BOUND.

    me->mo_salv->set_screen_popup( EXPORTING start_column = iv_start_column
                                              end_column   = iv_end_column
                                              start_line   = iv_start_line
                                              end_line     = iv_end_line ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_stack_name.
    mv_current_stack = iv_stack_name.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_top_of_page.
*--------------------------------------------------------------------*
*   Sample code
*--------------------------------------------------------------------*
*    DATA: lr_header  TYPE REF TO cl_salv_form_layout_grid,
*          lr_h_label TYPE REF TO cl_salv_form_label,
*          lr_h_flow  TYPE REF TO cl_salv_form_layout_flow.
**
**   header object
*    CREATE OBJECT lr_header.
**
**   To create a Lable or Flow we have to specify the target
**     row and column number where we need to set up the output
**     text.
**
**   information in Bold
*    lr_h_label = lr_header->create_label( row = 1 column = 1 ).
*    lr_h_label->set_text( 'Header in Bold' ).
**
**   information in tabular format
*    lr_h_flow = lr_header->create_flow( row = 2  column = 1 ).
*    lr_h_flow->create_text( text = 'This is text of flow' ).
**
*    lr_h_flow = lr_header->create_flow( row = 3  column = 1 ).
*    lr_h_flow->create_text( text = 'Number of Records in the output' ).
**
*    lr_h_flow = lr_header->create_flow( row = 3  column = 2 ).
*    lr_h_flow->create_text( text = 20 ).
**
**   set the top of list using the header for Online.
*    me->mo_salv->set_top_of_list( lr_header ).
**
**   set the top of list using the header for Print.
*    me->mo_salv->set_top_of_list_print( lr_header ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_variant.
    DATA: lr_layout  TYPE REF TO cl_salv_layout.
    DATA: lf_variant TYPE slis_vari,
          ls_key     TYPE salv_s_layout_key.

    CHECK me->mo_salv IS BOUND.

* Get layout object
    lr_layout = me->mo_salv->get_layout( ).

* Set initial Layout
    _check_salv_variant_existence( ).

    IF mv_variant IS NOT INITIAL.
      lr_layout->set_initial_layout( me->mv_variant ).
    ENDIF.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_variant_name.
    IF iv_variant IS NOT INITIAL.
      me->mv_variant = iv_variant.
    ENDIF.
  ENDMETHOD.


  METHOD _check_salv_pf_status.
    DATA: lr_data TYPE REF TO data.
    DATA: lt_status_function TYPE TABLE OF rsmpe_funl.
    DATA: lv_report   TYPE sy-cprog,
          lv_pfstatus TYPE sypfkey.

    lv_report   = COND #( WHEN me->mv_repid IS NOT INITIAL THEN me->mv_repid ELSE sy-cprog ).
    lv_pfstatus = COND #( WHEN iv_pfstatus  IS NOT INITIAL THEN iv_pfstatus  ELSE me->mv_pf_status ).

*    CALL FUNCTION 'ALV_IMPORT_FROM_BUFFER_STATUS'
*      EXPORTING
*        i_report           = lv_report
*        i_statusname       = lv_pfstatus
*      CHANGING
*        cr_status_function = lr_data
*      EXCEPTIONS
*        no_import          = 1
*        OTHERS             = 2.
*    IF sy-subrc EQ 0.
*      me->mv_pf_status = lv_pfstatus.
*    ELSE.
    CALL FUNCTION 'RS_CUA_GET_STATUS_FUNCTIONS'
      EXPORTING
        program           = lv_report
        status            = lv_pfstatus
      TABLES
        function_list     = lt_status_function[]
      EXCEPTIONS
        menu_not_found    = 1
        program_not_found = 2
        status_not_found  = 3
        OTHERS            = 4.
    IF sy-subrc EQ 0.
      me->mv_pf_status = lv_pfstatus.
    ELSE.
      CLEAR me->mv_pf_status.
    ENDIF.
*    ENDIF.
  ENDMETHOD.


  METHOD _check_salv_variant_existence.
    DATA: ls_variant TYPE	disvariant.

    ls_variant-report  = me->mv_repid.
    ls_variant-variant = COND #( WHEN iv_variant IS NOT INITIAL THEN iv_variant ELSE me->mv_variant ).

    CALL FUNCTION 'LVC_VARIANT_EXISTENCE_CHECK'
      EXPORTING
        i_save        = space
      CHANGING
        cs_variant    = ls_variant
      EXCEPTIONS
        wrong_input   = 1
        not_found     = 2
        program_error = 3
        OTHERS        = 4.
    IF sy-subrc EQ 0.
      me->mv_variant = ls_variant-variant.
    ELSE.
      CLEAR me->mv_variant.
    ENDIF.
  ENDMETHOD.


  METHOD _populate_setting_columns.
    DATA: lo_model  TYPE REF TO zcl_mvcfw_base_salv_model.
    DATA: lr_list_columns TYPE REF TO cl_salv_columns_table,
          lr_list_column  TYPE REF TO cl_salv_column_table.
*          lr_column   TYPE REF TO cl_salv_column_list.
    DATA: lr_element TYPE REF TO cl_abap_datadescr.
    DATA: lr_tab TYPE REF TO data,
          lr_str TYPE REF TO data.
    DATA: lt_column_ref TYPE salv_t_column_ref.
    DATA: ls_attributes_column TYPE ts_attributes_columnname.
    DATA: lv_set_traff TYPE flag,
          lv_condition TYPE string.
    FIELD-SYMBOLS: <lft_table> TYPE table,
                   <lfs_table> TYPE any,
                   <lf_val>    TYPE any.

    CHECK me->mo_salv IS BOUND.

    ro_view  = me.
    lo_model = COND #( WHEN io_model IS BOUND THEN CAST #( io_model ) ELSE mo_model ).

    IF mt_outtab IS BOUND.
      ASSIGN mt_outtab->* TO FIELD-SYMBOL(<lft_outtab>).
      IF <lft_outtab> IS ASSIGNED.
        CREATE DATA lr_tab LIKE <lft_outtab>.
        IF lr_tab IS BOUND.
          ASSIGN lr_tab->* TO <lft_table>.
          <lft_table> = <lft_outtab>.
        ENDIF.

        CREATE DATA lr_str LIKE LINE OF <lft_table>.
        IF lr_str IS BOUND.
          ASSIGN lr_str->* TO <lfs_table>.
        ENDIF.
      ENDIF.
    ENDIF.

    "--------------------------------------------------------------------"
    IF <lfs_table> IS ASSIGNED.
      lr_list_columns ?= me->mo_salv->get_columns( ).

      IF lr_list_columns IS BOUND.
        lt_column_ref = lr_list_columns->get( ).
      ENDIF.

      LOOP AT CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_data( <lfs_table> )
                                      )->components REFERENCE INTO DATA(lr_comp).
        "--------------------------------------------------------------------"
        READ TABLE lt_column_ref REFERENCE INTO DATA(lr_col_ref) WITH KEY columnname = lr_comp->name.
        IF sy-subrc = 0.
          IF lo_model IS BOUND.
            READ TABLE lo_model->t_checkbox_type REFERENCE INTO DATA(lr_chkbox_type)
              WITH KEY ref_field = lr_col_ref->columnname
                       ref_table = ref_table_name.
            IF sy-subrc = 0.
              set_cell_type( ir_list_column = CAST #( lr_col_ref->r_column )
                             ref_field      = lr_col_ref->columnname
                             ref_table      = ref_table_name
                             checkbox       = abap_true ).
            ENDIF.

            READ TABLE lo_model->t_editable_cols REFERENCE INTO DATA(lr_editable_cols)
              WITH KEY ref_field = lr_col_ref->columnname
                       ref_table = ref_table_name.
            IF sy-subrc = 0.
              set_cell_type( ir_list_column = CAST #( lr_col_ref->r_column )
                             ref_field      = lr_col_ref->columnname
                             ref_table      = ref_table_name ).
            ENDIF.
          ENDIF.

          set_list_column_text( ir_column_ref = lr_col_ref ).
        ENDIF.

        "--------------------------------------------------------------------"
        IF lr_comp->name = 'ALV_S_COLOR'.
          _set_technical_field( EXPORTING ir_columns_table = lr_list_columns
                                          iv_columnname    = lr_comp->name ).
          CONTINUE.
        ENDIF.

        ASSIGN COMPONENT lr_comp->name OF STRUCTURE <lfs_table> TO FIELD-SYMBOL(<lf_field>).
        IF sy-subrc = 0.
          TRY.
              lr_element ?= cl_abap_datadescr=>describe_by_data( <lf_field> ).

              IF lr_element->absolute_name CP '*MANDT*'.
                _set_technical_field( EXPORTING ir_columns_table = lr_list_columns
                                                iv_columnname    = lr_comp->name ).
                CONTINUE.
              ELSEIF lr_element->absolute_name = '\TYPE=LVC_T_SCOL'
                  OR lr_element->absolute_name = '\TYPE=LVC_T_STYL'
                  OR lr_element->absolute_name = '\TYPE=BKK_LIGHTCODE'
                  OR lr_element->absolute_name = '\TYPE=SALV_T_INT4_COLUMN'
                  OR lr_element->absolute_name = '\TYPE=LVC_EMPHSZ'.
                _set_technical_field( EXPORTING ir_columns_table = lr_list_columns
                                                iv_columnname    = lr_comp->name ).
              ELSE.
                CONTINUE.
              ENDIF.

              CASE lr_element->absolute_name.
                WHEN '\TYPE=BKK_LIGHTCODE'.         "ALV_TRAFF
                  TRY.
                      "Set the Exeception
                      lr_list_columns->set_exception_column( value = lr_comp->name ).
                    CATCH cx_salv_data_error.
                  ENDTRY.
                WHEN '\TYPE=LVC_T_STYL'.            "ALV_CELLSTYL
                  IF sy-batch IS INITIAL.
                    o_grid_api = me->mo_salv->extended_grid_api( ).
                    o_editable = o_grid_api->editable_restricted( ).

                    IF lo_model   IS BOUND
                   AND o_editable IS BOUND.
                      "Set Editable
                      IF lines( lo_model->t_editable_cols ) GT 0.
                        o_editable->set_t_celltab_columnname( t_celltab_columnname = lr_comp->name ).

                        LOOP AT lo_model->t_editable_cols INTO DATA(ls_editable_cols).
                          IF ls_editable_cols-ref_field = space
                          OR ls_editable_cols-ref_table <> ref_table_name.
                            CONTINUE.
                          ENDIF.

                          TRY.
                              ls_attributes_column = VALUE #( urge_foreign_key_check  = abap_false
                                                              all_cells_input_enabled = abap_true ).
                              me->set_attributes_for_columnname( EXPORTING iv_columnname        = ls_editable_cols-ref_field
                                                                 CHANGING  cs_attributes_column = ls_attributes_column ).
                              o_editable->set_attributes_for_columnname(
                                                columnname                  = ls_editable_cols-ref_field
                                                drop_down_handle_columnname = ls_attributes_column-drop_down_handle_columnname
                                                s_register_f4_help          = ls_attributes_column-s_register_f4_help
                                                urge_foreign_key_check      = ls_attributes_column-urge_foreign_key_check
                                                all_cells_input_enabled     = ls_attributes_column-all_cells_input_enabled ).
                            CATCH cx_salv_not_found.
                          ENDTRY.
                        ENDLOOP.

                        IF lines( lo_model->t_editable_cols ) GT 0.
                          o_editable->set_listener( me ).
                        ENDIF.

                        me->mv_is_editable = abap_true.
                      ENDIF.
                    ENDIF.

                    me->mo_salv->extended_grid_api( )->set_context_menu_listener( me ).
                  ENDIF.
                WHEN '\TYPE=LVC_T_SCOL'.            "ALV_C_COLOR
                  TRY.
                      "Set the Cell Color
                      lr_list_columns->set_color_column( value = lr_comp->name ).
                    CATCH cx_salv_data_error.
                  ENDTRY.
                WHEN '\TYPE=LVC_EMPHSZ'.            "ALV_S_COLOR

                WHEN '\TYPE=SALV_T_INT4_COLUMN'.    "ALV_CELLTYPE
                  TRY.
                      "Set the Cell Type
                      lr_list_columns->set_cell_type_column( value = lr_comp->name ).
                    CATCH cx_salv_data_error.
                  ENDTRY.
              ENDCASE.
            CATCH cx_sy_move_cast_error.
          ENDTRY.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD _raise_evt_added_function.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_added_function
      EXPORTING
        e_salv_function = e_salv_function
        list_view       = me
        model           = mo_model
        adapter_name    = mv_adapter_name.
  ENDMETHOD.


  METHOD _raise_evt_after_salv_func.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_after_salv_function
      EXPORTING
        e_salv_function = e_salv_function
        list_view       = me
        model           = mo_model
        adapter_name    = mv_adapter_name.
  ENDMETHOD.


  METHOD _raise_evt_before_salv_func.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_before_salv_function
      EXPORTING
        e_salv_function = e_salv_function
        list_view       = me
        model           = mo_model
        adapter_name    = mv_adapter_name.
  ENDMETHOD.


  METHOD _raise_evt_double_click.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_double_click
     EXPORTING
       row          = row
       column       = column
       list_view    = me
       model        = mo_model
       adapter_name = mv_adapter_name.
  ENDMETHOD.


  METHOD _raise_evt_end_of_page.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_end_of_page
      EXPORTING
        r_end_of_page = r_end_of_page
        page          = page
        list_view     = me
        model         = mo_model
        adapter_name  = mv_adapter_name.
  ENDMETHOD.


  METHOD _raise_evt_link_click.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_link_click
     EXPORTING
       row          = row
       column       = column
       list_view    = me
       model        = mo_model
       adapter_name = mv_adapter_name.
  ENDMETHOD.


  METHOD _raise_evt_top_of_page.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_top_of_page
      EXPORTING
        r_top_of_page = r_top_of_page
        page          = page
        table_index   = table_index
        list_view     = me
        model         = mo_model
        adapter_name  = mv_adapter_name.
  ENDMETHOD.


  METHOD _setting_columns.
    CHECK me->mo_salv IS BOUND.

    ro_view  = me.
    eo_value = me->mo_salv->get_columns( ).

*    me->mo_salv->get_columns( )->set_optimize( abap_true ).

    _populate_setting_columns( ).
  ENDMETHOD.


  METHOD export_view_data_to_xls.
    DATA: table TYPE REF TO data.
    DATA: lt_bintab TYPE STANDARD TABLE OF solix,
          lt_tab    TYPE filetable.
    DATA: lv_title       TYPE string VALUE 'Save file',
          lv_default_ext TYPE string VALUE '.XLS',
          lv_filefilter  TYPE string VALUE 'Excel Files (*.xls)|*.xls'.
    DATA: lv_size     TYPE i,
          lv_filename TYPE string,
          lv_rc       TYPE i,
          lv_execute  TYPE abap_bool.

    TRY.
        CREATE DATA table LIKE it_data.

        IF table IS NOT BOUND.
          RAISE EXCEPTION TYPE zbcx_exception
            EXPORTING
              msgv1 = 'Cannot create SALV table'.
        ENDIF.

        ASSIGN table->* TO FIELD-SYMBOL(<table>).

        cl_salv_table=>factory( IMPORTING r_salv_table = DATA(lo_table)
                                CHANGING  t_table      = <table>  ).

        DATA(lr_columns) = lo_table->get_columns( ).
        lr_columns->get_column( 'MANDT' )->set_technical( ).
        lr_columns->get_column( 'ALV_TRAFF' )->set_technical( ).
        lr_columns->get_column( 'ALV_C_COLOR' )->set_technical( ).
        lr_columns->get_column( 'ALV_CELLTAB' )->set_technical( ).
        lr_columns->get_column( 'ALV_C_COLOR' )->set_technical( ).
      CATCH cx_salv_msg
            cx_salv_not_found.
    ENDTRY.

* Convert ALV Table Object to XML
    DATA(lv_xml) = lo_table->to_xml( xml_type = if_salv_bs_xml=>c_type_xlsx ).
    CHECK lv_xml IS NOT INITIAL.

* Convert XTRING to Binary
    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer        = lv_xml
      IMPORTING
        output_length = lv_size
      TABLES
        binary_tab    = lt_bintab.

    lv_filename = iv_filename.
    lv_execute  = iv_execute.

    IF lv_filename IS INITIAL.
      CALL METHOD cl_gui_frontend_services=>file_open_dialog
        EXPORTING
          window_title            = lv_title
          default_extension       = lv_default_ext
          file_filter             = lv_filefilter
        CHANGING
          file_table              = lt_tab
          rc                      = lv_rc
        EXCEPTIONS
          file_open_dialog_failed = 1
          cntl_error              = 2
          error_no_gui            = 3
          not_supported_by_gui    = 4
          OTHERS                  = 5.

      TRY.
          lv_filename = lt_tab[ 1 ]-filename.
        CATCH cx_sy_itab_line_not_found.
          RAISE EXCEPTION TYPE zbcx_exception
            EXPORTING
              msgv1 = 'File name is required'.
      ENDTRY.
    ENDIF.

    CALL METHOD cl_gui_frontend_services=>gui_download
      EXPORTING
        bin_filesize            = lv_size
        filename                = lv_filename
        filetype                = 'BIN'
      CHANGING
        data_tab                = lt_bintab
      EXCEPTIONS
        file_write_error        = 1
        no_batch                = 2
        gui_refuse_filetransfer = 3
        invalid_type            = 4
        no_authority            = 5
        unknown_error           = 6
        header_not_allowed      = 7
        separator_not_allowed   = 8
        filesize_not_allowed    = 9
        header_too_long         = 10
        dp_error_create         = 11
        dp_error_send           = 12
        dp_error_write          = 13
        unknown_dp_error        = 14
        access_denied           = 15
        dp_out_of_memory        = 16
        disk_full               = 17
        dp_timeout              = 18
        file_not_found          = 19
        dataprovider_exception  = 20
        control_flush_error     = 21
        not_supported_by_gui    = 22
        error_no_gui            = 23
        OTHERS                  = 24.
    IF sy-subrc EQ 0.
      IF lv_execute IS NOT INITIAL.
        CALL METHOD cl_gui_frontend_services=>file_exist
          EXPORTING
            file                 = iv_filename
          RECEIVING
            result               = DATA(lv_exists)
          EXCEPTIONS
            cntl_error           = 1
            error_no_gui         = 2
            wrong_parameter      = 3
            not_supported_by_gui = 4
            OTHERS               = 5.
        IF sy-subrc EQ 0 AND lv_exists IS NOT INITIAL.
          CALL METHOD cl_gui_frontend_services=>execute
            EXPORTING
              document               = iv_filename
            EXCEPTIONS
              cntl_error             = 1
              error_no_gui           = 2
              bad_parameter          = 3
              file_not_found         = 4
              path_not_found         = 5
              file_extension_unknown = 6
              error_execute_failed   = 7
              synchronous_failed     = 8
              not_supported_by_gui   = 9
              OTHERS                 = 10.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_adapter_name.
    rv_adapter_name = mv_adapter_name.
  ENDMETHOD.


  METHOD if_os_clone~clone.
    SYSTEM-CALL OBJMGR CLONE me TO result.
  ENDMETHOD.


  METHOD set_adapter_name.
    mv_adapter_name = iv_adapter_name.
  ENDMETHOD.


  METHOD set_attributes_for_columnname.
  ENDMETHOD.


  METHOD set_context_menu.
    me->mo_ctmenu = ir_context_menu.
  ENDMETHOD.


  METHOD set_f4_request.
    me->mr_xrt_f4_data   = xrt_f4_data.
    me->mv_event_handled = event_handled.
  ENDMETHOD.


  METHOD set_ref_table_name.
    ref_table_name = iv_rtname.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~create_container.
    DATA: lv_row TYPE i.

    ev_is_container = abap_true.

*--------------------------------------------------------------------*
* Initializing for splitter
*--------------------------------------------------------------------*
    IF me->o_splitter IS BOUND.
      me->o_splitter->free( ).
      CLEAR me->o_splitter.
    ENDIF.
    IF me->o_html_top_cntrl IS BOUND.
      me->o_html_top_cntrl->free( ).
      CLEAR me->o_html_top_cntrl.
    ENDIF.
    IF me->o_html_end_cntrl IS BOUND.
      me->o_html_end_cntrl->free( ).
      CLEAR me->o_html_end_cntrl.
    ENDIF.
    IF me->o_parent_grid IS BOUND.
      me->o_parent_grid->free( ).
      CLEAR me->o_parent_grid.
    ENDIF.

    CLEAR: me->top_height, me->end_height.

*--------------------------------------------------------------------*
* Check top-of-page was created
    IF me->o_top_dyndoc_id IS BOUND.
      lv_row += 1.
    ENDIF.

* Check end-of-page was created
    IF me->o_end_dyndoc_id IS BOUND.
      lv_row += 1.
    ENDIF.

    IF lv_row IS INITIAL.
      er_parent_grid = ir_container.
    ELSE.
      lv_row += 1.

      CREATE OBJECT me->o_splitter
        EXPORTING
          parent            = ir_container
          rows              = lv_row
          columns           = 1
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      CASE sy-subrc.
        WHEN 0.
        WHEN 1. RAISE cntl_error.
        WHEN 2. RAISE cntl_system_error.
        WHEN OTHERS. RAISE cntl_system_error.
      ENDCASE.

      me->setup_container( CHANGING cr_splitter = me->o_splitter ).

      "Top-of-page
      me->o_html_top_of_page = me->o_splitter->get_container( row    = 1
                                                               column = 1 ).
      IF me->o_html_top_of_page IS BOUND.
        me->set_container_row_height( ).
        me->o_splitter->set_row_height( EXPORTING  id                = 1
                                                   height            = me->top_height
                                        EXCEPTIONS cntl_error        = 1
                                                   cntl_system_error = 2
                                                   OTHERS            = 3 ).

        "Creating html control
        me->o_html_top_cntrl = NEW #( parent = me->o_html_top_of_page ).

        IF me->o_top_dyndoc_id IS BOUND.
          me->o_top_dyndoc_id->html_control = me->o_html_top_cntrl.
          me->o_top_dyndoc_id->display_document( EXPORTING  reuse_control      = abap_true
                                                            parent             = me->o_html_top_of_page
                                                 EXCEPTIONS html_display_error = 1
                                                            OTHERS             = 2 ).
        ENDIF.
      ENDIF.

      "Container for content of report
      me->o_parent_grid = me->o_splitter->get_container( row    = 2
                                                         column = 1 ).
      er_parent_grid    = me->o_parent_grid.

      "End-of-page
      me->o_html_end_of_page = me->o_splitter->get_container( row    = 3
                                                              column = 1 ).
      IF me->o_html_end_of_page IS BOUND.
        me->set_container_row_height( ).
        me->o_splitter->set_row_height( EXPORTING  id                = 3
                                                   height            = me->end_height
                                        EXCEPTIONS cntl_error        = 1
                                                   cntl_system_error = 2
                                                   OTHERS            = 3 ).
        "Creating html control
        me->o_html_end_cntrl = NEW #( parent = me->o_html_end_of_page ).

        IF me->o_end_dyndoc_id IS BOUND.
          me->o_end_dyndoc_id->html_control = me->o_html_end_cntrl.
          me->o_end_dyndoc_id->display_document( EXPORTING  reuse_control      = abap_true
                                                            parent             = me->o_html_end_of_page
                                                 EXCEPTIONS html_display_error = 1
                                                            OTHERS             = 2 ).
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~create_container_end_of_page.
    CLEAR me->o_end_dyndoc_id.

    IF ir_dyndoc_id IS BOUND.
      me->o_end_dyndoc_id = ir_dyndoc_id.

* Get end->HTML_TABLE ready
      CALL METHOD me->o_end_dyndoc_id->merge_document.
    ENDIF.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~create_container_top_of_page.
    CLEAR me->o_top_dyndoc_id.

    IF ir_dyndoc_id IS BOUND.
      me->o_top_dyndoc_id = ir_dyndoc_id.

* Get TOP->HTML_TABLE ready
      CALL METHOD me->o_top_dyndoc_id->merge_document.
    ENDIF.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~get_data.
    rt_outtab = mt_outtab.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~get_model.
    ro_model = mo_model.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~get_stack_name.
    rv_stack_name = mv_current_stack.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~setup_container.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_container_end_of_page.
*--------------------------------------------------------------------*
* Sample code
*--------------------------------------------------------------------*
*    DATA: lr_dyndoc_id TYPE REF TO cl_dd_document.
*    DATA: lv_date          TYPE char10,
*          lv_background_id TYPE sdydo_key VALUE space. " Background_id.
*
*--------------------------------------------------------------------*
* Style
*   - 'ALV_GRID'
*   - 'ALV_TO_HTML'
*   - 'TREE'
*   - 'STAND_ALONE'
*--------------------------------------------------------------------*
*    lr_dyndoc_id = NEW #( style = 'ALV_GRID' ).
*
** Initializing document
*    CALL METHOD lr_dyndoc_id->initialize_document.
*
*    CALL METHOD lr_dyndoc_id->add_text
*      EXPORTING
*        text      = 'This is Demo of End of Page'
*        sap_style = cl_dd_area=>heading.
*    CALL METHOD lr_dyndoc_id->new_line.
*
*    CONCATENATE sy-datum+6(2) sy-datum+4(2) sy-datum+0(4) INTO lv_date SEPARATED BY '.'.
*    CONCATENATE 'Date : ' lv_date INTO DATA(dl_text) SEPARATED BY space.
*
*    CALL METHOD lr_dyndoc_id->add_text
*      EXPORTING
*        text      = CONV #( dl_text )
*        sap_style = cl_dd_area=>heading.
*
** Set wallpaper
*    CALL METHOD lr_dyndoc_id->set_document_background
*      EXPORTING
*        picture_id = lv_background_id.
*
** Create end-of-page for container
*    me->create_container_end_of_page( lr_dyndoc_id ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_container_row_height.
    me->top_height = COND #( WHEN iv_top_height IS NOT INITIAL THEN iv_top_height ELSE 15 ).
    me->end_height = COND #( WHEN iv_end_height IS NOT INITIAL THEN iv_end_height ELSE 15 ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_container_top_of_page.
*--------------------------------------------------------------------*
* Sample code
*--------------------------------------------------------------------*
*    DATA: lr_dyndoc_id TYPE REF TO cl_dd_document.
*    DATA: lv_date          TYPE char10,
*          lv_background_id TYPE sdydo_key VALUE space. " Background_id.
*
**--------------------------------------------------------------------*
** Style
**   - 'ALV_GRID'
**   - 'ALV_TO_HTML'
**   - 'TREE'
**   - 'STAND_ALONE'
**--------------------------------------------------------------------*
*    lr_dyndoc_id = NEW #( style = 'ALV_GRID' ).
*
** Initializing document
*    CALL METHOD lr_dyndoc_id->initialize_document.
*
*    CALL METHOD lr_dyndoc_id->add_text
*      EXPORTING
*        text      = 'This is Demo of Top of Page'
*        sap_style = cl_dd_area=>heading.
*    CALL METHOD lr_dyndoc_id->new_line.
*
*    CONCATENATE sy-datum+6(2) sy-datum+4(2) sy-datum+0(4) INTO lv_date SEPARATED BY '.'.
*    CONCATENATE 'Date : ' lv_date INTO DATA(dl_text) SEPARATED BY space.
*
*    CALL METHOD lr_dyndoc_id->add_text
*      EXPORTING
*        text      = CONV #( dl_text )
*        sap_style = cl_dd_area=>heading.
*
** Set wallpaper
*    CALL METHOD lr_dyndoc_id->set_document_background
*      EXPORTING
*        picture_id = lv_background_id.
*
** Create top-of-page for container
*    me->create_container_top_of_page( lr_dyndoc_id ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_data.
    CHECK mo_salv IS BOUND.

    mt_outtab = it_outtab.
    CHECK mt_outtab IS BOUND.

    ASSIGN mt_outtab->* TO FIELD-SYMBOL(<lft_outtab>).
    CHECK <lft_outtab> IS ASSIGNED.
    TRY.
        mo_salv->set_data( CHANGING t_table = <lft_outtab> ).
        mo_salv->refresh( ).
      CATCH cx_salv_no_new_data_allowed.
    ENDTRY.
  ENDMETHOD.


  METHOD _populate_setting_columns_old.
    DATA: lo_model  TYPE REF TO zcl_mvcfw_base_salv_model.
    DATA: lr_list_columns TYPE REF TO cl_salv_columns_table,
          lr_list_column  TYPE REF TO cl_salv_column_table.
*          lr_column   TYPE REF TO cl_salv_column_list.
    DATA: lr_tab TYPE REF TO data,
          lr_str TYPE REF TO data.
    DATA: ls_attributes_column TYPE ts_attributes_columnname.
    DATA: lv_set_traff TYPE flag,
          lv_condition TYPE string.
    FIELD-SYMBOLS: <lft_table> TYPE table,
                   <lfs_table> TYPE any,
                   <lf_val>    TYPE any.

    CHECK me->mo_salv IS BOUND.

    ro_view  = me.

    IF mt_outtab IS BOUND.
      ASSIGN mt_outtab->* TO FIELD-SYMBOL(<lft_outtab>).
      IF <lft_outtab> IS ASSIGNED.
        CREATE DATA lr_tab LIKE <lft_outtab>.
        IF lr_tab IS BOUND.
          ASSIGN lr_tab->* TO <lft_table>.
          <lft_table> = <lft_outtab>.
        ENDIF.

        CREATE DATA lr_str LIKE LINE OF <lft_table>.
        IF lr_str IS BOUND.
          ASSIGN lr_str->* TO <lfs_table>.
        ENDIF.
      ENDIF.
    ENDIF.

    lr_list_columns ?= me->mo_salv->get_columns( ).
    CHECK lr_list_columns IS BOUND.

    TRY.
        lr_list_column ?= lr_list_columns->get_column( 'MANDT' ).
        lr_list_column->set_technical( if_salv_c_bool_sap=>true ).

        lr_list_column ?= lr_list_columns->get_column( 'ALV_TRAFF' ).
        lr_list_column->set_technical( if_salv_c_bool_sap=>true ).

        lr_list_column ?= lr_list_columns->get_column( 'ALV_S_COLOR' ).
        lr_list_column->set_technical( if_salv_c_bool_sap=>true ).
      CATCH cx_salv_not_found.
    ENDTRY.

    TRY.
        LOOP AT lr_list_columns->get( ) INTO DATA(lr_columns).
          IF mo_model IS BOUND.
            LOOP AT mo_model->t_checkbox_type INTO DATA(ls_fname) WHERE ref_field = lr_columns-columnname
                                                                    AND ref_table = ref_table_name.
              TRY.
                  lr_list_column ?= lr_columns-r_column.
                  lr_list_column->set_cell_type( if_salv_c_cell_type=>checkbox_hotspot ).
                CATCH cx_salv_not_found.                "#EC NO_HANDLER
              ENDTRY.
            ENDLOOP.
          ENDIF.

          CASE lr_columns-columnname.
            WHEN 'CHKBOX'
              OR 'CHECKBOX'.
              set_column_text( EXPORTING iv_all_text = 'Checkbox'
                                         ir_column   = lr_columns-r_column ).
*              TRY.
*                  lr_column ?= lr_columns-r_column.
*                  lr_column->set_cell_type( if_salv_c_cell_type=>checkbox_hotspot ).
*                CATCH cx_salv_not_found.                "#EC NO_HANDLER
*              ENDTRY.
            WHEN 'SELECT'.
              set_column_text( EXPORTING iv_all_text = 'Select'
                                         ir_column   = lr_columns-r_column ).
          ENDCASE.
        ENDLOOP.
      CATCH cx_salv_not_found.
    ENDTRY.

    IF <lfs_table> IS ASSIGNED.
      ASSIGN COMPONENT 'ALV_TRAFF' OF STRUCTURE <lfs_table> TO <lf_val>.
      IF sy-subrc EQ 0.
        TRY.
            lv_condition = 'ALV_TRAFF EQ 0'.

            DELETE <lft_table> WHERE (lv_condition).
            IF lines( <lft_table> ) GT 0.
              TRY.
                  "Set the Exeception
                  lr_list_columns->set_exception_column( value = 'ALV_TRAFF' ).
                CATCH cx_salv_data_error.
              ENDTRY.
            ENDIF.
          CATCH cx_sy_itab_dyn_loop.
        ENDTRY.
      ENDIF.

      "--------------------------------------------------------------------"
      IF sy-batch IS INITIAL.
        CLEAR me->mv_is_editable.

        ASSIGN COMPONENT 'ALV_CELLSTYL' OF STRUCTURE <lfs_table> TO <lf_val>.
        IF sy-subrc EQ 0.
          lo_model   = COND #( WHEN io_model IS BOUND THEN CAST #( io_model ) ELSE mo_model ).
          o_grid_api = me->mo_salv->extended_grid_api( ).
          o_editable = o_grid_api->editable_restricted( ).

          IF lo_model   IS BOUND
         AND o_editable IS BOUND.
            "Set Editable
            IF lines( lo_model->t_editable_cols ) GT 0.
              o_editable->set_t_celltab_columnname( t_celltab_columnname = 'ALV_CELLSTYL' ).

              LOOP AT lo_model->t_editable_cols INTO DATA(ls_editable_cols).
                IF ls_editable_cols-ref_field = space
                OR ls_editable_cols-ref_table <> ref_table_name.
                  CONTINUE.
                ENDIF.

                TRY.
                    ls_attributes_column = VALUE #( urge_foreign_key_check  = abap_false
                                                    all_cells_input_enabled = abap_true ).
                    me->set_attributes_for_columnname( EXPORTING iv_columnname        = ls_editable_cols-ref_field
                                                       CHANGING  cs_attributes_column = ls_attributes_column ).
                    o_editable->set_attributes_for_columnname(
                                      columnname                  = ls_editable_cols-ref_field
                                      drop_down_handle_columnname = ls_attributes_column-drop_down_handle_columnname
                                      s_register_f4_help          = ls_attributes_column-s_register_f4_help
                                      urge_foreign_key_check      = ls_attributes_column-urge_foreign_key_check
                                      all_cells_input_enabled     = ls_attributes_column-all_cells_input_enabled ).
                  CATCH cx_salv_not_found.
                ENDTRY.
              ENDLOOP.

              IF lines( lo_model->t_editable_cols ) GT 0.
                o_editable->set_listener( me ).
              ENDIF.

              me->mv_is_editable = abap_true.
            ENDIF.
          ENDIF.
        ENDIF.

        me->mo_salv->extended_grid_api( )->set_context_menu_listener( me ).
      ENDIF.

      "--------------------------------------------------------------------"
      ASSIGN COMPONENT 'ALV_C_COLOR' OF STRUCTURE <lfs_table> TO <lf_val>.
      IF sy-subrc EQ 0.
        TRY.
            "Set the Cell Color
            lr_list_columns->set_color_column( 'ALV_C_COLOR' ).
          CATCH cx_salv_data_error.
        ENDTRY.
      ENDIF.

      "--------------------------------------------------------------------"
      ASSIGN COMPONENT 'ALV_CELLTYPE' OF STRUCTURE <lfs_table> TO <lf_val>.
      IF sy-subrc EQ 0.
        TRY.
            "Set the Cell Type
            lr_list_columns->set_cell_type_column( 'ALV_CELLTYPE' ).
          CATCH cx_salv_data_error.
        ENDTRY.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _set_technical_field.
    DATA: lr_list_column  TYPE REF TO cl_salv_column_table.

    CHECK ir_columns_table IS BOUND.

    TRY.
        CLEAR lr_list_column.
        lr_list_column ?= ir_columns_table->get_column( iv_columnname ).

        IF lr_list_column IS BOUND.
          lr_list_column->set_technical( if_salv_c_bool_sap=>true ).
        ENDIF.
      CATCH cx_salv_not_found.
    ENDTRY.
  ENDMETHOD.


  METHOD set_list_column_text.
    CASE ir_column_ref->columnname.
      WHEN 'CHKBOX'
        OR 'CHECKBOX'.
        set_column_text( EXPORTING iv_all_text = 'Checkbox'
                                   ir_column   = ir_column_ref->r_column ).
*              TRY.
*                  lr_column ?= lr_columns-r_column.
*                  lr_column->set_cell_type( if_salv_c_cell_type=>checkbox_hotspot ).
*                CATCH cx_salv_not_found.                "#EC NO_HANDLER
*              ENDTRY.
      WHEN 'SELECT'.
        set_column_text( EXPORTING iv_all_text = 'Select'
                                   ir_column   = ir_column_ref->r_column ).
    ENDCASE.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_cell_type.
    IF checkbox  IS NOT INITIAL
    OR ref_field EQ 'CHKBOX'.
      IF ir_list_column IS BOUND.
        ir_list_column->set_cell_type( if_salv_c_cell_type=>checkbox_hotspot ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _set_pf_status.
    DATA: lr_functions TYPE REF TO cl_salv_functions_list.
    DATA: lv_report   TYPE syrepid,
          lv_pfstatus TYPE sypfkey.

    CHECK me->mo_salv IS BOUND.

    _check_salv_pf_status( ).

    TRY.
        IF me->mv_pf_status IS NOT INITIAL.
          lv_pfstatus = me->mv_pf_status.
          lv_report   = COND #( WHEN iv_repid IS NOT INITIAL THEN iv_repid ELSE sy-cprog ).
        ELSE.
          lv_pfstatus = 'STANDARD'.
          lv_report   = 'SAPLKKBL'.
        ENDIF.

        IF lv_pfstatus IS NOT INITIAL.
          me->mo_salv->set_screen_status(
            EXPORTING
              pfstatus      = lv_pfstatus
              report        = lv_report
              set_functions = mo_salv->c_functions_all ).
        ELSE.
          lr_functions = me->mo_salv->get_functions( ).
          IF lr_functions IS BOUND.
            lr_functions->set_all( abap_true ).
          ENDIF.
        ENDIF.
      CATCH cx_salv_method_not_supported
            cx_salv_object_not_found.
        lr_functions = me->mo_salv->get_functions( ).
        IF lr_functions IS BOUND.
          lr_functions->set_all( abap_true ).
        ENDIF.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
