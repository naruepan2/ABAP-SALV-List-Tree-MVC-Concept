class ZCL_MVCFW_BASE_SALV_TREE_VIEW definition
  public
  create public .

public section.

  interfaces IF_OS_CLONE .
  interfaces ZIF_MVCFW_BASE_SALV_VIEW .

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
  aliases SETUP_CONTAINER
    for ZIF_MVCFW_BASE_SALV_VIEW~SETUP_CONTAINER .
  aliases SET_AGGREGATIONS
    for ZIF_MVCFW_BASE_SALV_VIEW~SET_AGGREGATIONS .
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

  constants C_EXPAND_ICON type SALV_DE_TREE_IMAGE value '@FO@' ##NO_TEXT.
  constants C_COLLAPSE_ICON type SALV_DE_TREE_IMAGE value '@FN@' ##NO_TEXT.
  constants C_STACK_MAIN type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  constants C_DEFLT_CNTL type SEOCLSNAME value 'LCL_CONTROLLER' ##NO_TEXT.
  constants C_DEFLT_VIEW type SEOCLSNAME value 'LCL_VIEW' ##NO_TEXT.

  events EVT_LINK_CLICK
    exporting
      value(COLUMNNAME) type LVC_FNAME optional
      value(NODE_KEY) type SALV_DE_NODE_KEY optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  events EVT_DOUBLE_CLICK
    exporting
      value(NODE_KEY) type SALV_DE_NODE_KEY optional
      value(COLUMNNAME) type LVC_FNAME optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  events EVT_KEYPRESS
    exporting
      value(NODE_KEY) type SALV_DE_NODE_KEY optional
      value(COLUMNNAME) type LVC_FNAME optional
      value(KEY) type SALV_DE_CONSTANT optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  events EVT_CHECKBOX_CHANGE
    exporting
      value(COLUMNNAME) type LVC_FNAME optional
      value(NODE_KEY) type SALV_DE_NODE_KEY optional
      value(CHECKED) type SAP_BOOL optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  events EVT_EXPAND_EMPTY_FOLDER
    exporting
      value(NODE_KEY) type SALV_DE_NODE_KEY optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  events EVT_TOP_OF_PAGE
    exporting
      value(R_TOP_OF_PAGE) type ref to CL_SALV_FORM optional
      value(PAGE) type SYPAGNO optional
      value(TABLE_INDEX) type SYINDEX optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  events EVT_END_OF_PAGE
    exporting
      value(R_END_OF_PAGE) type ref to CL_SALV_FORM optional
      value(PAGE) type SYPAGNO optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  events EVT_BEFORE_SALV_FUNCTION
    exporting
      value(E_SALV_FUNCTION) type SALV_DE_FUNCTION optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  events EVT_AFTER_SALV_FUNCTION
    exporting
      value(E_SALV_FUNCTION) type SALV_DE_FUNCTION optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  events EVT_ADDED_FUNCTION
    exporting
      value(E_SALV_FUNCTION) type SALV_DE_FUNCTION optional
      value(TREE_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      value(MODEL) type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .

  methods CONSTRUCTOR
    importing
      !IV_CNTL_NAME type SEOCLSNAME optional
      !IV_VIEW_NAME type SEOCLSNAME optional
      !IV_PFSTATUS type SYPFKEY optional
      !IV_VARIANT type SLIS_VARI optional .
  methods DISPLAY
    importing
      !IV_CREATE_DIRECTLY type SAP_BOOL optional
      !IR_CONTAINER type ref to CL_GUI_CONTAINER optional
      !IV_HIDE_HEADER type SAP_BOOL optional
      !IV_PFSTATUS type SYPFKEY optional
      !IV_VARIANT type SLIS_VARI optional
      !IV_START_COLUMN type I optional
      !IV_END_COLUMN type I optional
      !IV_START_LINE type I optional
      !IV_END_LINE type I optional
      !IV_NO_DISPLAY type SAP_BOOL optional
      !IV_ADAPTER_NAME type STRING optional
    changing
      !CT_DATA type TABLE optional
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW
    raising
      ZBCX_EXCEPTION .
  methods BUILD_DIRECT_SALV_TREE_NODE
    importing
      !IO_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW
    changing
      !CT_DATA type TABLE optional .
  methods GET_TREE_VIEW_INSTANCE
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW .
  methods GET_SALV_TREE_INSTANCE
    returning
      value(RO_TREE) type ref to CL_SALV_TREE .
  methods ADD_SALV_TREE_NODE
    importing
      !IV_RELATED_NODE type SALV_DE_NODE_KEY
      !IV_RELATIONSHIP type SALV_DE_NODE_RELATION default CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
      !IS_DATA_ROW type ANY optional
      !IV_COLLAPSED_ICON type SALV_DE_TREE_IMAGE default C_COLLAPSE_ICON
      !IV_EXPANDED_ICON type SALV_DE_TREE_IMAGE default C_EXPAND_ICON
      !IV_ROW_STYLE type SALV_DE_CONSTANT default IF_SALV_C_TREE_STYLE=>DEFAULT
      !IV_TEXT type ANY optional
      !IV_VISIBLE type SAP_BOOL default ABAP_TRUE
      !IV_EXPANDER type SAP_BOOL optional
      !IV_ENABLED type SAP_BOOL default ABAP_TRUE
      !IV_FOLDER type SAP_BOOL optional
      !IO_TREE type ref to CL_SALV_TREE
    exporting
      !EV_LAST_KEY type SALV_DE_NODE_KEY
      !ER_NODES type ref to CL_SALV_NODES
      !ER_NODE type ref to CL_SALV_NODE
    raising
      ZBCX_EXCEPTION .
  methods GET_SALV_TREE_NODES
    importing
      !IO_TREE type ref to CL_SALV_TREE
    exporting
      !ER_NODES type ref to CL_SALV_NODES
      !ET_ALL_NODES type SALV_T_NODES
    raising
      ZBCX_EXCEPTION .
  methods SET_CONTROLLER_LISTENER
    importing
      !IO_CONTROLLER type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW .
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
  data MO_SALV_TREE type ref to CL_SALV_TREE .
  data MV_ADAPTER_NAME type STRING .
  data MV_CURRENT_STACK type DFIES-TABNAME .

  methods _SETTING_COLUMNS
    exporting
      !EO_VALUE type ref to CL_SALV_COLUMNS_TREE
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW .
  methods _RAISE_EVT_LINK_CLICK
    for event LINK_CLICK of CL_SALV_EVENTS_TREE
    importing
      !COLUMNNAME
      !NODE_KEY .
  methods _RAISE_EVT_DOUBLE_CLICK
    for event DOUBLE_CLICK of CL_SALV_EVENTS_TREE
    importing
      !NODE_KEY
      !COLUMNNAME .
  methods _RAISE_EVT_KEYPRESS
    for event KEYPRESS of CL_SALV_EVENTS_TREE
    importing
      !NODE_KEY
      !COLUMNNAME
      !KEY .
  methods _RAISE_EVT_CHECKBOX_CHANGE
    for event CHECKBOX_CHANGE of CL_SALV_EVENTS_TREE
    importing
      !COLUMNNAME
      !NODE_KEY
      !CHECKED .
  methods _RAISE_EVT_EXPAND_EMPTY_FOLDER
    for event EXPAND_EMPTY_FOLDER of CL_SALV_EVENTS_TREE
    importing
      !NODE_KEY .
  methods _RAISE_EVT_ADDED_FUNCTION
    for event ADDED_FUNCTION of CL_SALV_EVENTS_TREE
    importing
      !E_SALV_FUNCTION .
  methods _RAISE_EVT_AFTER_SALV_FUNC
    for event AFTER_SALV_FUNCTION of CL_SALV_EVENTS_TREE
    importing
      !E_SALV_FUNCTION .
  methods _RAISE_EVT_BEFORE_SALV_FUNC
    for event BEFORE_SALV_FUNCTION of CL_SALV_EVENTS_TREE
    importing
      !E_SALV_FUNCTION .
  methods _RAISE_EVT_END_OF_PAGE
    for event END_OF_PAGE of CL_SALV_EVENTS_TREE
    importing
      !R_END_OF_PAGE
      !PAGE .
  methods _RAISE_EVT_TOP_OF_PAGE
    for event TOP_OF_PAGE of CL_SALV_EVENTS_TREE
    importing
      !R_TOP_OF_PAGE
      !PAGE
      !TABLE_INDEX .
private section.

  data MV_PF_STATUS type SYPFKEY .
  data MV_VARIANT type SLIS_VARI .

  methods _POPULATE_SETTING_COLUMNS
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW .
  methods _POPULATE_SETTING_COLUMNS_OLD
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW .
  methods _CREATE_SALV_TREE_OBJECT
    importing
      !IV_CREATE_DIRECTLY type SAP_BOOL optional
      !IR_CONTAINER type ref to CL_GUI_CONTAINER optional
      !IV_HIDE_HEADER type SAP_BOOL optional
    exporting
      !EV_ERR_MSG type STRING
      !EV_IS_CONTAINER type FLAG
    changing
      !CT_DATA type STANDARD TABLE optional
    returning
      value(RO_TREE) type ref to CL_SALV_TREE .
  methods _BUILD_SALV_TREE_NODE
    importing
      !IV_CREATE_DIRECTLY type SAP_BOOL optional
      !IO_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW
    changing
      !CT_DATA type TABLE
    raising
      ZBCX_EXCEPTION .
  methods _CHECK_SALV_TREE_PF_STATUS
    importing
      !IV_PFSTATUS type SYPFKEY optional .
  methods _CHECK_SALV_TREE_VARIANT_EXIST
    importing
      !IV_VARIANT type SLIS_VARI optional .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_SALV_TREE_VIEW IMPLEMENTATION.


  METHOD add_salv_tree_node.
    IF io_tree IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'IO_TREE is not bound'.
    ENDIF.

    CLEAR: er_nodes, er_node.

    er_nodes = io_tree->get_nodes( ).

    TRY.
        IF is_data_row IS SUPPLIED.
          er_node = er_nodes->add_node( related_node    = iv_related_node
                                        relationship    = iv_relationship
                                        data_row        = is_data_row
                                        collapsed_icon  = iv_collapsed_icon
                                        expanded_icon   = iv_expanded_icon
                                        row_style       = iv_row_style
                                        text            = CONV #( iv_text )
                                        visible         = iv_visible
                                        expander        = iv_expander
                                        enabled         = iv_enabled
                                        folder          = iv_folder ).
        ELSE.
          er_node = er_nodes->add_node( related_node    = iv_related_node
                                        relationship    = iv_relationship
*                                        data_row        = is_data_row
                                        collapsed_icon  = iv_collapsed_icon
                                        expanded_icon   = iv_expanded_icon
                                        row_style       = iv_row_style
                                        text            = CONV #( iv_text )
                                        visible         = iv_visible
                                        expander        = iv_expander
                                        enabled         = iv_enabled
                                        folder          = iv_folder ).
        ENDIF.

        ev_last_key = er_node->get_key( ).
      CATCH cx_salv_msg INTO DATA(lo_except).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = CONV #( lo_except->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD build_direct_salv_tree_node.
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


  METHOD CONSTRUCTOR.
    me->mv_cl_cntl_name = COND #( WHEN iv_cntl_name IS INITIAL THEN iv_cntl_name ELSE c_deflt_cntl ).
    me->mv_cl_view_name = COND #( WHEN iv_view_name IS INITIAL THEN iv_view_name ELSE c_deflt_view ).
    me->mv_pf_status    = COND #( WHEN iv_pfstatus  IS NOT INITIAL THEN iv_pfstatus ELSE me->mv_pf_status ).
    me->mv_variant      = COND #( WHEN iv_variant   IS NOT INITIAL THEN iv_variant  ELSE me->mv_variant ).
  ENDMETHOD.


  METHOD display.
    DATA: lv_err_msg      TYPE string,
          lv_is_container TYPE flag.

    ro_view = me.
*--------------------------------------------------------------------*
* Create new ALV instance
*--------------------------------------------------------------------*
    IF iv_create_directly IS NOT INITIAL.
      me->mo_salv_tree = _create_salv_tree_object( EXPORTING iv_create_directly = iv_create_directly
                                                              ir_container       = ir_container
                                                              iv_hide_header     = iv_hide_header
                                                    IMPORTING ev_err_msg         = lv_err_msg
                                                              ev_is_container    = lv_is_container
                                                    CHANGING  ct_data            = ct_data ).
    ELSE.
      me->mo_salv_tree = _create_salv_tree_object( EXPORTING ir_container    = ir_container
                                                              iv_hide_header  = iv_hide_header
                                                    IMPORTING ev_err_msg      = lv_err_msg
                                                              ev_is_container = lv_is_container
                                                    CHANGING  ct_data         = ct_data ).
    ENDIF.

    IF me->mo_salv_tree IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = CONV #( lv_err_msg ).
    ENDIF.

    TRY.
        _build_salv_tree_node( EXPORTING iv_create_directly = iv_create_directly
                                         io_view            = me
                               CHANGING  ct_data            = ct_data ).
      CATCH zbcx_exception INTO DATA(lo_expt).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = CONV #( lo_expt->get_text( ) ).
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
    set_pf_status_name( iv_pfstatus ).
    set_pf_status( iv_pfstatus ).

    IF lv_is_container IS INITIAL.
* Calling the top of page method, Can redefine method
      set_top_of_page( ).

* Calling the End of Page method, Can redefine method
      set_end_of_page( ).
    ENDIF.

* Setting and modify columns
    _setting_columns( )->modify_columns( it_columns        = me->mo_salv_tree->get_columns( )->get( )
                                         it_ref_cols_table = me->mo_salv_tree->get_columns( ) ).

* Add custom functions
    set_new_functions( ).
    set_functions( ).

* Set Layout
    set_layout( ).

* Set variant
    set_variant_name( iv_variant ).
    set_variant( iv_variant ).

* Set display settings
    set_display_settings( ).

* Set_aggregation
    set_aggregations( ).
*
* Set all events
    set_events( ).

* Set ALV as popup
    IF iv_start_column IS NOT INITIAL
   AND iv_start_line   IS NOT INITIAL.
      set_screen_popup( EXPORTING iv_start_column = iv_start_column
                                  iv_end_column   = iv_end_column
                                  iv_start_line   = iv_start_line
                                  iv_end_line     = iv_end_line ).
    ENDIF.

*--------------------------------------------------------------------*
* Displaying the SALV Tree
*--------------------------------------------------------------------*
    IF iv_no_display IS INITIAL.
      me->mo_salv_tree->display( ).
    ENDIF.
  ENDMETHOD.


  METHOD GET_SALV_TREE_INSTANCE.
    ro_tree = me->mo_salv_tree.
  ENDMETHOD.


  METHOD GET_TREE_VIEW_INSTANCE.
    ro_view = me.
  ENDMETHOD.


  METHOD SET_CONTROLLER_LISTENER.
    ro_view = me.

    IF io_controller IS BOUND.
      me->mo_controller = io_controller.
    ENDIF.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~close_screen.
    CHECK me->mo_salv_tree IS BOUND.

    me->mo_salv_tree->close_screen( ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~modify_columns.
    DATA: lr_tree_column  TYPE REF TO cl_salv_column_tree.

    LOOP AT it_columns INTO DATA(ls_column).
      TRY.
          lr_tree_column ?= ls_column-r_column.

          CASE ls_column-columnname.
            WHEN 'MANDT'
              OR 'ALV_TRAFF'
              OR 'ALV_S_COLOR'.
              lr_tree_column->set_technical( if_salv_c_bool_sap=>true ).
            WHEN 'CHKBOX'.
              lr_tree_column->set_optimized( if_salv_c_bool_sap=>true ).
              lr_tree_column->set_long_text( 'Select' ).
              lr_tree_column->set_medium_text( 'Select' ).
              lr_tree_column->set_short_text( 'Select' ).
            WHEN OTHERS.
              lr_tree_column->set_optimized( if_salv_c_bool_sap=>true ).
          ENDCASE.
        CATCH cx_salv_not_found.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_AGGREGATIONS.
*--------------------------------------------------------------------*
*   Sample code
*--------------------------------------------------------------------*
*    DATA: lr_aggrs TYPE REF TO cl_salv_aggregations.
*
*    CHECK me->mo_salv_tree IS BOUND.
*
*    lr_aggrs = me->mo_salv_tree->get_aggregations( ).
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


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_COLUMN_TEXT.
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
    DATA: lr_tree_setting TYPE REF TO cl_salv_tree_settings.
    DATA: lv_title TYPE salv_de_tree_text.

    CHECK me->mo_salv_tree IS BOUND.

* Get display object
    lr_tree_setting = me->mo_salv_tree->get_tree_settings( ).
    lr_tree_setting->set_hierarchy_header( 'Hierarchy' ).
    lr_tree_setting->set_hierarchy_tooltip( 'Hierarchy' ).
    lr_tree_setting->set_hierarchy_size( 40 ).

    lv_title = sy-title.
    lr_tree_setting->set_header( lv_title ).

  ENDMETHOD.


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_END_OF_PAGE.
  ENDMETHOD.


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_EVENTS.
*   Get the event object
    DATA: lr_events TYPE REF TO cl_salv_events_tree.

    CHECK me->mo_salv_tree IS BOUND.

    lr_events = me->mo_salv_tree->get_event( ).

    SET HANDLER me->_raise_evt_link_click
                me->_raise_evt_double_click
                me->_raise_evt_keypress
                me->_raise_evt_checkbox_change
                me->_raise_evt_expand_empty_folder
                me->_raise_evt_added_function
*                me->_raise_evt_after_salv_func
*                me->_raise_evt_before_salv_func
*                me->_raise_evt_end_of_page
*                me->_raise_evt_top_of_page
            FOR lr_events.
  ENDMETHOD.


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_FUNCTIONS.
*    DATA: lr_functions TYPE REF TO cl_salv_functions_tree.
*
*    CHECK me->mo_salv_tree IS BOUND.
*
*    lr_functions = me->mo_salv_tree->get_functions( ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_layout.
    DATA: lr_layout  TYPE REF TO cl_salv_layout.
    DATA: lf_variant TYPE slis_vari,
          ls_key     TYPE salv_s_layout_key.

    CHECK me->mo_salv_tree IS BOUND.

* Get layout object
    lr_layout = me->mo_salv_tree->get_layout( ).

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


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_MODEL.
    IF io_model IS BOUND.
      mo_model = io_model.
    ENDIF.
  ENDMETHOD.


  method ZIF_MVCFW_BASE_SALV_VIEW~SET_NEW_FUNCTIONS.
*--------------------------------------------------------------------*
*   Sample code
*--------------------------------------------------------------------*
*    DATA: lr_functions TYPE REF TO cl_salv_functions_tree.
*
*    CHECK me->mo_salv_tree IS BOUND.
*
*    lr_functions ?= me->mo_salv_tree->get_functions( ).
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
    DATA: lr_functions TYPE REF TO cl_salv_functions_tree.

    CHECK me->mo_salv_tree IS BOUND.

    _check_salv_tree_pf_status( ).

    IF iv_pfstatus       IS NOT INITIAL
    OR me->mv_pf_status IS NOT INITIAL.
      TRY.
          me->mo_salv_tree->set_screen_status(
            EXPORTING
              pfstatus      = COND #( WHEN iv_pfstatus IS NOT INITIAL THEN iv_pfstatus ELSE me->mv_pf_status )
              report        = sy-cprog
              set_functions = mo_salv_tree->c_functions_all ).
        CATCH cx_salv_method_not_supported
              cx_salv_object_not_found.
          lr_functions = me->mo_salv_tree->get_functions( ).
          IF lr_functions IS BOUND.
            lr_functions->set_all( abap_true ).
          ENDIF.
      ENDTRY.
    ELSE.
      lr_functions = me->mo_salv_tree->get_functions( ).
      lr_functions->set_all( ).
    ENDIF.
  ENDMETHOD.


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_PF_STATUS_NAME.
    IF iv_pfstatus IS NOT INITIAL.
      me->mv_pf_status = iv_pfstatus.
    ENDIF.
  ENDMETHOD.


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_SCREEN_POPUP.
    CHECK me->mo_salv_tree IS BOUND.

    me->mo_salv_tree->set_screen_popup( EXPORTING start_column = iv_start_column
                                                   end_column   = iv_end_column
                                                   start_line   = iv_start_line
                                                   end_line     = iv_end_line ).
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_stack_name.
    mv_current_stack = iv_stack_name.
  ENDMETHOD.


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_TOP_OF_PAGE.
  ENDMETHOD.


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_VARIANT.
    DATA: lr_layout  TYPE REF TO cl_salv_layout.
    DATA: lf_variant TYPE slis_vari,
          ls_key     TYPE salv_s_layout_key.

    CHECK me->mo_salv_tree IS BOUND.

* Get layout object
    lr_layout = me->mo_salv_tree->get_layout( ).

* Set initial Layout
    _check_salv_tree_variant_exist( ).

    IF mv_variant IS NOT INITIAL.
      lr_layout->set_initial_layout( me->mv_variant ).
    ENDIF.
  ENDMETHOD.


  METHOD ZIF_MVCFW_BASE_SALV_VIEW~SET_VARIANT_NAME.
    IF iv_variant IS NOT INITIAL.
      me->mv_variant = iv_variant.
    ENDIF.
  ENDMETHOD.


  METHOD _build_salv_tree_node.
    IF iv_create_directly IS NOT INITIAL.
      build_direct_salv_tree_node( EXPORTING io_view = me
                                   CHANGING  ct_data = ct_data ).
    ELSE.
      IF mo_model      IS BOUND
      OR mo_controller IS BOUND.
        TRY.
            IF mo_model IS BOUND.
              mo_model->build_salv_tree_node( EXPORTING io_view = me
                                               CHANGING  ct_data = ct_data ).
            ELSEIF mo_controller IS BOUND.
              mo_controller->o_model->build_salv_tree_node( EXPORTING io_view = me
                                                            CHANGING  ct_data = ct_data ).
            ENDIF.
          CATCH cx_sy_no_handler
                cx_sy_dyn_call_excp_not_found
                cx_sy_dyn_call_illegal_class
                cx_sy_dyn_call_illegal_method
                cx_sy_dyn_call_illegal_type
                cx_sy_dyn_call_param_missing
                cx_sy_dyn_call_param_not_found
                cx_sy_ref_is_initial
             INTO DATA(lo_exct_dyn).
            RAISE EXCEPTION TYPE zbcx_exception
              EXPORTING
                msgv1 = CONV #( lo_exct_dyn->get_text( ) ).
        ENDTRY.
      ELSE.
        build_direct_salv_tree_node( EXPORTING io_view = me
                                     CHANGING  ct_data = ct_data ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _CHECK_SALV_TREE_PF_STATUS.
    DATA: lr_data TYPE REF TO data.
    DATA: lt_status_function TYPE TABLE OF rsmpe_funl.
    DATA: lv_report   TYPE sy-cprog,
          lv_pfstatus TYPE sypfkey.

    lv_report   = COND #( WHEN me->mv_repid IS NOT INITIAL THEN me->mv_repid ELSE sy-cprog ).
    lv_pfstatus = COND #( WHEN iv_pfstatus   IS NOT INITIAL THEN iv_pfstatus   ELSE me->mv_pf_status ).

    CALL FUNCTION 'ALV_IMPORT_FROM_BUFFER_STATUS'
      EXPORTING
        i_report           = lv_report
        i_statusname       = lv_pfstatus
      CHANGING
        cr_status_function = lr_data
      EXCEPTIONS
        no_import          = 1
        OTHERS             = 2.
    IF sy-subrc EQ 0.
      me->mv_pf_status = lv_pfstatus.
    ELSE.
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
    ENDIF.
  ENDMETHOD.


  METHOD _CHECK_SALV_TREE_VARIANT_EXIST.
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


  METHOD _create_salv_tree_object.
    DATA: lr_container TYPE REF TO cl_gui_container.
    DATA: lo_tree TYPE REF TO data,
          lo_out  TYPE REF TO data.
    FIELD-SYMBOLS: <lft_data> TYPE STANDARD TABLE.

    IF iv_create_directly IS NOT INITIAL.
      TRY.
          CREATE DATA lo_tree LIKE ct_data.
          CHECK lo_tree IS BOUND.

          ASSIGN lo_tree->* TO <lft_data>.
          CHECK <lft_data> IS ASSIGNED.
        CATCH cx_sy_create_data_error INTO DATA(lo_expt_create).
          ev_err_msg = lo_expt_create->get_text( ).
          RETURN.
      ENDTRY.
    ELSE.
      TRY.
          IF ct_data IS NOT INITIAL
         AND ct_data IS SUPPLIED.
            CREATE DATA lo_tree LIKE ct_data.
            CHECK lo_tree IS BOUND.

            ASSIGN lo_tree->* TO <lft_data>.
            CHECK <lft_data> IS ASSIGNED.
          ELSEIF mo_model IS BOUND
              OR me->mo_controller IS BOUND.
            lo_out = COND #( WHEN mo_model IS BOUND
                              THEN mo_model->get_outtab( )
                             WHEN me->mo_controller->o_model IS BOUND
                              THEN me->mo_controller->o_model->get_outtab( ) ).
            CHECK lo_out IS BOUND.

            ASSIGN lo_out->* TO FIELD-SYMBOL(<lft_out>).
            CHECK <lft_out> IS ASSIGNED.

            CREATE DATA lo_tree LIKE <lft_out>.
            CHECK lo_tree IS BOUND.

            ASSIGN lo_tree->* TO <lft_data>.
            CHECK <lft_data> IS ASSIGNED.
          ELSE.
            RETURN.
          ENDIF.
        CATCH cx_sy_create_data_error INTO lo_expt_create.
          ev_err_msg = lo_expt_create->get_text( ).
          RETURN.
      ENDTRY.
    ENDIF.

    TRY.
        IF ir_container IS BOUND.
          me->set_container_top_of_page( ).
          me->set_container_end_of_page( ).
          me->create_container( EXPORTING ir_container    = ir_container
                                IMPORTING er_parent_grid  = lr_container
                                          ev_is_container = ev_is_container ).

          cl_salv_tree=>factory( EXPORTING r_container = ir_container
                                           hide_header = iv_hide_header
                                 IMPORTING r_salv_tree = ro_tree
                                 CHANGING  t_table     = <lft_data> ).
        ELSE.
          cl_salv_tree=>factory( EXPORTING hide_header = iv_hide_header
                                 IMPORTING r_salv_tree = ro_tree
                                 CHANGING  t_table     = <lft_data> ).
        ENDIF.
      CATCH cx_salv_no_new_data_allowed
            cx_salv_error
       INTO DATA(lo_expt_salv).
        ev_err_msg = lo_expt_salv->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD _populate_setting_columns.
    DATA: lr_tree_columns TYPE REF TO cl_salv_columns_tree,
          lr_tree_column  TYPE REF TO cl_salv_column_tree.
    DATA: lr_element TYPE REF TO cl_abap_datadescr.
    DATA: lr_tab TYPE REF TO data,
          lr_str TYPE REF TO data.
    DATA: lt_column_ref TYPE salv_t_column_ref.
    DATA: lv_set_traff TYPE flag,
          lv_condition TYPE string.
    FIELD-SYMBOLS: <lft_table> TYPE table,
                   <lfs_table> TYPE any,
                   <lf_val>    TYPE any.

    CHECK me->mo_salv_tree IS BOUND.

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

    IF <lfs_table> IS ASSIGNED.
      lr_tree_columns ?= me->mo_salv_tree->get_columns( ).

      IF lr_tree_columns IS BOUND.
        lt_column_ref = lr_tree_columns->get( ).
      ENDIF.

      LOOP AT CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_data( <lfs_table> )
                                )->components REFERENCE INTO DATA(lr_comp).
        "--------------------------------------------------------------------"
        READ TABLE lt_column_ref REFERENCE INTO DATA(lr_col_ref) WITH KEY columnname = lr_comp->name.
        IF sy-subrc = 0.
          CASE lr_col_ref->columnname.
            WHEN 'CHKBOX'
              OR 'CHECKBOX'.
              set_column_text( EXPORTING iv_all_text = 'Checkbox'
                                         ir_column   = lr_col_ref->r_column ).
            WHEN 'SELECT'.
              set_column_text( EXPORTING iv_all_text = 'Select'
                                         ir_column   = lr_col_ref->r_column ).
            WHEN OTHERS.
          ENDCASE.
        ENDIF.

        "--------------------------------------------------------------------"
        ASSIGN COMPONENT lr_comp->name OF STRUCTURE <lfs_table> TO FIELD-SYMBOL(<lf_field>).
        IF sy-subrc = 0.
          TRY.
              lr_element ?= cl_abap_datadescr=>describe_by_data( <lf_field> ).

              IF lr_element->absolute_name CP '*MANDT*'.
                lr_tree_column ?= lr_col_ref->r_column.

                IF lr_tree_column IS BOUND.
                  lr_tree_column->set_technical( if_salv_c_bool_sap=>true ).
                ENDIF.

                CONTINUE.
              ELSEIF lr_element->absolute_name = '\TYPE=LVC_T_SCOL'
                  OR lr_element->absolute_name = '\TYPE=BKK_LIGHTCODE'
                  OR lr_element->absolute_name = '\TYPE=SALV_T_INT4_COLUMN'
                  OR lr_element->absolute_name = '\TYPE=LVC_EMPHSZ'.
                lr_tree_column ?= lr_col_ref->r_column.

                IF lr_tree_column IS BOUND.
                  lr_tree_column->set_technical( if_salv_c_bool_sap=>true ).
                ENDIF.
              ELSE.
                CONTINUE.
              ENDIF.

              CASE lr_element->absolute_name.
                WHEN '\TYPE=BKK_LIGHTCODE'.         "ALV_TRAFF
                  TRY.
                      "Set the Exeception
                      lr_tree_columns->set_exception_column( value = 'ALV_TRAFF' ).
                    CATCH cx_salv_data_error.
                  ENDTRY.
                WHEN '\TYPE=LVC_T_SCOL'.            "ALV_C_COLOR
                  TRY.

                    CATCH cx_salv_data_error.
                  ENDTRY.
                WHEN '\TYPE=LVC_EMPHSZ'.            "ALV_S_COLOR
                  lr_tree_column->set_technical( if_salv_c_bool_sap=>true ).
                WHEN '\TYPE=SALV_T_INT4_COLUMN'.    "ALV_CELLTYPE
                  TRY.

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
        tree_view       = me
        model           = mo_model.
  ENDMETHOD.


  METHOD _raise_evt_after_salv_func.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_after_salv_function
      EXPORTING
        e_salv_function = e_salv_function
        tree_view       = me
        model           = mo_model.
  ENDMETHOD.


  METHOD _raise_evt_before_salv_func.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_before_salv_function
      EXPORTING
        e_salv_function = e_salv_function
        tree_view       = me
        model           = mo_model.
  ENDMETHOD.


  METHOD _raise_evt_checkbox_change.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_checkbox_change
      EXPORTING
        columnname = columnname
        node_key   = node_key
        checked    = checked
        tree_view  = me
        model      = mo_model.
  ENDMETHOD.


  METHOD _raise_evt_double_click.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_double_click
     EXPORTING
       node_key   = node_key
       columnname = columnname
       tree_view  = me
       model      = mo_model.
  ENDMETHOD.


  METHOD _raise_evt_end_of_page.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_end_of_page
      EXPORTING
        r_end_of_page = r_end_of_page
        page          = page
        tree_view     = me
        model         = mo_model.
  ENDMETHOD.


  METHOD _raise_evt_expand_empty_folder.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_expand_empty_folder
      EXPORTING
        node_key  = node_key
        tree_view = me
        model     = mo_model.
  ENDMETHOD.


  METHOD _raise_evt_keypress.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_keypress
      EXPORTING
        node_key   = node_key
        columnname = columnname
        key        = key
        tree_view  = me
        model      = mo_model.
  ENDMETHOD.


  METHOD _raise_evt_link_click.
*--------------------------------------------------------------------*
* Raise this event from CL_SALV_EVENTS_TABLE to ZCL_MVCFW_BASE_SALV_CONTROLLER
*--------------------------------------------------------------------*
    RAISE EVENT evt_link_click
     EXPORTING
       columnname  = columnname
       node_key    = node_key
       tree_view   = me
       model       = mo_model.
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
        tree_view     = me
        model         = mo_model.
  ENDMETHOD.


  METHOD _setting_columns.
    CHECK me->mo_salv_tree IS BOUND.

    ro_view  = me.
    eo_value = me->mo_salv_tree->get_columns( ).

*    me->mo_salv_tree->get_columns( )->set_optimize( abap_true ).

    _populate_setting_columns( ).
  ENDMETHOD.


  METHOD get_salv_tree_nodes.
    IF io_tree IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'IO_TREE is not bound'.
    ENDIF.

    CLEAR: er_nodes, et_all_nodes.

    er_nodes = io_tree->get_nodes( ).

    TRY.
        et_all_nodes = er_nodes->get_all_nodes( ).
      CATCH cx_salv_msg INTO DATA(lo_except).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = CONV #( lo_except->get_text( ) ).
    ENDTRY.
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
      er_parent_grid     = me->o_parent_grid.

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
**--------------------------------------------------------------------*
** Style
**   - 'ALV_GRID'
**   - 'ALV_TO_HTML'
**   - 'TREE'
**   - 'STAND_ALONE'
**--------------------------------------------------------------------*
*    lr_dyndoc_id = NEW #( style = 'TREE' ).
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
*    lr_dyndoc_id = NEW #( style = 'TREE' ).
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


  METHOD if_os_clone~clone.
    SYSTEM-CALL OBJMGR CLONE me TO result.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~get_data.
    rt_outtab = mt_outtab.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~get_model.
    ro_model = mo_model.
  ENDMETHOD.


  METHOD zif_mvcfw_base_salv_view~set_data.
    CHECK mo_salv_tree IS BOUND.

    mt_outtab = it_outtab.
    CHECK mt_outtab IS BOUND.

    ASSIGN mt_outtab->* TO FIELD-SYMBOL(<lft_outtab>).
    CHECK <lft_outtab> IS ASSIGNED.
    TRY.
        mo_salv_tree->set_data( CHANGING t_table = <lft_outtab> ).
      CATCH cx_salv_no_new_data_allowed
            cx_salv_error.
    ENDTRY.
  ENDMETHOD.


  METHOD _populate_setting_columns_old.
    DATA: lr_tree_columns TYPE REF TO cl_salv_columns_tree,
          lr_tree_column  TYPE REF TO cl_salv_column_tree.
    DATA: lr_tab TYPE REF TO data,
          lr_str TYPE REF TO data.
    DATA: lv_set_traff TYPE flag,
          lv_condition TYPE string.
    FIELD-SYMBOLS: <lft_table> TYPE table,
                   <lfs_table> TYPE any,
                   <lf_val>    TYPE any.

    CHECK me->mo_salv_tree IS BOUND.

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

    lr_tree_columns ?= me->mo_salv_tree->get_columns( ).
    CHECK lr_tree_columns IS BOUND.

*    LOOP AT me->mo_salv_tree->get_columns( )->get( ) INTO DATA(ls_column).
*      TRY.
*          lr_tree_column ?= ls_column-r_column.
*
*          CASE ls_column-columnname.
*            WHEN 'MANDT'
*              OR 'ALV_TRAFF'
*              OR 'ALV_S_COLOR'.
*              lr_tree_column->set_technical( if_salv_c_bool_sap=>true ).
*            WHEN OTHERS.
*              lr_tree_column->set_optimized( if_salv_c_bool_sap=>true ).
*          ENDCASE.
*        CATCH cx_salv_not_found.
*      ENDTRY.
*    ENDLOOP.

    IF <lfs_table> IS ASSIGNED.
      ASSIGN COMPONENT 'ALV_TRAFF' OF STRUCTURE <lfs_table> TO <lf_val>.
      IF sy-subrc EQ 0.
        TRY.
            lv_condition = 'ALV_TRAFF EQ 0'.

            DELETE <lft_table> WHERE (lv_condition).
            IF lines( <lft_table> ) GT 0.
              TRY.
                  "Set the Exeception
                  lr_tree_columns->set_exception_column( value = 'ALV_TRAFF' ).
                CATCH cx_salv_data_error.
              ENDTRY.
            ENDIF.
          CATCH cx_sy_itab_dyn_loop.
        ENDTRY.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
