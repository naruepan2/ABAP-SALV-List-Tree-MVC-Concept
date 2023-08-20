interface ZIF_MVCFW_BASE_SALV_VIEW
  public .


  data MR_PARENT_GRID type ref to CL_GUI_CONTAINER .
  data MR_HTML_TOP_CNTRL type ref to CL_GUI_HTML_VIEWER .
  data MR_HTML_END_CNTRL type ref to CL_GUI_HTML_VIEWER .
  data MR_HTML_TOP_OF_PAGE type ref to CL_GUI_CONTAINER .
  data MR_HTML_END_OF_PAGE type ref to CL_GUI_CONTAINER .
  data MR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER .
  data MR_TOP_DYNDOC_ID type ref to CL_DD_DOCUMENT .
  data MR_END_DYNDOC_ID type ref to CL_DD_DOCUMENT .
  data MV_TOP_HEIGHT type I .
  data MV_END_HEIGHT type I .

  methods SET_PF_STATUS
    importing
      !IV_PFSTATUS type SYPFKEY optional .
  methods SET_LAYOUT .
  methods SET_VARIANT
    importing
      !IV_VARIANT type SLIS_VARI optional .
  methods SET_DISPLAY_SETTINGS .
  methods SET_FUNCTIONS .
  methods SET_TOP_OF_PAGE .
  methods SET_END_OF_PAGE .
  methods SET_AGGREGATIONS .
  methods SET_SCREEN_POPUP
    importing
      !IV_START_COLUMN type I
      !IV_END_COLUMN type I optional
      !IV_START_LINE type I
      !IV_END_LINE type I optional .
  methods SET_NEW_FUNCTIONS .
  methods SET_EVENTS .
  methods CLOSE_SCREEN .
  methods MODIFY_COLUMNS
    importing
      !IT_COLUMNS type SALV_T_COLUMN_REF optional
      !IT_REF_COLS_TABLE type ref to OBJECT optional .
  methods SET_COLUMN_TEXT
    importing
      !IV_ALL_TEXT type ANY optional
      !IV_SCRTEXT_S type SCRTEXT_S optional
      !IV_SCRTEXT_M type SCRTEXT_M optional
      !IV_SCRTEXT_L type SCRTEXT_L optional
      !IR_COLUMN type ref to CL_SALV_COLUMN .
  methods SET_STACK_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional .
  methods GET_STACK_NAME
    returning
      value(RV_STACK_NAME) type DFIES-TABNAME .
  methods SET_MODEL
    importing
      !IO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods SET_PF_STATUS_NAME
    importing
      !IV_PFSTATUS type SYPFKEY optional .
  methods SET_VARIANT_NAME
    importing
      !IV_VARIANT type SLIS_VARI optional .
  methods SET_CONTAINER_TOP_OF_PAGE
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional .
  methods SET_CONTAINER_END_OF_PAGE
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional .
  methods SET_CONTAINER_ROW_HEIGHT
    importing
      !IV_TOP_HEIGHT type I optional
      !IV_END_HEIGHT type I optional .
  methods CREATE_CONTAINER
    importing
      !IR_CONTAINER type ref to CL_GUI_CONTAINER
    exporting
      !ER_PARENT_GRID type ref to CL_GUI_CONTAINER
      !EV_IS_CONTAINER type FLAG
    exceptions
      CNTL_ERROR
      CNTL_SYSTEM_ERROR .
  methods CREATE_CONTAINER_TOP_OF_PAGE
    importing
      !IR_DYNDOC_ID type ref to CL_DD_DOCUMENT .
  methods CREATE_CONTAINER_END_OF_PAGE
    importing
      !IR_DYNDOC_ID type ref to CL_DD_DOCUMENT .
  methods SETUP_CONTAINER
    changing
      !CR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER .
  methods CLONE
    returning
      value(RESULT) type ref to OBJECT .
endinterface.
