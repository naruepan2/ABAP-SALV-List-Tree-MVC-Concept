interface ZIF_MVCFW_BASE_SALV_VIEW
  public .


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
      !IT_COLUMNS type SALV_T_COLUMN_REF optional .
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
  methods SET_MODEL
    importing
      !IO_MODEL type ref to ZCL_MVCFW_BASE_SALV_MODEL .
  methods SET_PF_STATUS_NAME
    importing
      !IV_PFSTATUS type SYPFKEY optional .
  methods SET_VARIANT_NAME
    importing
      !IV_VARIANT type SLIS_VARI optional .
endinterface.
