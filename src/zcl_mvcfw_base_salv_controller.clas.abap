class ZCL_MVCFW_BASE_SALV_CONTROLLER definition
  public
  create public .

public section.

  types:
    BEGIN OF ty_list_view_param,
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
      END OF ty_list_view_param .
  types:
    BEGIN OF ty_tree_view_param,
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
      END OF ty_tree_view_param .
  types:
    BEGIN OF ty_stack,
        name       TYPE dfies-tabname,
        list_view  TYPE REF TO zcl_mvcfw_base_salv_list_view,
        list_param TYPE REF TO ty_list_view_param,
        tree_view  TYPE REF TO zcl_mvcfw_base_salv_tree_view,
        tree_param TYPE REF TO ty_tree_view_param,
        model      TYPE REF TO zcl_mvcfw_base_salv_model,
        controller TYPE REF TO zcl_mvcfw_base_salv_controller,
        is_main    TYPE flag,
        is_current TYPE flag,
        line       TYPE sy-index,
      END OF ty_stack .
  types:
    BEGIN OF ty_stack_name,
        line TYPE sy-index,
        name TYPE dfies-tabname,
      END OF ty_stack_name .
  types:
    tty_stack TYPE TABLE OF ty_stack WITH EMPTY KEY
                                       WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .
  types:
    tty_stack_name TYPE TABLE OF ty_stack_name WITH EMPTY KEY
                                                 WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .

  constants MC_STACK_MAIN type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  constants MC_DEFLT_CNTL type SEOCLSNAME value 'LCL_CONTROLLER' ##NO_TEXT.
  constants MC_DEFLT_MODEL type SEOCLSNAME value 'LCL_MODEL' ##NO_TEXT.
  constants MC_DEFLT_VIEW type SEOCLSNAME value 'LCL_VIEW' ##NO_TEXT.
  constants MC_DEFLT_LIST_VIEW type SEOCLSNAME value 'LCL_LIST_VIEW' ##NO_TEXT.
  constants MC_DEFLT_TREE_VIEW type SEOCLSNAME value 'LCL_TREE_VIEW' ##NO_TEXT.
  constants MC_DEFLT_SSCR type SEOCLSNAME value 'LCL_SSCR' ##NO_TEXT.
  constants MC_DEFLT_OUTTAB type DFIES-TABNAME value 'MT_OUTTAB' ##NO_TEXT.
  constants MC_DISPLAY_SALV_LIST type SALV_DE_CONSTANT value 1 ##NO_TEXT.
  constants MC_DISPLAY_SALV_TREE type SALV_DE_CONSTANT value 2 ##NO_TEXT.
  constants MC_DISPLAY_SALV_HIERSEQ type SALV_DE_CONSTANT value 3 ##NO_TEXT.
  data MO_SSCR type ref to ZCL_MVCFW_BASE_SSCR read-only .
  data MO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL read-only .
  data MO_LIST_VIEW type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW read-only .
  data MO_TREE_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW read-only .

  methods CONSTRUCTOR
    importing
      !IV_STACK_NAME type DFIES-TABNAME default MC_STACK_MAIN
      !IV_CNTL_NAME type SEOCLSNAME default MC_DEFLT_CNTL
      !IV_MODL_NAME type SEOCLSNAME default MC_DEFLT_MODEL
      !IV_VIEW_NAME type SEOCLSNAME default MC_DEFLT_VIEW
      !IV_SSCR_NAME type SEOCLSNAME default MC_DEFLT_SSCR
      !IV_SET_HANDLER type ABAP_BOOL default ABAP_TRUE .
  methods DISPLAY
    importing
      !IV_DISPLAY_TYPE type SALV_DE_CONSTANT optional
      !IV_LIST_DISPLAY type SAP_BOOL optional
      !IR_CONTAINER type ref to CL_GUI_CONTAINER optional
      !IV_CONTAINER_NAME type STRING optional
      !IV_HIDE_HEADER type SAP_BOOL optional
      !IV_PFSTATUS type SYPFKEY optional
      !IV_VARIANT type SLIS_VARI optional
      !IV_START_COLUMN type I optional
      !IV_END_COLUMN type I optional
      !IV_START_LINE type I optional
      !IV_END_LINE type I optional
    changing
      !CT_DATA type ref to DATA optional
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER
    raising
      ZBCX_EXCEPTION .
  methods POPULATE_SETUP_BEFORE_DISPLAY
    importing
      !IV_DISPLAY_TYPE type SALV_DE_CONSTANT optional
    changing
      !CR_LIST_PARAM type ref to TY_LIST_VIEW_PARAM optional
      !CR_TREE_PARAM type ref to TY_TREE_VIEW_PARAM optional .
  methods GET_CURRENT_STACK_NAME
    returning
      value(RV_CURRENT_STACK) type DFIES-TABNAME .
  methods SET_STACK_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME
      !IO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      !IO_LIST_VIEW type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      !IO_TREE_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      !IV_NOT_CHECKED type FLAG optional
    exporting
      value(EV_STACK_NAME) type DFIES-TABNAME
      !EO_CONTROLLER type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER .
  methods DESTROY_STACK
    importing
      !IV_NAME type DFIES-TABNAME optional
      !IV_CURRENT_NAME type DFIES-TABNAME optional .
  methods GET_STACK_BY_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME
    returning
      value(RS_STACK) type ref to TY_STACK .
  methods GET_ALL_STACK
    returning
      value(RT_STACK) type TTY_STACK .
  methods GET_SALV_PARAMETERS
    returning
      value(RO_SALV_PARAM) type ref to TY_LIST_VIEW_PARAM .
  methods CREATE_NEW_VIEW_INSTANCE
    importing
      !IV_DISPLAY_TYPE type SALV_DE_CONSTANT optional
      value(IV_STACK_NAME) type DFIES-TABNAME
      !IO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      !IO_LIST_VIEW type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      !IO_TREE_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      !IR_EVENT_LIST type ref to ZCL_MVCFW_BASE_SALV_MODEL=>TY_EVT_LIST_PARAM optional
      !IR_EVENT_TREE type ref to ZCL_MVCFW_BASE_SALV_MODEL=>TY_EVT_TREE_PARAM optional
      !IO_CONTROLLER type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER optional
      !IV_DISPLAY type FLAG optional
      !IV_DESTROY type FLAG optional
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER
    raising
      ZBCX_EXCEPTION .
  methods GET_CONTROLLER_INSTANCE
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
      !IV_CREATE_NEW type FLAG default ABAP_TRUE
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER .
  methods PROCESS_ANY_MODEL
    importing
      !IV_METHOD type SEOCLSNAME
      !IT_PARAM type ABAP_PARMBIND_TAB optional
      !IT_EXCPT type ABAP_EXCPBIND_TAB optional
    raising
      ZBCX_EXCEPTION .
  methods HANDLE_SSCR_PBO
    importing
      !IV_DYNNR type SY-DYNNR default SY-DYNNR .
  methods HANDLE_SSCR_PAI
    importing
      !IV_DYNNR type SY-DYNNR default SY-DYNNR .
  methods HANDLE_LIST_LINK_CLICK
    for event EVT_LINK_CLICK of ZCL_MVCFW_BASE_SALV_LIST_VIEW
    importing
      !ROW
      !COLUMN
      !LIST_VIEW .
  methods HANDLE_LIST_DOUBLE_CLICK
    for event EVT_DOUBLE_CLICK of ZCL_MVCFW_BASE_SALV_LIST_VIEW
    importing
      !ROW
      !COLUMN
      !LIST_VIEW .
  methods HANDLE_LIST_ADD_FUNCTION
    for event EVT_ADDED_FUNCTION of ZCL_MVCFW_BASE_SALV_LIST_VIEW
    importing
      !E_SALV_FUNCTION
      !LIST_VIEW .
  methods HANDLE_LIST_AFTER_FUNCTION
    for event EVT_AFTER_SALV_FUNCTION of ZCL_MVCFW_BASE_SALV_LIST_VIEW
    importing
      !E_SALV_FUNCTION
      !LIST_VIEW .
  methods HANDLE_LIST_BEFORE_FUNCTION
    for event EVT_BEFORE_SALV_FUNCTION of ZCL_MVCFW_BASE_SALV_LIST_VIEW
    importing
      !E_SALV_FUNCTION
      !LIST_VIEW .
  methods HANDLE_LIST_END_OF_PAGE
    for event EVT_END_OF_PAGE of ZCL_MVCFW_BASE_SALV_LIST_VIEW
    importing
      !R_END_OF_PAGE
      !PAGE
      !LIST_VIEW .
  methods HANDLE_LIST_TOP_OF_PAGE
    for event EVT_TOP_OF_PAGE of ZCL_MVCFW_BASE_SALV_LIST_VIEW
    importing
      !R_TOP_OF_PAGE
      !PAGE
      !TABLE_INDEX
      !LIST_VIEW .
  methods HANDLE_LIST_CHECK_CHANGED_DATA
    for event EVT_CHECK_CHANGED_DATA of ZCL_MVCFW_BASE_SALV_LIST_VIEW
    importing
      !T_MODIFIED_CELLS
      !T_GOOD_CELLS
      !T_DELETED_ROWS
      !T_INSERTED_ROWS
      !RT_MODIFIED_DATA_ROWS
      !O_UI_DATA_MODIFY
      !O_UI_EDIT_PROTOCOL .
  methods HANDLE_LIST_F4_REQUEST
    importing
      !FIELDNAME type LVC_FNAME optional
      !FIELDVALUE type LVC_VALUE optional
      !S_ROW_NO type LVC_S_ROID optional
      !T_BAD_CELLS type LVC_T_MODI optional
      !DISPLAY type CHAR01 optional
      !LIST_VIEW type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
    changing
      !XRT_F4_DATA type ref to DATA
    returning
      value(EVENT_HANDLED) type ABAP_BOOL .
  methods HANDLE_LIST_CONTEXT_MENU
    changing
      !XO_CONTEXT_MENU type ref to CL_CTMENU .
  methods HANDLE_TREE_LINK_CLICK
    for event EVT_LINK_CLICK of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !COLUMNNAME
      !NODE_KEY
      !TREE_VIEW .
  methods HANDLE_TREE_DOUBLE_CLICK
    for event EVT_DOUBLE_CLICK of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !NODE_KEY
      !COLUMNNAME
      !TREE_VIEW .
  methods HANDLE_TREE_KEYPRESS
    for event EVT_KEYPRESS of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !NODE_KEY
      !COLUMNNAME
      !KEY
      !TREE_VIEW .
  methods HANDLE_TREE_CHECKBOX_CHANGE
    for event EVT_CHECKBOX_CHANGE of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !COLUMNNAME
      !NODE_KEY
      !CHECKED
      !TREE_VIEW .
  methods HANDLE_TREE_EXPAND_EMPTY_FOLDR
    for event EVT_EXPAND_EMPTY_FOLDER of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !NODE_KEY
      !TREE_VIEW .
  methods HANDLE_TREE_ADD_FUNCTION
    for event EVT_ADDED_FUNCTION of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !E_SALV_FUNCTION
      !TREE_VIEW .
  methods HANDLE_TREE_AFTER_FUNCTION
    for event EVT_AFTER_SALV_FUNCTION of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !E_SALV_FUNCTION
      !TREE_VIEW .
  methods HANDLE_TREE_BEFORE_FUNCTION
    for event EVT_BEFORE_SALV_FUNCTION of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !E_SALV_FUNCTION
      !TREE_VIEW .
  methods HANDLE_TREE_END_OF_PAGE
    for event EVT_END_OF_PAGE of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !R_END_OF_PAGE
      !PAGE
      !TREE_VIEW .
  methods HANDLE_TREE_TOP_OF_PAGE
    for event EVT_TOP_OF_PAGE of ZCL_MVCFW_BASE_SALV_TREE_VIEW
    importing
      !R_TOP_OF_PAGE
      !PAGE
      !TABLE_INDEX
      !TREE_VIEW .
  methods AUTO_GENERATE_STACK_NAME
    returning
      value(RV_STACK_NAME) type DFIES-TABNAME .
  methods CLONE
    returning
      value(RESULT) type ref to OBJECT .
  PROTECTED SECTION.

    CLASS-DATA lmt_stack_called TYPE tty_stack_name .
    DATA lmo_controller TYPE REF TO zcl_mvcfw_base_salv_controller .
    CLASS-DATA lmt_stack TYPE tty_stack .
    CONSTANTS lmc_obj_model TYPE seoclsname VALUE 'MODEL' ##NO_TEXT.
    CONSTANTS lmc_obj_list_view TYPE seoclsname VALUE 'LIST_VIEW' ##NO_TEXT.
    CONSTANTS lmc_obj_tree_view TYPE seoclsname VALUE 'TREE_VIEW' ##NO_TEXT.
    DATA lmv_cl_view_name TYPE char30 .
    DATA lmv_cl_modl_name TYPE char30 .
    DATA lmv_cl_sscr_name TYPE char30 .
    DATA lmv_cl_cntl_name TYPE char30 .
    DATA lmt_direct_outtab TYPE REF TO data .

    METHODS _display_salv_grid
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
    METHODS _auto_gen_stack_name
      EXPORTING
        !ev_stack_name       TYPE dfies-tabname
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_salv_controller .
private section.

  types:
    BEGIN OF lty_class_type,
        sscr       TYPE flag,
        model      TYPE flag,
        salv_view  TYPE flag,
        tree_view  TYPE flag,
        controller TYPE flag,
      END OF lty_class_type .

  data LMR_LIST_PARAM type ref to TY_LIST_VIEW_PARAM .
  data LMR_TREE_PARAM type ref to TY_TREE_VIEW_PARAM .
  data LMV_TRIGGERED_EVT type SEOCPDNAME .
  data LMV_CURRENT_STACK type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  data LMO_CURRENT_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  data LMO_CURRENT_LIST_VIEW type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW .
  data LMO_CURRENT_TREE_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW .
  constants LMC_BASE_CNTL type SEOCLSNAME value 'ZCL_MVCFW_BASE_SALV_CONTROLLER' ##NO_TEXT.
  constants LMC_BASE_MODEL type SEOCLSNAME value 'ZCL_MVCFW_BASE_SALV_MODEL' ##NO_TEXT.
  constants LMC_BASE_SALV_VIEW type SEOCLSNAME value 'ZCL_MVCFW_BASE_SALV_LIST_VIEW' ##NO_TEXT.
  constants LMC_BASE_TREE_VIEW type SEOCLSNAME value 'ZCL_MVCFW_BASE_SALV_TREE_VIEW' ##NO_TEXT.
  constants LMC_BASE_SSCR type SEOCLSNAME value 'ZCL_MVCFW_BASE_SSCR' ##NO_TEXT.
  data LMV_IS_DIRECT_OUTTAB type FLAG .

  methods _VALIDATE_DISPLAY_TYPE
    importing
      !IV_DISPLAY_TYPE type SALV_DE_CONSTANT
    returning
      value(RV_DISPLAY_TYPE) type SALV_DE_CONSTANT .
  methods _SETUP_PARAMETERS_TO_SALV
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
      !IV_LIST_DISPLAY type SAP_BOOL optional
      !IR_CONTAINER type ref to CL_GUI_CONTAINER optional
      !IV_CONTAINER_NAME type STRING optional
      !IV_PFSTATUS type SYPFKEY optional
      !IV_VARIANT type SLIS_VARI optional
      !IV_START_COLUMN type I optional
      !IV_END_COLUMN type I optional
      !IV_START_LINE type I optional
      !IV_END_LINE type I optional
    exporting
      !ER_STACK type ref to TY_STACK
      !ER_VIEW_PARAM type ref to TY_LIST_VIEW_PARAM
    changing
      !CT_DATA type ref to DATA optional
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER
    raising
      ZBCX_EXCEPTION .
  methods _SETUP_PARAMETERS_TO_TREE
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
      !IR_CONTAINER type ref to CL_GUI_CONTAINER optional
      !IV_HIDE_HEADER type SAP_BOOL optional
      !IV_PFSTATUS type SYPFKEY optional
      !IV_VARIANT type SLIS_VARI optional
      !IV_START_COLUMN type I optional
      !IV_END_COLUMN type I optional
      !IV_START_LINE type I optional
      !IV_END_LINE type I optional
    exporting
      !ER_STACK type ref to TY_STACK
    changing
      !CT_DATA type ref to DATA optional
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER
    raising
      ZBCX_EXCEPTION .
  methods _CHECK_SETUP_BEFORE_DISPLAY
    importing
      !IV_DISPLAY_TYPE type SALV_DE_CONSTANT
    changing
      !CR_LIST_PARAM type ref to TY_LIST_VIEW_PARAM optional
      !CR_TREE_PARAM type ref to TY_TREE_VIEW_PARAM optional .
  methods _CREATE_ANY_OBJECT
    importing
      !IV_CLASS_NAME type SEOCLSNAME
      !IS_CLASS_TYPE type LTY_CLASS_TYPE
    exporting
      !EV_CLASS_NAME type SEOCLSNAME
    returning
      value(RO_CLASS) type ref to OBJECT .
  methods _BUILD_STACK
    importing
      !IV_NAME type DFIES-TABNAME
      !IO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      !IO_LIST_VIEW type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      !IR_LIST_VIEW_PARAM type ref to TY_LIST_VIEW_PARAM optional
      !IO_TREE_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
      !IR_TREE_VIEW_PARAM type ref to TY_TREE_VIEW_PARAM optional
      !IO_CONTROLLER type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER optional .
  methods _GET_STACK
    importing
      !IV_NAME type DFIES-TABNAME
    returning
      value(RS_STACK) type ref to TY_STACK .
  methods _SET_DYNP_STACK_NAME
    importing
      !IO_STACK type ref to TY_STACK
      !IV_OBJECT_NAME type DFIES-TABNAME
      !IV_STACK_NAME type DFIES-TABNAME
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER .
  methods _GET_OUTTAB_MODEL
    returning
      value(RO_OUTTAB) type ref to DATA .
  methods _SET_MODEL
    importing
      !IO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL
    exporting
      !EO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL
      !EO_CURRENT_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods _SET_VIEW
    importing
      !IO_LIST_VIEW type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW optional
      !IO_TREE_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW optional
    exporting
      !EO_LIST_VIEW type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW
      !EO_CURRENT_LIST_VIEW type ref to ZCL_MVCFW_BASE_SALV_LIST_VIEW
      !EO_TREE_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW
      !EO_CURRENT_TREE_VIEW type ref to ZCL_MVCFW_BASE_SALV_TREE_VIEW .
  methods _GET_ABAP_CALL_STACK
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER .
  methods _SET_EVENTS_PARAM_TO_MODEL
    importing
      !IO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL
      !IR_EVENT_LIST type ref to ZCL_MVCFW_BASE_SALV_MODEL=>TY_EVT_LIST_PARAM optional
      !IR_EVENT_TREE type ref to ZCL_MVCFW_BASE_SALV_MODEL=>TY_EVT_TREE_PARAM optional
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_SALV_CONTROLLER .
  methods _SET_DIRECT_OUTTAB
    changing
      !CT_DATA type ref to DATA .
  methods _CLEAR_DIRECT_OUTTAB .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_SALV_CONTROLLER IMPLEMENTATION.


  METHOD constructor.
    TRY.
        mo_sscr  ?= _create_any_object( EXPORTING iv_class_name = iv_sscr_name
                                                  is_class_type = VALUE #( sscr = abap_true )
                                        IMPORTING ev_class_name = lmv_cl_sscr_name ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        mo_model ?= _create_any_object( EXPORTING iv_class_name = iv_modl_name
                                                  is_class_type = VALUE #( model = abap_true )
                                        IMPORTING ev_class_name = lmv_cl_modl_name ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        mo_list_view  ?= _create_any_object( EXPORTING iv_class_name = iv_view_name
                                                       is_class_type = VALUE #( salv_view = abap_true )
                                             IMPORTING ev_class_name = lmv_cl_view_name ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        mo_tree_view  ?= _create_any_object( EXPORTING iv_class_name = iv_view_name
                                                       is_class_type = VALUE #( tree_view = abap_true )
                                             IMPORTING ev_class_name = lmv_cl_view_name ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.

    TRY.
        lmo_controller         ?= me.
        lmo_current_model      ?= mo_model.
        lmo_current_list_view  ?= mo_list_view.
        lmo_current_tree_view  ?= mo_tree_view.
        lmv_current_stack       = COND #( WHEN iv_stack_name IS NOT INITIAL THEN |{ iv_stack_name CASE = UPPER }|
                                          ELSE mc_stack_main ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
  ENDMETHOD.


  METHOD create_new_view_instance.
    DATA: lo_model_imp     TYPE REF TO zcl_mvcfw_base_salv_model,
          lo_list_view_imp TYPE REF TO zcl_mvcfw_base_salv_list_view,
          lo_tree_view_imp TYPE REF TO zcl_mvcfw_base_salv_tree_view.
    DATA: lo_model     LIKE lo_model_imp,
          lo_list_view TYPE REF TO zcl_mvcfw_base_salv_list_view,
          lo_tree_view TYPE REF TO zcl_mvcfw_base_salv_tree_view.

    IF iv_stack_name IS INITIAL.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Must enter stack name'.
    ENDIF.

    ro_controller = me.

    TRY.
        lo_model_imp ?= COND #( WHEN io_model IS BOUND THEN io_model
                                WHEN lmo_current_model IS BOUND THEN lmo_current_model
                                ELSE mo_model ).
      CATCH cx_sy_move_cast_error.
        lo_model_imp ?= COND #( WHEN lmo_current_model IS BOUND THEN lmo_current_model
                                ELSE mo_model ).
    ENDTRY.
    TRY.
        lo_list_view_imp ?= COND #( WHEN io_list_view IS BOUND THEN io_list_view
                                    WHEN lmo_current_list_view IS BOUND THEN lmo_current_list_view
                                    ELSE mo_list_view ).
      CATCH cx_sy_move_cast_error.
        lo_list_view_imp ?= COND #( WHEN lmo_current_list_view IS BOUND THEN lmo_current_list_view
                                    ELSE mo_list_view ).
    ENDTRY.
    TRY.
        lo_tree_view_imp ?= COND #( WHEN io_tree_view IS BOUND THEN io_tree_view
                                    WHEN lmo_current_tree_view IS BOUND THEN lmo_current_tree_view
                                    ELSE mo_tree_view ).
      CATCH cx_sy_move_cast_error.
        lo_tree_view_imp ?= COND #( WHEN lmo_current_tree_view IS BOUND THEN lmo_current_tree_view
                                    ELSE mo_tree_view ).
    ENDTRY.

    lo_model ?= lo_model_imp.

    IF lo_list_view_imp IS BOUND.
      lo_list_view ?= lo_list_view_imp->clone( ).
    ENDIF.
    IF lo_tree_view_imp IS BOUND.
      lo_tree_view ?= lo_tree_view_imp->clone( ).
    ENDIF.

    _get_abap_call_stack( )->_set_events_param_to_model( io_model      = lo_model
                                                         ir_event_list = ir_event_list
                                                         ir_event_tree = ir_event_tree ).

    set_stack_name( EXPORTING iv_stack_name = |{ iv_stack_name CASE = UPPER }|
                              io_model      = lo_model
                              io_list_view  = lo_list_view
                              io_tree_view  = lo_tree_view
                    IMPORTING eo_controller = DATA(lo_controller) ).
    IF iv_display    IS NOT INITIAL
   AND lo_controller IS BOUND.
      lo_controller->display( EXPORTING iv_display_type = iv_display_type ).
    ENDIF.
    IF iv_destroy    IS NOT INITIAL
   AND lo_controller IS BOUND.
      lo_controller->destroy_stack( ).
    ENDIF.

  ENDMETHOD.


  METHOD destroy_stack.
    DATA: ls_stack_called LIKE LINE OF lmt_stack_called,
          ls_stack        LIKE LINE OF lmt_stack.
    FIELD-SYMBOLS <lfs_stack_called> LIKE LINE OF lmt_stack_called.

    "--------------------------------------------------------------------"
    " Delete lastest stack
    "--------------------------------------------------------------------"
    IF iv_name IS INITIAL.
      READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
      IF sy-subrc EQ 0.
        DELETE: lmt_stack_called WHERE line EQ ls_stack_called-line,
                lmt_stack        WHERE name EQ ls_stack_called-name.
      ENDIF.

      "--------------------------------------------------------------------"
      " Read and set previous stack
      "--------------------------------------------------------------------"
      READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
      IF sy-subrc EQ 0.
        READ TABLE lmt_stack INTO ls_stack
          WITH KEY k2
            COMPONENTS name = ls_stack_called-name.
        IF sy-subrc EQ 0.
          lmo_controller        ?= ls_stack-controller.
          lmo_current_model     ?= ls_stack-model.
          lmo_current_list_view ?= ls_stack-list_view.
          lmo_current_tree_view ?= ls_stack-tree_view.

          set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                    io_model       = lmo_current_model
                                    io_list_view   = lmo_current_list_view
                                    io_tree_view   = lmo_current_tree_view
                                    iv_not_checked = abap_true ).
        ENDIF.
      ENDIF.
    ELSE.
      "--------------------------------------------------------------------"
      " Delete stack with specific stack name
      "--------------------------------------------------------------------"
      READ TABLE lmt_stack_called INTO ls_stack_called
        WITH KEY k2
          COMPONENTS name = |{ iv_name CASE = UPPER }|.
      IF sy-subrc EQ 0.
        DELETE: lmt_stack_called WHERE line EQ ls_stack_called-line,
                lmt_stack        WHERE name EQ ls_stack_called-name.
      ENDIF.

      "--------------------------------------------------------------------"
      " Read and set previous stack
      "--------------------------------------------------------------------"
      SORT lmt_stack_called BY line.

      LOOP AT lmt_stack_called ASSIGNING <lfs_stack_called>.
        <lfs_stack_called>-line = sy-tabix.
      ENDLOOP.

      IF iv_current_name IS NOT INITIAL.
        READ TABLE lmt_stack_called  INTO ls_stack_called
          WITH KEY k2
            COMPONENTS name = |{ iv_current_name CASE = UPPER }|.
        IF sy-subrc NE 0.
          READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
        ENDIF.
        IF sy-subrc EQ 0.
          READ TABLE lmt_stack INTO ls_stack
            WITH KEY k2
              COMPONENTS name = ls_stack_called-name.
          IF sy-subrc EQ 0.
            lmo_controller        ?= ls_stack-controller.
            lmo_current_model     ?= ls_stack-model.
            lmo_current_list_view ?= ls_stack-list_view.
            lmo_current_tree_view ?= ls_stack-tree_view.

            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = lmo_current_model
                                      io_list_view   = lmo_current_list_view
                                      io_tree_view   = lmo_current_tree_view
                                      iv_not_checked = abap_true ).
          ENDIF.
        ENDIF.
      ELSE.
        READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
        IF sy-subrc EQ 0.
          READ TABLE lmt_stack INTO ls_stack
            WITH KEY k2
              COMPONENTS name = ls_stack_called-name.
          IF sy-subrc EQ 0.
            lmo_controller        ?= ls_stack-controller.
            lmo_current_model     ?= ls_stack-model.
            lmo_current_list_view ?= ls_stack-list_view.
            lmo_current_tree_view ?= ls_stack-tree_view.

            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = lmo_current_model
                                      io_list_view   = lmo_current_list_view
                                      io_tree_view   = lmo_current_tree_view
                                      iv_not_checked = abap_true ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

    "--------------------------------------------------------------------"
    " Try to replace SALV parameters with previous parameters
    "--------------------------------------------------------------------"
    READ TABLE lmt_stack INTO ls_stack WITH KEY is_current = abap_true.
    IF sy-subrc EQ 0.
      lmr_list_param = COND #( WHEN ls_stack-list_param IS BOUND THEN ls_stack-list_param ELSE NEW #( ) ).
    ENDIF.
  ENDMETHOD.


  METHOD display.
    DATA lo_except TYPE REF TO zbcx_exception.
    DATA lv_display_type TYPE salv_de_constant.

    ro_controller   = me.

    lv_display_type = _validate_display_type( iv_display_type ).

    IF ct_data IS SUPPLIED.
      _set_direct_outtab( CHANGING ct_data = ct_data ).
    ELSE.
      _clear_direct_outtab( ).
    ENDIF.

    CASE lv_display_type.
      WHEN mc_display_salv_list.
        TRY.
            _setup_parameters_to_salv(
              EXPORTING
                iv_stack_name     = lmv_current_stack
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
                ct_data           = ct_data ).

            _display_salv_grid(
              CHANGING
                ct_data = ct_data ).
          CATCH zbcx_exception INTO lo_except.
            RAISE EXCEPTION TYPE zbcx_exception
              EXPORTING
                msgv1 = lo_except->msgv1.
        ENDTRY.
      WHEN mc_display_salv_tree.
        TRY.
            _setup_parameters_to_tree(
              EXPORTING
                iv_stack_name     = lmv_current_stack
                ir_container      = ir_container
                iv_hide_header    = iv_hide_header
                iv_pfstatus       = iv_pfstatus
                iv_variant        = iv_variant
                iv_start_column   = iv_start_column
                iv_end_column     = iv_end_column
                iv_start_line     = iv_start_line
                iv_end_line       = iv_end_line
              CHANGING
                ct_data           = ct_data ).

            _display_salv_tree(
              EXPORTING
                iv_create_directly = COND #( WHEN ct_data IS SUPPLIED THEN abap_true ELSE abap_false )
              CHANGING
                ct_data            = ct_data ).
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
  ENDMETHOD.


  METHOD get_all_stack.
    rt_stack = lmt_stack.
  ENDMETHOD.


  METHOD get_controller_instance.
    DATA lv_stack_name TYPE dfies-tabname.

    lv_stack_name = COND #( WHEN iv_stack_name IS NOT INITIAL THEN iv_stack_name ELSE lmv_current_stack ).

    READ TABLE lmt_stack INTO DATA(ls_stack)
      WITH KEY k2 COMPONENTS name = lv_stack_name.
    IF sy-subrc EQ 0.
      IF ls_stack-controller IS BOUND.
        ro_controller ?= ls_stack-controller.
      ELSEIF iv_create_new IS NOT INITIAL.
        IF lmo_controller IS NOT BOUND.
          lmo_controller = NEW #( ).
        ENDIF.

        ro_controller ?= lmo_controller.
      ENDIF.
    ELSE.
      IF iv_create_new IS NOT INITIAL.
        IF lmo_controller IS NOT BOUND.
          lmo_controller = NEW #( ).
        ENDIF.

        ro_controller ?= lmo_controller.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_current_stack_name.
    rv_current_stack = lmv_current_stack.
  ENDMETHOD.


  METHOD get_salv_parameters.
    ro_salv_param = lmr_list_param.
  ENDMETHOD.


  METHOD get_stack_by_name.
    CHECK iv_stack_name IS NOT INITIAL.

    rs_stack = me->_get_stack( EXPORTING iv_name = iv_stack_name ).
  ENDMETHOD.


  METHOD handle_list_add_function.
  ENDMETHOD.


  METHOD handle_list_after_function.
  ENDMETHOD.


  METHOD handle_list_before_function.
  ENDMETHOD.


  METHOD handle_list_check_changed_data.
  ENDMETHOD.


  METHOD handle_list_context_menu.
  ENDMETHOD.


  METHOD handle_list_double_click.
  ENDMETHOD.


  METHOD handle_list_end_of_page.
  ENDMETHOD.


  METHOD handle_list_f4_request.
  ENDMETHOD.


  METHOD handle_list_link_click.
    FIELD-SYMBOLS: <lft_outtab> TYPE table,
                   <lfs_out>    TYPE any,
                   <lf_value>   TYPE any.

    IF me->lmv_is_direct_outtab IS INITIAL.
      DATA(lr_out) = _get_outtab_model( ).
      CHECK lr_out IS BOUND.

      ASSIGN lr_out->* TO <lft_outtab>.
      CHECK <lft_outtab> IS ASSIGNED.

      READ TABLE <lft_outtab> ASSIGNING <lfs_out> INDEX row.
      IF sy-subrc EQ 0.
        IF column EQ 'CHKBOX'.
          ASSIGN COMPONENT column OF STRUCTURE <lfs_out> TO <lf_value>.
          IF sy-subrc EQ 0.
            <lf_value> = COND #( WHEN <lf_value> IS INITIAL THEN abap_true ELSE abap_false ).
          ENDIF.
        ENDIF.
      ENDIF.
    ELSE.
      CHECK me->lmt_direct_outtab IS BOUND.

      ASSIGN me->lmt_direct_outtab->* TO <lft_outtab>.
      CHECK <lft_outtab> IS ASSIGNED.

      READ TABLE <lft_outtab> ASSIGNING <lfs_out> INDEX row.
      IF sy-subrc EQ 0.
        IF column EQ 'CHKBOX'.
          ASSIGN COMPONENT column OF STRUCTURE <lfs_out> TO <lf_value>.
          IF sy-subrc EQ 0.
            <lf_value> = COND #( WHEN <lf_value> IS INITIAL THEN abap_true ELSE abap_false ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

    list_view->get_view_instance( )->refresh( ).
*    cl_gui_cfw=>flush( ).
  ENDMETHOD.


  METHOD handle_list_top_of_page.
  ENDMETHOD.


  METHOD handle_sscr_pai.
    IF mo_sscr IS NOT BOUND.
      mo_sscr = NEW #( ).
    ENDIF.
    IF mo_sscr IS BOUND.
      mo_sscr->pai( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_sscr_pbo.
    IF mo_sscr IS NOT BOUND.
      mo_sscr = NEW #( ).
    ENDIF.
    IF mo_sscr IS BOUND.
      mo_sscr->pbo( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_tree_add_function.
  ENDMETHOD.


  METHOD handle_tree_after_function.
  ENDMETHOD.


  METHOD handle_tree_before_function.
  ENDMETHOD.


  METHOD handle_tree_checkbox_change.
  ENDMETHOD.


  METHOD handle_tree_double_click.
  ENDMETHOD.


  METHOD handle_tree_end_of_page.
  ENDMETHOD.


  METHOD handle_tree_expand_empty_foldr.
  ENDMETHOD.


  METHOD handle_tree_keypress.
  ENDMETHOD.


  METHOD handle_tree_link_click.
  ENDMETHOD.


  METHOD handle_tree_top_of_page.
  ENDMETHOD.


  METHOD populate_setup_before_display.
  ENDMETHOD.


  METHOD process_any_model.
    DATA lv_method TYPE seoclsname.

    IF lmo_current_model IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Model was not created'.
    ENDIF.

    TRY.
        lv_method = |{ iv_method CASE = UPPER }|.

        IF it_param IS SUPPLIED AND it_param IS NOT INITIAL
       AND it_excpt IS SUPPLIED AND it_excpt IS NOT INITIAL.
          CALL METHOD lmo_current_model->(lv_method)
            PARAMETER-TABLE it_param
            EXCEPTION-TABLE it_excpt.
        ELSEIF it_param IS SUPPLIED AND it_param IS NOT INITIAL.
          CALL METHOD lmo_current_model->(lv_method)
            PARAMETER-TABLE it_param.
        ELSE.
          CALL METHOD lmo_current_model->(lv_method).
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

    lmv_current_stack = |{ iv_stack_name CASE = UPPER }|.
    ev_stack_name     = lmv_current_stack.

    IF io_model IS BOUND.
      io_model->set_stack_name( lmv_current_stack ).
    ENDIF.

    IF io_list_view IS BOUND.
      io_list_view->set_stack_name( lmv_current_stack ).
    ENDIF.

    IF io_tree_view IS BOUND.
      io_tree_view->set_stack_name( lmv_current_stack ).
    ENDIF.

    IF iv_not_checked IS INITIAL.
      _build_stack( iv_name      = lmv_current_stack   "'MAIN'
                    io_model     = io_model
                    io_list_view = io_list_view
                    io_tree_view = io_tree_view ).
    ELSE.
      LOOP AT lmt_stack ASSIGNING FIELD-SYMBOL(<lfs_stack>).
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( lmt_stack ) THEN abap_true ).
      ENDLOOP.
    ENDIF.

    eo_controller = get_controller_instance( ).
  ENDMETHOD.


  METHOD _auto_gen_stack_name.
    DATA: lc_stack_sub_init TYPE dfies-tabname VALUE 'SUB01',
          lc_stack_sub      TYPE dfies-tabname VALUE 'SUB'.
    DATA: lv_next_stack TYPE n LENGTH 2,
          lv_htype      TYPE dd01v-datatype.

    ro_controller = me.

    IF NOT line_exists( lmt_stack[ KEY k2 COMPONENTS name = mc_stack_main ] ).
      ev_stack_name = mc_stack_main.
    ELSE.
      LOOP AT lmt_stack INTO DATA(ls_stack) WHERE name CP |{ lc_stack_sub }*|.
        EXIT.
      ENDLOOP.
      IF sy-subrc EQ 0.
        DELETE lmt_stack WHERE NOT name CP |{ lc_stack_sub }*|.
        SORT lmt_stack BY name DESCENDING.

        TRY.
            lv_next_stack = substring_after( val = lmt_stack[ 1 ]-name  sub = lc_stack_sub ).

            CALL FUNCTION 'NUMERIC_CHECK'
              EXPORTING
                string_in = lv_next_stack
              IMPORTING
                htype     = lv_htype.

            lv_next_stack = COND #( WHEN lv_htype EQ 'NUMC' THEN lv_next_stack + 1 ELSE '01' ).
            ev_stack_name = |{ lc_stack_sub }{ lv_next_stack }|.
          CATCH cx_sy_itab_line_not_found.
            ev_stack_name = lc_stack_sub_init.
        ENDTRY.
      ELSE.
        ev_stack_name = lc_stack_sub_init.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _build_stack.
    DATA: lo_list_view  TYPE REF TO zcl_mvcfw_base_salv_list_view,
          lo_tree_view  TYPE REF TO zcl_mvcfw_base_salv_tree_view,
          lo_model      TYPE REF TO zcl_mvcfw_base_salv_model,
          lo_controller TYPE REF TO zcl_mvcfw_base_salv_controller.
    DATA: lv_line TYPE sy-index.
    FIELD-SYMBOLS: <lfs_stack> TYPE ty_stack.

    DATA(lv_name) = |{ iv_name CASE = UPPER }|.

    IF NOT line_exists( lmt_stack[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR: lo_list_view, lo_tree_view, lo_model, lo_controller, lv_line.

      lo_model      ?= io_model.
      lo_list_view  ?= io_list_view.
      lo_tree_view  ?= io_tree_view.
      lo_controller ?= COND #( WHEN io_controller IS BOUND THEN io_controller ELSE me ).
      lv_line        = lines( lmt_stack ) + 1.

      INSERT VALUE #( name       = COND #( WHEN lv_line EQ 1 THEN mc_stack_main ELSE lv_name )
                      list_view  = lo_list_view
                      list_param = ir_list_view_param
                      tree_view  = lo_tree_view
                      tree_param = ir_tree_view_param
                      model      = lo_model
                      controller = lo_controller
                      is_main    = COND #( WHEN lv_line EQ 1 THEN abap_true )
                      line       = lv_line
                    ) INTO TABLE lmt_stack.

      LOOP AT lmt_stack ASSIGNING <lfs_stack>.
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( lmt_stack ) THEN abap_true ).
      ENDLOOP.
    ELSE.
      IF ir_list_view_param IS SUPPLIED.
        READ TABLE lmt_stack ASSIGNING <lfs_stack> WITH TABLE KEY k2 COMPONENTS name = lv_name.
        IF sy-subrc EQ 0.
          <lfs_stack>-list_param = ir_list_view_param.
        ENDIF.
      ENDIF.
      IF ir_tree_view_param IS SUPPLIED.
        READ TABLE lmt_stack ASSIGNING <lfs_stack> WITH TABLE KEY k2 COMPONENTS name = lv_name.
        IF sy-subrc EQ 0.
          <lfs_stack>-tree_param = ir_tree_view_param.
        ENDIF.
      ENDIF.
    ENDIF.

    IF NOT line_exists( lmt_stack_called[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR lv_line.

      lv_line = lines( lmt_stack_called ) + 1.

      INSERT VALUE #( line = lv_line
                      name = COND #( WHEN lv_line EQ 1 THEN mc_stack_main ELSE lv_name )
                    ) INTO TABLE lmt_stack_called.
    ENDIF.
  ENDMETHOD.


  METHOD _check_setup_before_display.
    IF cr_list_param IS SUPPLIED.
      CHECK cr_list_param IS BOUND.

      IF cr_list_param->stack_name NE lmv_current_stack.
        cr_list_param->stack_name = lmv_current_stack.
      ENDIF.

      IF cr_list_param->container IS BOUND.
        CLEAR cr_list_param->list_display.
      ELSE.
        CLEAR cr_list_param->container.
        CLEAR cr_list_param->container_name.
      ENDIF.
    ELSEIF cr_tree_param IS SUPPLIED.
      CHECK cr_tree_param IS BOUND.

      IF cr_tree_param->stack_name NE lmv_current_stack.
        cr_tree_param->stack_name = lmv_current_stack.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _clear_direct_outtab.
    CLEAR: me->lmv_is_direct_outtab,
           me->lmt_direct_outtab.
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
            lv_object = COND #( WHEN ls_class_type-sscr       IS NOT INITIAL THEN lmc_base_sscr
                                WHEN ls_class_type-model      IS NOT INITIAL THEN lmc_base_model
                                WHEN ls_class_type-salv_view  IS NOT INITIAL THEN lmc_base_salv_view
                                WHEN ls_class_type-tree_view  IS NOT INITIAL THEN lmc_base_tree_view
                                WHEN ls_class_type-controller IS NOT INITIAL THEN lmc_base_cntl ).
            CHECK lv_object IS NOT INITIAL.

            CREATE OBJECT ro_class TYPE (lv_object).
            ev_class_name = lv_object.
          CATCH cx_sy_create_object_error.
        ENDTRY.
    ENDTRY.
  ENDMETHOD.


  METHOD _display_salv_grid.
    DATA: lo_out TYPE REF TO data.
    DATA: lo_exct_dyn TYPE REF TO cx_root.

    lmv_current_stack = COND #( WHEN lmr_list_param IS BOUND
                                 AND lmr_list_param->stack_name IS NOT INITIAL THEN lmr_list_param->stack_name
                                WHEN lmv_current_stack IS INITIAL THEN mc_stack_main
                                ELSE lmv_current_stack ).

    me->_build_stack( iv_name            = lmv_current_stack   "Default with 'MAIN'
                      io_model           = lmo_current_model
                      io_list_view       = lmo_current_list_view
                      ir_list_view_param = COND #( WHEN lmr_list_param IS BOUND THEN lmr_list_param ELSE NEW #( ) )
                      io_controller      = lmo_controller ).

    DATA(lo_stack) = me->_get_stack( lmv_current_stack ).

    IF lo_stack IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Stack name was not found'.
    ELSE.
      lmo_current_model      ?= lo_stack->model.
      lmo_current_list_view  ?= lo_stack->list_view.
      lmo_controller         ?= lo_stack->controller.
      lmr_list_param          = lo_stack->list_param.
      lmv_current_stack       = lo_stack->name.
    ENDIF.

    "Set Object name for Model
    me->_set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                        iv_object_name = lmc_obj_model
                                        iv_stack_name  = lmv_current_stack ).

    IF ct_data IS SUPPLIED
   AND ct_data IS NOT INITIAL.
      lo_out = REF #( ct_data ).

*      IF lo_stack->model IS BOUND.
*        TRY.
*            lo_stack->model->set_outtab( EXPORTING iv_stack_name = lmv_current_stack
*                                                   it_ref_data   = ct_data ).
*          CATCH cx_root INTO DATA(lo_exct_dyn).
*            RAISE EXCEPTION TYPE zbcx_exception
*              EXPORTING
*                msgv1 = CONV #( lo_exct_dyn->get_text( ) ).
*        ENDTRY.
*      ENDIF.
    ELSE.
      IF lo_stack->model IS NOT BOUND.
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'Model was not found'.
      ENDIF.

      TRY.
          lo_out = lo_stack->model->get_outtab( iv_stack_name = lmv_current_stack ).
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
                                          iv_object_name = lmc_obj_list_view
                                          iv_stack_name  = lmv_current_stack
                              )->_set_salv_list_events( EXPORTING io_view = lo_stack->list_view ).

      IF lo_stack->list_view IS BOUND.
        TRY.
            IF lmr_list_param IS NOT BOUND.
              lmr_list_param = NEW #( ).
            ENDIF.

            "Display ALV Grid
            lo_stack->list_view->set_controller_listener( me )->display( EXPORTING iv_list_display   = lmr_list_param->list_display
                                                                                   ir_container      = lmr_list_param->container
                                                                                   iv_container_name = lmr_list_param->container_name
                                                                                   iv_pfstatus       = lmr_list_param->pfstatus
                                                                                   iv_variant        = lmr_list_param->variant
                                                                                   iv_start_column   = lmr_list_param->start_column
                                                                                   iv_end_column     = lmr_list_param->end_column
                                                                                   iv_start_line     = lmr_list_param->start_line
                                                                                   iv_end_line       = lmr_list_param->end_line
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


  METHOD _display_salv_tree.
    DATA: lo_out TYPE REF TO data.
    DATA: lo_exct_dyn TYPE REF TO cx_root.

    lmv_current_stack = COND #( WHEN lmr_tree_param IS BOUND
                                 AND lmr_tree_param->stack_name IS NOT INITIAL THEN lmr_tree_param->stack_name
                                WHEN lmv_current_stack IS NOT INITIAL THEN lmv_current_stack
                                ELSE mc_stack_main ).

    me->_build_stack( iv_name            = lmv_current_stack   "Default with 'MAIN'
                      io_model           = lmo_current_model
                      io_tree_view       = lmo_current_tree_view
                      ir_tree_view_param = COND #( WHEN lmr_tree_param IS BOUND THEN lmr_tree_param ELSE NEW #( ) )
                      io_controller      = lmo_controller ).

    DATA(lo_stack) = me->_get_stack( lmv_current_stack ).

    IF lo_stack IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Stack name was not found'.
    ELSE.
      lmo_current_model      ?= lo_stack->model.
      lmo_current_tree_view  ?= lo_stack->tree_view.
      lmo_controller         ?= lo_stack->controller.
      lmr_tree_param          = lo_stack->tree_param.
      lmv_current_stack       = lo_stack->name.
    ENDIF.

    "Set Object name for Model
    _set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                    iv_object_name = lmc_obj_model
                                    iv_stack_name  = lmv_current_stack ).

    IF ct_data IS SUPPLIED
   AND ct_data IS NOT INITIAL.
      lo_out = REF #( ct_data ).

*      IF lo_stack->model IS BOUND.
*        TRY.
*            lo_stack->model->set_outtab( EXPORTING iv_stack_name = lmv_current_stack
*                                                   it_ref_data   = ct_data ).
*          CATCH cx_root INTO DATA(lo_exct_dyn).
*            RAISE EXCEPTION TYPE zbcx_exception
*              EXPORTING
*                msgv1 = CONV #( lo_exct_dyn->get_text( ) ).
*        ENDTRY.
*      ENDIF.
    ELSE.
      IF lo_stack->model IS NOT BOUND.
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'Model was not found'.
      ENDIF.

      TRY.
          lo_out = lo_stack->model->get_outtab( iv_stack_name = lmv_current_stack ).
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
                                          iv_object_name = lmc_obj_tree_view
                                          iv_stack_name  = lmv_current_stack
                               )->_set_salv_tree_events( EXPORTING io_view = lo_stack->tree_view ).

      IF lo_stack->tree_view IS BOUND.
        TRY.
            IF lmr_tree_param IS NOT BOUND.
              lmr_tree_param = NEW #( ).
            ENDIF.

            "Display ALV Tree
            lo_stack->tree_view->set_controller_listener( me )->display( EXPORTING iv_create_directly = iv_create_directly
                                                                                   ir_container       = lmr_tree_param->container
                                                                                   iv_hide_header     = lmr_tree_param->hide_header
                                                                                   iv_pfstatus        = lmr_tree_param->pfstatus
                                                                                   iv_variant         = lmr_tree_param->variant
                                                                                   iv_start_column    = lmr_tree_param->start_column
                                                                                   iv_end_column      = lmr_tree_param->end_column
                                                                                   iv_start_line      = lmr_tree_param->start_line
                                                                                   iv_end_line        = lmr_tree_param->end_line
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
    DATA: lt_abap_callstack TYPE abap_callstack,
          lt_sys_callst     TYPE sys_callst.

    ro_controller = me.

    CALL FUNCTION 'SYSTEM_CALLSTACK'
*     EXPORTING
*       MAX_LEVEL          = 0
      IMPORTING
        callstack    = lt_abap_callstack
        et_callstack = lt_sys_callst.

    CLEAR lmv_triggered_evt.

    DELETE lt_abap_callstack WHERE blocktype NE 'METHOD'.
    DELETE lt_abap_callstack WHERE blockname NP '*HANDLE*'.

    READ TABLE lt_abap_callstack INTO DATA(ls_abap_callstack) INDEX 1.
    IF sy-subrc EQ 0.
      lmv_triggered_evt = ls_abap_callstack-blockname.
    ENDIF.
  ENDMETHOD.


  METHOD _get_current_stack.
    re_current_stack = lmv_current_stack.
  ENDMETHOD.


  METHOD _get_outtab_model.
    CHECK lmo_current_model IS BOUND.

    DATA(lr_out) = lmo_current_model->get_outtab( ).
    IF lr_out IS BOUND.
      ro_outtab = lr_out.
    ENDIF.
  ENDMETHOD.


  METHOD _get_stack.
    TRY.
        rs_stack = REF #( lmt_stack[ KEY k2 COMPONENTS name = iv_name ] ).

        IF rs_stack IS BOUND.
          me->_set_model( io_model = rs_stack->model ).
          me->_set_view( io_list_view = rs_stack->list_view
                         io_tree_view = rs_stack->tree_view ).
        ENDIF.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.


  METHOD _setup_parameters_to_salv.
    ro_controller = me.

    lmr_list_param = NEW #( stack_name      = iv_stack_name
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

    populate_setup_before_display( EXPORTING iv_display_type = mc_display_salv_list
                                   CHANGING  cr_list_param   = lmr_list_param ).
    _check_setup_before_display( EXPORTING iv_display_type = mc_display_salv_list
                                 CHANGING  cr_list_param   = lmr_list_param ).

    er_view_param = lmr_list_param.
  ENDMETHOD.


  METHOD _setup_parameters_to_tree.
    ro_controller = me.

    lmr_tree_param = NEW #( stack_name   = iv_stack_name
                            container    = ir_container
                            hide_header  = iv_hide_header
                            pfstatus     = iv_pfstatus
                            variant      = iv_variant
                            start_column = iv_start_column
                            end_column   = iv_end_column
                            start_line   = iv_start_line
                            end_line     = iv_end_line ).

    populate_setup_before_display( EXPORTING iv_display_type = mc_display_salv_tree
                                   CHANGING  cr_tree_param   = lmr_tree_param ).
    _check_setup_before_display( EXPORTING iv_display_type = mc_display_salv_tree
                                 CHANGING  cr_tree_param   = lmr_tree_param ).
  ENDMETHOD.


  METHOD _set_direct_outtab.
    me->lmv_is_direct_outtab = abap_true.
    me->lmt_direct_outtab    = REF #( ct_data ).
  ENDMETHOD.


  METHOD _set_dynp_stack_name.
    ro_controller = me.

    CHECK io_stack IS BOUND.

    TRY.
        CASE iv_object_name.
          WHEN lmc_obj_model.
            IF io_stack->model IS BOUND.
              io_stack->model->set_stack_name( iv_stack_name ).
            ENDIF.
          WHEN lmc_obj_list_view.
            IF io_stack->list_view IS BOUND.
              io_stack->list_view->set_stack_name( iv_stack_name ).

              IF io_stack->model IS BOUND.
                io_stack->list_view->set_model( io_stack->model ).
              ENDIF.
            ENDIF.
          WHEN lmc_obj_tree_view.
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
        CASE lmv_triggered_evt.
          WHEN 'HANDLE_LIST_LINK_CLICK'.
            io_model->set_link_double_click_to_list( event_type = 'HANDLE_LIST_LINK_CLICK'
                                                     row        = ir_event_list->row_link_click
                                                     column     = ir_event_list->column_link_click ).
          WHEN 'HANDLE_LIST_DOUBLE_CLICK'.
            io_model->set_link_double_click_to_list( event_type = 'HANDLE_LIST_DOUBLE_CLICK'
                                                     row        = ir_event_list->row_double_click
                                                     column     = ir_event_list->column_double_click ).
          WHEN 'HANDLE_LIST_ADD_FUNCTION'
            OR 'HANDLE_LIST_AFTER_FUNCTION'
            OR 'HANDLE_LIST_BEFORE_FUNCTION'.
            io_model->set_function_paramter( display_type  = mc_display_salv_list
                                             salv_function = ir_event_list->salv_function ).
          WHEN 'HANDLE_LIST_END_OF_PAGE'.
            io_model->set_top_end_of_page_paramter( display_type  = mc_display_salv_list
                                                    r_end_of_page = ir_event_list->r_end_of_page
                                                    page          = ir_event_list->page ).
          WHEN 'HANDLE_LIST_TOP_OF_PAGE'.
            io_model->set_top_end_of_page_paramter( display_type  = mc_display_salv_list
                                                    r_top_of_page = ir_event_list->r_top_of_page
                                                    page          = ir_event_list->page
                                                    table_index   = ir_event_list->table_index ).
          WHEN 'HANDLE_LIST_CHECK_CHANGED_DATA'.
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
        CASE lmv_triggered_evt.
          WHEN 'HANDLE_TREE_LINK_CLICK'.
            io_model->set_link_double_key_check_expd( event_type = 'HANDLE_TREE_LINK_CLICK'
                                                      columnname = ir_event_tree->columnname_link_click
                                                      node_key   = ir_event_tree->node_key_link_click ).
          WHEN 'HANDLE_TREE_DOUBLE_CLICK'.
            io_model->set_link_double_key_check_expd( event_type = 'HANDLE_TREE_DOUBLE_CLICK'
                                                      columnname = ir_event_tree->columnname_double_click
                                                      node_key   = ir_event_tree->node_key_double_click ).
          WHEN 'HANDLE_TREE_KEYPRESS'.
            io_model->set_link_double_key_check_expd( event_type = 'HANDLE_TREE_KEYPRESS'
                                                      columnname = ir_event_tree->columnname_keypress
                                                      node_key   = ir_event_tree->node_key_keypress
                                                      key        = ir_event_tree->keypress ).
          WHEN 'HANDLE_TREE_CHECKBOX_CHANGE'.
            io_model->set_link_double_key_check_expd( event_type = 'HANDLE_TREE_CHECKBOX_CHANGE'
                                                      columnname = ir_event_tree->columnname_chkbox_change
                                                      node_key   = ir_event_tree->node_key_checkbox_change
                                                      checked    = ir_event_tree->checked ).
          WHEN 'HANDLE_TREE_EXPAND_EMPTY_FOLDR'.
            io_model->set_link_double_key_check_expd( event_type = 'HANDLE_TREE_CHECKBOX_CHANGE'
                                                      node_key   = ir_event_tree->node_key_exp_empty_foldr ).
          WHEN 'HANDLE_TREE_ADD_FUNCTION'
            OR 'HANDLE_TREE_AFTER_FUNCTION'
            OR 'HANDLE_TREE_BEFORE_FUNCTION'.
            io_model->set_function_paramter( display_type  = mc_display_salv_tree
                                             salv_function = ir_event_tree->salv_function ).
          WHEN 'HANDLE_TREE_END_OF_PAGE'.
            io_model->set_top_end_of_page_paramter( display_type  = mc_display_salv_tree
                                                    r_end_of_page = ir_event_tree->r_end_of_page
                                                    page          = ir_event_tree->page ).
          WHEN 'HANDLE_TREE_TOP_OF_PAGE'.
            io_model->set_top_end_of_page_paramter( display_type  = mc_display_salv_tree
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
          lo_model ?= io_model.
        ENDIF.

        IF lo_model IS BOUND.
          lmo_current_model ?= lo_model.
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
            lo_list_view ?= io_list_view.
          ENDIF.
          IF lo_list_view IS BOUND.
            lmo_current_list_view ?= lo_list_view.
          ENDIF.
        CATCH cx_sy_move_cast_error.
      ENDTRY.
    ENDIF.

    IF io_tree_view IS SUPPLIED.
      TRY.
          IF io_list_view IS BOUND.
            lo_tree_view ?= io_tree_view.
          ENDIF.
          IF lo_list_view IS BOUND.
            lmo_current_tree_view ?= lo_tree_view.
          ENDIF.
        CATCH cx_sy_move_cast_error.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD _validate_display_type.
    rv_display_type = COND #( WHEN iv_display_type IS NOT INITIAL THEN iv_display_type
                              ELSE mc_display_salv_list ).

    IF me->mo_list_view IS BOUND
   AND rv_display_type  EQ mc_display_salv_list.
      rv_display_type = mc_display_salv_list.
    ELSEIF me->mo_tree_view IS BOUND
       AND rv_display_type  EQ mc_display_salv_tree.
      rv_display_type = mc_display_salv_tree.
    ELSEIF me->mo_list_view IS BOUND
       AND me->mo_tree_view IS NOT BOUND.
      rv_display_type = mc_display_salv_list.
    ELSEIF me->mo_list_view IS NOT BOUND
       AND me->mo_tree_view IS BOUND.
      rv_display_type = mc_display_salv_tree.
    ELSE.
      rv_display_type = iv_display_type.
    ENDIF.
  ENDMETHOD.


  METHOD auto_generate_stack_name.
    DATA: lc_stack_sub_init TYPE dfies-tabname VALUE 'SUB01',
          lc_stack_sub      TYPE dfies-tabname VALUE 'SUB'.
    DATA: lv_next_stack TYPE n LENGTH 2,
          lv_htype      TYPE dd01v-datatype.

    DATA(lt_stack) = me->get_all_stack( ).

    IF NOT line_exists( lt_stack[ KEY k2 COMPONENTS name = mc_stack_main ] ).
      rv_stack_name = mc_stack_main.
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


  METHOD clone.
    SYSTEM-CALL OBJMGR CLONE me TO result.
  ENDMETHOD.
ENDCLASS.
