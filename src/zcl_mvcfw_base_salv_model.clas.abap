class ZCL_MVCFW_BASE_SALV_MODEL definition
  public
  create public .

public section.

  types:
    BEGIN OF ty_evt_list_param,
        row_link_click        TYPE salv_de_row,
        column_link_click     TYPE salv_de_column,
        row_double_click      TYPE salv_de_row,
        column_double_click   TYPE salv_de_column,
        salv_function         TYPE salv_de_function,
        r_top_of_page         TYPE REF TO  cl_salv_form,
        r_end_of_page         TYPE REF TO cl_salv_form,
        page                  TYPE sypagno,
        table_index           TYPE syindex,
        t_modified_cells      TYPE lvc_t_modi,
        t_good_cells          TYPE lvc_t_modi,
        t_deleted_rows        TYPE lvc_t_moce,
        t_inserted_rows       TYPE lvc_t_moce,
        rt_modified_data_rows TYPE REF TO data,
        o_ui_data_modify      TYPE REF TO if_salv_gui_om_edit_ui_modify,
        o_ui_edit_protocol    TYPE REF TO if_salv_gui_om_edit_ui_protcol,
      END OF ty_evt_list_param .
  types:
    BEGIN OF ty_evt_tree_param,
        columnname_link_click    TYPE lvc_fname,
        node_key_link_click      TYPE salv_de_node_key,
        columnname_double_click  TYPE lvc_fname,
        node_key_double_click    TYPE salv_de_node_key,
        columnname_keypress      TYPE lvc_fname,
        node_key_keypress        TYPE salv_de_node_key,
        keypress                 TYPE salv_de_constant,
        columnname_chkbox_change TYPE lvc_fname,
        node_key_checkbox_change TYPE salv_de_node_key,
        checked                  TYPE sap_bool,
        node_key_exp_empty_foldr TYPE salv_de_node_key,
        salv_function            TYPE salv_de_function,
        r_top_of_page            TYPE REF TO cl_salv_form,
        r_end_of_page            TYPE REF TO cl_salv_form,
        page                     TYPE sypagno,
        table_index              TYPE syindex,
      END OF ty_evt_tree_param .
  types:
    BEGIN OF ty_evt_params,
        evt_list TYPE ty_evt_list_param,
        evt_tree TYPE ty_evt_tree_param,
      END OF ty_evt_params .
  types:
    tt_fname TYPE SORTED TABLE OF lvc_fname WITH UNIQUE KEY table_line .
  types:
    BEGIN OF ty_incl_outtab_ext,
        alv_traff    TYPE bkk_lightcode,          "1=Red, 2=Yellow, 3=Green
        alv_cellstyl TYPE lvc_t_styl,             "Style Table for Cells
        alv_celltype TYPE salv_t_int4_column,     "Styles to Cell
        alv_s_color  TYPE char04,                 "Simple row color coding
        alv_c_color  TYPE lvc_t_scol,             "Complex cell color coding
      END OF ty_incl_outtab_ext .
  types:
    BEGIN OF ty_worksheets,
        sheet_name TYPE string,
        data_ref   TYPE REF TO data,
      END OF ty_worksheets .
  types:
    tt_worksheets TYPE TABLE OF ty_worksheets WITH DEFAULT KEY .

  constants:
    BEGIN OF color,
        blue                         TYPE char04 VALUE 'C100',
        blue_intensified             TYPE char04 VALUE 'C110',
        blue_intensified_inversed    TYPE char04 VALUE 'C111',
        blue_inversed                TYPE char04 VALUE 'C101',
        gray                         TYPE char04 VALUE 'C200',
        gray_itensified              TYPE char04 VALUE 'C210',
        gray_intesified_invers       TYPE char04 VALUE 'C211',
        gray_inversed                TYPE char04 VALUE 'C201',
        yellow                       TYPE char04 VALUE 'C300',
        yellow_intensified           TYPE char04 VALUE 'C310',
        yellow_intensified_inversed  TYPE char04 VALUE 'C311',
        yellow_inversed              TYPE char04 VALUE 'C301',
        light_blue                   TYPE char04 VALUE 'C400',
        light_blue_itensified        TYPE char04 VALUE 'C410',
        light_blue_intesified_invers TYPE char04 VALUE 'C411',
        light_blue_inversed          TYPE char04 VALUE 'C401',
        green                        TYPE char04 VALUE 'C500',
        green_intensified            TYPE char04 VALUE 'C510',
        green_intensified_inversed   TYPE char04 VALUE 'C511',
        green_inversed               TYPE char04 VALUE 'C501',
        red                          TYPE char04 VALUE 'C600',
        red_intensified              TYPE char04 VALUE 'C610',
        red_intensified_inversed     TYPE char04 VALUE 'C611',
        red_inversed                 TYPE char04 VALUE 'C601',
        orange                       TYPE char04 VALUE 'C700',
        orange_intensified           TYPE char04 VALUE 'C710',
        orange_intensified_inversed  TYPE char04 VALUE 'C711',
        orange_inversed              TYPE char04 VALUE 'C701',
      END OF color .
  constants:
    BEGIN OF cell_type,
        text             TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>text,
        checkbox         TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>checkbox,
        button           TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>button,
        dropdown         TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>dropdown,
        link             TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>link,
        hotspot          TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>hotspot,
        checkbox_hotspot TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>checkbox_hotspot,
      END OF cell_type .
  constants MC_STACK_MAIN type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  constants MC_DEFLT_OUTTAB type DFIES-TABNAME value 'MT_OUTTAB' ##NO_TEXT.
  constants MC_DEFLT_MODEL type SEOCLSNAME value 'LCL_MODEL' ##NO_TEXT.
  constants MC_STYLE_ENABLED type RAW4 value CL_GUI_ALV_GRID=>MC_STYLE_ENABLED ##NO_TEXT.
  constants MC_STYLE_DISABLED type RAW4 value CL_GUI_ALV_GRID=>MC_STYLE_DISABLED ##NO_TEXT.
  constants MC_EXPAND_ICON type SALV_DE_TREE_IMAGE value '@FO@' ##NO_TEXT.
  constants MC_COLLAPSE_ICON type SALV_DE_TREE_IMAGE value '@FN@' ##NO_TEXT.
  data MT_EDITABLE_COLS type TT_FNAME read-only .
  data MT_CELL_TYPE type SALV_T_INT4_COLUMN read-only .
  data MT_CHECKBOX_TYPE type TT_FNAME read-only .
  data MV_EVT_PARAMS type TY_EVT_PARAMS read-only .
  data MO_MODEL_UTILS type ref to ZCL_MVCFW_BASE_UTILS_MODEL .

  methods CONSTRUCTOR .
  methods SELECT_DATA
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL
    raising
      ZBCX_EXCEPTION .
  methods PROCESS_DATA
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL
    raising
      ZBCX_EXCEPTION .
  methods GET_OUTTAB
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
    returning
      value(RO_DATA) type ref to DATA .
  methods SET_OUTTAB
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
      !IT_DATA type TABLE optional
      !IT_REF_DATA type ref to DATA optional .
  methods SET_EDITABLE_CELL
    importing
      !IV_FNAME type LVC_FNAME
      !IV_DISABLED type ABAP_BOOL default ABAP_TRUE
    changing
      !CT_STYLE type LVC_T_STYL
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods SET_STYLE_CELL
    importing
      !IV_FNAME type LVC_FNAME
      !IV_STYLE type LVC_S_STYL-STYLE optional
      !IV_STYLE2 type LVC_S_STYL-STYLE2 optional
      !IV_STYLE3 type LVC_S_STYL-STYLE3 optional
      !IV_STYLE4 type LVC_S_STYL-STYLE4 optional
    changing
      !CT_STYLE type LVC_T_STYL
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods SET_SALV_CHECKBOX
    importing
      !IV_FNAME type LVC_FNAME
      !IV_DISABLED type ABAP_BOOL default ABAP_FALSE
    changing
      !CT_CELLTYPE type SALV_T_INT4_COLUMN
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods SET_SALV_STYLE_CELL
    importing
      !IV_FNAME type LVC_FNAME
      !IV_VALUE type SALV_DE_CELLTYPE
    changing
      !CT_CELLTYPE type SALV_T_INT4_COLUMN
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods SET_COLOR_CELL
    importing
      !IV_FNAME type LVC_FNAME
      !IS_COLOR type LVC_S_COLO optional
      !IV_COLOR type CHAR04 optional
      !IV_NOKEYCOL type LVC_NOKEYC optional
    changing
      !CT_COLOR type LVC_T_SCOL
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods SET_COLOR_ALL_CELLS
    importing
      !IS_DATA type ANY
      !IS_COLOR type LVC_S_COLO optional
      !IV_COLOR type CHAR04 optional
      !IV_NOKEYCOL type LVC_NOKEYC optional
    changing
      !CT_COLOR type LVC_T_SCOL
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods SET_STACK_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME default MC_STACK_MAIN
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods BUILD_SALV_TREE_NODE
    importing
      !IO_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW
    changing
      !CT_DATA type TABLE optional .
  methods GET_EVENTS_PARAMTER
    returning
      value(RO_EVT_PARAM) type ref to TY_EVT_PARAMS .
  methods SET_LINK_DOUBLE_CLICK_TO_LIST
    importing
      !EVENT_TYPE type SEOCPDNAME
      !ROW type SALV_DE_ROW optional
      !COLUMN type SALV_DE_COLUMN optional .
  methods SET_FUNCTION_PARAMTER
    importing
      !DISPLAY_TYPE type SALV_DE_CONSTANT default ZCL_MVCFW_BASE_SALV_CONTROLLER=>MC_DISPLAY_SALV_LIST
      !SALV_FUNCTION type SALV_DE_FUNCTION optional .
  methods SET_TOP_END_OF_PAGE_PARAMTER
    importing
      !DISPLAY_TYPE type SALV_DE_CONSTANT default ZCL_MVCFW_BASE_SALV_CONTROLLER=>MC_DISPLAY_SALV_LIST
      !R_TOP_OF_PAGE type ref to CL_SALV_FORM optional
      !R_END_OF_PAGE type ref to CL_SALV_FORM optional
      !PAGE type SYPAGNO optional
      !TABLE_INDEX type SYINDEX optional .
  methods SET_CHECK_CHANGED_DATA_LIST
    importing
      !T_MODIFIED_CELLS type LVC_T_MODI optional
      !T_GOOD_CELLS type LVC_T_MODI optional
      !T_DELETED_ROWS type LVC_T_MOCE optional
      !T_INSERTED_ROWS type LVC_T_MOCE optional
      !RT_MODIFIED_DATA_ROWS type ref to DATA optional
      !O_UI_DATA_MODIFY type ref to IF_SALV_GUI_OM_EDIT_UI_MODIFY optional
      !O_UI_EDIT_PROTOCOL type ref to IF_SALV_GUI_OM_EDIT_UI_PROTCOL optional .
  methods SET_LINK_DOUBLE_KEY_CHECK_EXPD
    importing
      !EVENT_TYPE type SEOCPDNAME
      !COLUMNNAME type LVC_FNAME optional
      !NODE_KEY type SALV_DE_NODE_KEY optional
      !KEY type SALV_DE_CONSTANT optional
      !CHECKED type SAP_BOOL optional .
  PROTECTED SECTION.

    DATA lmv_current_stack TYPE dfies-tabname .

    METHODS _get_current_stack
      RETURNING
        VALUE(re_current_stack) TYPE dfies-tabname .
private section.
ENDCLASS.



CLASS ZCL_MVCFW_BASE_SALV_MODEL IMPLEMENTATION.


  METHOD build_salv_tree_node.
*--------------------------------------------------------------------*
* Sample code
*--------------------------------------------------------------------*
* Row Style
*   IF_SALV_C_TREE_STYLE=>DEFAULT
*   IF_SALV_C_TREE_STYLE=>INHERITED
*   IF_SALV_C_TREE_STYLE=>INTENSIFIED
*   IF_SALV_C_TREE_STYLE=>INACTIVE
*   IF_SALV_C_TREE_STYLE=>INTENSIFIED_CRITICAL
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_NEGATIVE
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_POSITIVE
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_POSITIVE
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_A
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_B
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_C
*--------------------------------------------------------------------*
**    DATA: lo_out  TYPE REF TO tty_outtab,
**          lo_node	TYPE REF TO	cl_salv_node,
**          lo_item TYPE REF TO cl_salv_item.
**    FIELD-SYMBOLS: <lft_out> TYPE STANDARD TABLE,
**                   <lfs_out> TYPE any,
**                   <lf_val>  TYPE any.
**
**
**    lo_out = REF #( ct_data ).
**
**    LOOP AT lo_out->* REFERENCE INTO DATA(lr_out) GROUP BY ( carrid = lr_out->carrid )
**                                                  ASCENDING REFERENCE INTO DATA(lrg_carrid).
**      LOOP AT GROUP lrg_carrid REFERENCE INTO DATA(lrs_carrid). EXIT. ENDLOOP.
**
**      "Build Parent --> Carrid
**      CALL METHOD io_view->add_salv_tree_node
**        EXPORTING
**          iv_related_node = space
***         iv_relationship = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
**          is_data_row     = lrs_carrid->*
***         iv_collapsed_icon = MC_COLLAPSE_ICON
***         iv_expanded_icon  = MC_EXPAND_ICON
***         iv_row_style    = IF_SALV_C_TREE_STYLE=>DEFAULT
**          iv_text         = lrs_carrid->carrid
***         iv_visible      = ABAP_TRUE
***         iv_expander     =
***         iv_enabled      = ABAP_TRUE
***         iv_folder       =
**          io_tree         = io_view->get_salv_tree_instance( )
**        IMPORTING
**          ev_last_key     = DATA(lv_carrid_key)
**        RECEIVING
**          ro_node         = lo_node.
**
***  ... §0.2 if information should be displayed at
***    the hierarchy column set the carrid as text for this nod
***      lo_node->set_text( CONV #( lrs_carrid->carrid ) ).
**
***  ... §0.3 set the data for the nes node
***      lo_node->set_data_row( p_ls_data ).
**
**      LOOP AT GROUP lrg_carrid REFERENCE INTO lrs_carrid GROUP BY ( connid = lrs_carrid->connid )
**                                                         ASCENDING REFERENCE INTO DATA(lrg_connid).
**        LOOP AT GROUP lrg_connid REFERENCE INTO DATA(lrs_connid). EXIT. ENDLOOP.
**
**        "Build Sub Parent --> Connid
**        CALL METHOD io_view->add_salv_tree_node
**          EXPORTING
**            iv_related_node = lv_carrid_key
***           iv_relationship = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
**            is_data_row     = lrs_connid->*
***           iv_collapsed_icon = MC_COLLAPSE_ICON
***           iv_expanded_icon  = MC_EXPAND_ICON
***           iv_row_style    = IF_SALV_C_TREE_STYLE=>DEFAULT
**            iv_text         = lrs_connid->connid
***           iv_visible      = ABAP_TRUE
***           iv_expander     =
***           iv_enabled      = ABAP_TRUE
***           iv_folder       =
**            io_tree         = io_view->get_salv_tree_instance( )
**          IMPORTING
**            ev_last_key     = DATA(lv_connid_key)
**          RECEIVING
**            ro_node         = lo_node.
**
***  ... §0.2 if information should be displayed at
***    the hierarchy column set the carrid as text for this nod
***        lo_node->set_text( CONV #( lrs_connid->connid ) ).
**
***  ... §0.3 set the data for the nes node
***      lo_node->set_data_row( p_ls_data ).
**
**        LOOP AT GROUP lrg_connid REFERENCE INTO lrs_connid.
**          CALL METHOD io_view->add_salv_tree_node
**            EXPORTING
**              iv_related_node   = lv_connid_key
***             iv_relationship   = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
**              is_data_row       = lrs_connid->*
**              iv_collapsed_icon = space "MC_COLLAPSE_ICON
**              iv_expanded_icon  = space " MC_EXPAND_ICON
***             iv_row_style      = IF_SALV_C_TREE_STYLE=>DEFAULT
***             iv_text           =
***             iv_visible        = ABAP_TRUE
***             iv_expander       =
***             iv_enabled        = ABAP_TRUE
***             iv_folder         =
**              io_tree           = io_view->get_salv_tree_instance( )
***        IMPORTING
***             ev_last_key       = DATA(lv_last_key)
**            RECEIVING
**              ro_node           = lo_node.
**
**          "Set data setting
**          TRY.
***              lo_item = lo_node->get_item( 'CARRID' ).
***              lo_item->set_type(  if_salv_c_item_type=>button ).
***              lo_item->set_value( 'Button' ).
***
***              lo_item = lo_node->get_item( 'CITYFROM' ).
***              lo_item->set_font( if_salv_c_item_font=>fixed_size ).
***              lo_item->set_enabled( abap_false ).
**
**              lo_item = lo_node->get_item( 'CHKBOX' ).
**              lo_item->set_type(  if_salv_c_item_type=>checkbox ).
***              lo_item->set_checked( abap_true ).
**              lo_item->set_editable( abap_true ).
**
***              lo_item = lo_node->get_item( 'ACTIVE_ICON' ).
***              lo_item->set_icon( ' ' ).
**            CATCH cx_salv_msg.
**          ENDTRY.
**        ENDLOOP.
**      ENDLOOP.
**    ENDLOOP.
  ENDMETHOD.


  METHOD constructor.
    IF mo_model_utils IS NOT BOUND.
      mo_model_utils = NEW #( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_events_paramter.
    ro_evt_param = REF #( mv_evt_params ).
  ENDMETHOD.


  METHOD get_outtab.
  ENDMETHOD.


  METHOD process_data.
  ENDMETHOD.


  METHOD select_data.
  ENDMETHOD.


  METHOD set_check_changed_data_list.
    IF t_modified_cells IS SUPPLIED.
      mv_evt_params-evt_list-t_modified_cells = t_modified_cells.
    ENDIF.
    IF t_good_cells IS SUPPLIED.
      mv_evt_params-evt_list-t_good_cells = t_good_cells.
    ENDIF.
    IF t_deleted_rows IS SUPPLIED.
      mv_evt_params-evt_list-t_deleted_rows = t_deleted_rows.
    ENDIF.
    IF t_inserted_rows IS SUPPLIED.
      mv_evt_params-evt_list-t_inserted_rows = t_inserted_rows.
    ENDIF.
    IF rt_modified_data_rows IS SUPPLIED.
      mv_evt_params-evt_list-rt_modified_data_rows = rt_modified_data_rows.
    ENDIF.
    IF o_ui_data_modify IS SUPPLIED.
      mv_evt_params-evt_list-o_ui_data_modify = o_ui_data_modify.
    ENDIF.
    IF o_ui_edit_protocol IS SUPPLIED.
      mv_evt_params-evt_list-o_ui_edit_protocol = o_ui_edit_protocol.
    ENDIF.
  ENDMETHOD.


  METHOD set_color_all_cells.
*****************************************************************
* Colour code :                                                 *
* Colour is a 4-char field where :                              *
*              - 1st char = C (color property)                  *
*              - 2nd char = color code (from 0 to 7)            *
*                                  0 = background color         *
*                                  1 = blue                     *
*                                  2 = gray                     *
*                                  3 = yellow                   *
*                                  4 = blue/gray                *
*                                  5 = green                    *
*                                  6 = red                      *
*                                  7 = orange                   *
*              - 3rd char = intensified (0=off, 1=on)           *
*              - 4th char = inverse display (0=off, 1=on)       *
*                                                               *
* Colour overwriting priority :                                 *
*   1. Line                                                     *
*   2. Cell                                                     *
*   3. Column                                                   *
*****************************************************************
*****************************************************************
* Use of colours in ALV grid (cell, line and column)            *
*****************************************************************

    DATA ls_color LIKE LINE OF ct_color.
    DATA ls_scolo TYPE lvc_s_colo.
    FIELD-SYMBOLS <lfs_color> TYPE lvc_s_scol.

    ro_model = me.

    IF is_color IS SUPPLIED.
      ls_scolo = is_color.
    ELSEIF iv_color IS SUPPLIED.
      IF |{ iv_color+0(1) CASE = UPPER }| CA sy-abcde.
        DATA(lv_color) = iv_color+1.
      ENDIF.

      TRY.
          ls_scolo = VALUE #( col = lv_color+0(1)
                              int = lv_color+1(1)
                              inv = lv_color+2(1) ).
        CATCH cx_sy_range_out_of_bounds.
      ENDTRY.
    ELSE.
      RETURN.
    ENDIF.

    IF ls_scolo IS NOT INITIAL.
      IF mo_model_utils IS NOT BOUND.
        mo_model_utils = NEW #( ).
      ENDIF.

      DATA(lt_comp) = mo_model_utils->get_component_of_data( EXPORTING is_data = is_data ).

      LOOP AT lt_comp INTO DATA(ls_comp).
        READ TABLE ct_color ASSIGNING <lfs_color> BINARY SEARCH
          WITH KEY fname = ls_comp-fieldname.
        IF sy-subrc EQ 0.
          <lfs_color>-fname    = ls_comp-fieldname.
          <lfs_color>-color    = ls_scolo.
          <lfs_color>-nokeycol = iv_nokeycol.
        ELSE.
          CLEAR ls_color.
          ls_color-fname    = ls_comp-fieldname.
          ls_color-color    = ls_scolo.
          ls_color-nokeycol = iv_nokeycol.
          INSERT ls_color INTO TABLE ct_color.
          SORT ct_color BY fname.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD set_color_cell.
*****************************************************************
* Colour code :                                                 *
* Colour is a 4-char field where :                              *
*              - 1st char = C (color property)                  *
*              - 2nd char = color code (from 0 to 7)            *
*                                  0 = background color         *
*                                  1 = blue                     *
*                                  2 = gray                     *
*                                  3 = yellow                   *
*                                  4 = blue/gray                *
*                                  5 = green                    *
*                                  6 = red                      *
*                                  7 = orange                   *
*              - 3rd char = intensified (0=off, 1=on)           *
*              - 4th char = inverse display (0=off, 1=on)       *
*                                                               *
* Colour overwriting priority :                                 *
*   1. Line                                                     *
*   2. Cell                                                     *
*   3. Column                                                   *
*****************************************************************
*****************************************************************
* Use of colours in ALV grid (cell, line and column)            *
*****************************************************************
    DATA ls_color LIKE LINE OF ct_color.
    DATA ls_scolo TYPE lvc_s_colo.
    FIELD-SYMBOLS <lfs_color> TYPE lvc_s_scol.

    ro_model = me.

    IF is_color IS SUPPLIED.
      ls_scolo = is_color.
    ELSEIF iv_color IS SUPPLIED.
      IF |{ iv_color+0(1) CASE = UPPER }| CA sy-abcde.
        DATA(lv_color) = iv_color+1.
      ENDIF.

      TRY.
          ls_scolo = VALUE #( col = lv_color+0(1)
                              int = lv_color+1(1)
                              inv = lv_color+2(1) ).
        CATCH cx_sy_range_out_of_bounds.
      ENDTRY.
    ELSE.
      RETURN.
    ENDIF.

    IF ls_scolo IS NOT INITIAL.
      READ TABLE ct_color ASSIGNING <lfs_color> BINARY SEARCH
        WITH KEY fname = iv_fname.
      IF sy-subrc EQ 0.
        <lfs_color>-fname    = iv_fname.
        <lfs_color>-color    = ls_scolo.
        <lfs_color>-nokeycol = iv_nokeycol.
      ELSE.
        CLEAR ls_color.
        ls_color-fname    = iv_fname.
        ls_color-color    = ls_scolo.
        ls_color-nokeycol = iv_nokeycol.
        INSERT ls_color INTO TABLE ct_color.
        SORT ct_color BY fname.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_editable_cell.
*--------------------------------------------------------------------*
* Check text style with include <CL_ALV_CONTROL>
*--------------------------------------------------------------------*
*    INCLUDE <cl_alv_control>.

    DATA: ls_style LIKE LINE OF ct_style,
          l_style  TYPE lvc_style.

    ro_model = me.

    CHECK iv_fname IS NOT INITIAL.

    IF iv_disabled IS NOT INITIAL.
      l_style = cl_gui_alv_grid=>mc_style_disabled.
    ELSE.
      l_style = cl_gui_alv_grid=>mc_style_enabled.
    ENDIF.

    READ TABLE ct_style ASSIGNING FIELD-SYMBOL(<lfs_style>)
      WITH TABLE KEY fieldname = |{ iv_fname CASE = UPPER }|.
    IF sy-subrc EQ 0.
      <lfs_style>-style  = l_style.
    ELSE.
      CLEAR ls_style.
      ls_style-fieldname = |{ iv_fname CASE = UPPER }|.
      ls_style-style     = l_style.
      INSERT ls_style INTO TABLE ct_style.
      INSERT ls_style-fieldname INTO TABLE mt_editable_cols.
    ENDIF.
  ENDMETHOD.


  METHOD set_function_paramter.
    CASE display_type.
      WHEN zcl_mvcfw_base_salv_controller=>mc_display_salv_list.
        IF salv_function IS SUPPLIED.
          mv_evt_params-evt_list-salv_function = salv_function.
        ENDIF.
      WHEN zcl_mvcfw_base_salv_controller=>mc_display_salv_tree.
        IF salv_function IS SUPPLIED.
          mv_evt_params-evt_tree-salv_function = salv_function.
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD set_link_double_click_to_list.
    CASE event_type.
      WHEN 'HANDLE_LIST_LINK_CLICK'.
        IF row IS SUPPLIED.
          mv_evt_params-evt_list-row_link_click = row.
        ENDIF.
        IF column IS SUPPLIED.
          mv_evt_params-evt_list-column_link_click = column.
        ENDIF.
      WHEN 'HANDLE_LIST_DOUBLE_CLICK'.
        IF row IS SUPPLIED.
          mv_evt_params-evt_list-row_double_click = row.
        ENDIF.
        IF column IS SUPPLIED.
          mv_evt_params-evt_list-column_double_click = column.
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD set_link_double_key_check_expd.
    CASE event_type.
      WHEN 'HANDLE_LIST_LINK_CLICK'.
        IF node_key IS SUPPLIED.
          mv_evt_params-evt_tree-node_key_link_click = node_key.
        ENDIF.
        IF columnname IS SUPPLIED.
          mv_evt_params-evt_tree-columnname_link_click = columnname.
        ENDIF.
      WHEN 'HANDLE_LIST_DOUBLE_CLICK'.
        IF node_key IS SUPPLIED.
          mv_evt_params-evt_tree-node_key_double_click = node_key.
        ENDIF.
        IF columnname IS SUPPLIED.
          mv_evt_params-evt_tree-columnname_double_click = columnname.
        ENDIF.
      WHEN 'HANDLE_TREE_KEYPRESS'.
        IF node_key IS SUPPLIED.
          mv_evt_params-evt_tree-node_key_keypress = node_key.
        ENDIF.
        IF columnname IS SUPPLIED.
          mv_evt_params-evt_tree-columnname_keypress = columnname.
        ENDIF.
        IF key IS SUPPLIED.
          mv_evt_params-evt_tree-keypress = key.
        ENDIF.
      WHEN 'HANDLE_TREE_CHECKBOX_CHANGE'.
        IF node_key IS SUPPLIED.
          mv_evt_params-evt_tree-node_key_checkbox_change = node_key.
        ENDIF.
        IF columnname IS SUPPLIED.
          mv_evt_params-evt_tree-columnname_chkbox_change = columnname.
        ENDIF.
        IF key IS SUPPLIED.
          mv_evt_params-evt_tree-checked = checked.
        ENDIF.
      WHEN 'HANDLE_TREE_EXPAND_EMPTY_FOLDR'.
        IF node_key IS SUPPLIED.
          mv_evt_params-evt_tree-node_key_exp_empty_foldr = node_key.
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD set_outtab.
  ENDMETHOD.


  METHOD set_salv_checkbox.
    DATA: ls_style LIKE LINE OF ct_celltype.
    DATA: l_value TYPE salv_de_celltype.

    ro_model = me.

    CHECK iv_fname IS NOT INITIAL.

    IF iv_disabled IS NOT INITIAL.
      l_value = if_salv_c_cell_type=>checkbox.
    ELSE.
      l_value = if_salv_c_cell_type=>checkbox_hotspot.
    ENDIF.

    READ TABLE ct_celltype ASSIGNING FIELD-SYMBOL(<lfs_style>)
      WITH TABLE KEY columnname = |{ iv_fname CASE = UPPER }|.
    IF sy-subrc EQ 0.
      <lfs_style>-value = l_value.
    ELSE.
      CLEAR ls_style.
      ls_style-columnname = |{ iv_fname CASE = UPPER }|.
      ls_style-value      = l_value.
      INSERT ls_style INTO TABLE ct_celltype.
      INSERT ls_style-columnname INTO TABLE mt_checkbox_type.
    ENDIF.
  ENDMETHOD.


  METHOD set_salv_style_cell.
    DATA: ls_style LIKE LINE OF ct_celltype.

    ro_model = me.

    CHECK iv_fname IS NOT INITIAL
      AND iv_value NE if_salv_c_cell_type=>checkbox
      AND iv_value NE if_salv_c_cell_type=>checkbox_hotspot.

    READ TABLE ct_celltype ASSIGNING FIELD-SYMBOL(<lfs_style>)
      WITH TABLE KEY columnname = |{ iv_fname CASE = UPPER }|.
    IF sy-subrc EQ 0.
      <lfs_style>-value = iv_value.
    ELSE.
      CLEAR ls_style.
      ls_style-columnname = |{ iv_fname CASE = UPPER }|.
      ls_style-value      = iv_value.
      INSERT ls_style INTO TABLE ct_celltype.
    ENDIF.
  ENDMETHOD.


  METHOD set_stack_name.
    lmv_current_stack = iv_stack_name.
    ro_model         = me.
  ENDMETHOD.


  METHOD set_style_cell.
*--------------------------------------------------------------------*
* Check text style with include <CL_ALV_CONTROL>
*--------------------------------------------------------------------*
    INCLUDE <cl_alv_control>.

    DATA: ls_style LIKE LINE OF ct_style,
          l_style  TYPE lvc_style.

    ro_model = me.

    CHECK iv_fname IS NOT INITIAL.

    READ TABLE ct_style ASSIGNING FIELD-SYMBOL(<lfs_style>)
      WITH TABLE KEY fieldname = iv_fname.
    IF sy-subrc EQ 0.
      <lfs_style>-style  = COND #( WHEN iv_style  IS NOT INITIAL THEN iv_style  ELSE <lfs_style>-style ).
      <lfs_style>-style2 = COND #( WHEN iv_style2 IS NOT INITIAL THEN iv_style2 ELSE <lfs_style>-style2 ).
      <lfs_style>-style3 = COND #( WHEN iv_style3 IS NOT INITIAL THEN iv_style3 ELSE <lfs_style>-style3 ).
      <lfs_style>-style4 = COND #( WHEN iv_style4 IS NOT INITIAL THEN iv_style4 ELSE <lfs_style>-style4 ).
    ELSE.
      CLEAR ls_style.
      ls_style-fieldname = iv_fname.
      ls_style-style     = iv_style.
      ls_style-style2    = iv_style2.
      ls_style-style3    = iv_style3.
      ls_style-style4    = iv_style4.
      INSERT ls_style INTO TABLE ct_style.
    ENDIF.
  ENDMETHOD.


  METHOD set_top_end_of_page_paramter.
    CASE display_type.
      WHEN zcl_mvcfw_base_salv_controller=>mc_display_salv_list.
        IF r_top_of_page IS SUPPLIED.
          mv_evt_params-evt_list-r_top_of_page = r_top_of_page.
        ENDIF.
        IF r_end_of_page IS SUPPLIED.
          mv_evt_params-evt_list-r_end_of_page = r_end_of_page.
        ENDIF.
        IF page IS SUPPLIED.
          mv_evt_params-evt_list-page = page.
        ENDIF.
        IF table_index IS SUPPLIED.
          mv_evt_params-evt_list-table_index = table_index.
        ENDIF.
      WHEN zcl_mvcfw_base_salv_controller=>mc_display_salv_tree.
        IF r_top_of_page IS SUPPLIED.
          mv_evt_params-evt_tree-r_top_of_page = r_top_of_page.
        ENDIF.
        IF r_end_of_page IS SUPPLIED.
          mv_evt_params-evt_tree-r_end_of_page = r_end_of_page.
        ENDIF.
        IF page IS SUPPLIED.
          mv_evt_params-evt_tree-page = page.
        ENDIF.
        IF table_index IS SUPPLIED.
          mv_evt_params-evt_tree-table_index = table_index.
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD _get_current_stack.

    re_current_stack = lmv_current_stack.

  ENDMETHOD.
ENDCLASS.
