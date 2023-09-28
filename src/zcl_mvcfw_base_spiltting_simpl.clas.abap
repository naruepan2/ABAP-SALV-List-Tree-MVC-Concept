class ZCL_MVCFW_BASE_SPILTTING_SIMPL definition
  public
  inheriting from ZCL_MVCFW_BASE_SALV_LIST_VIEW
  create public .

public section.

  types:
    BEGIN OF ty_container,
        splitter    TYPE REF TO cl_gui_splitter_container,
        container_1 TYPE REF TO cl_gui_container,
        container_2 TYPE REF TO cl_gui_container,
        o_model_1   TYPE REF TO zcl_mvcfw_base_salv_model,
        o_model_2   TYPE REF TO zcl_mvcfw_base_salv_model,
        o_view_1    TYPE REF TO zcl_mvcfw_base_salv_list_view,
        o_view_2    TYPE REF TO zcl_mvcfw_base_salv_list_view,
        salv_1      TYPE REF TO cl_salv_table,
        salv_2      TYPE REF TO cl_salv_table,
        outtab_1    TYPE REF TO data,
        outtab_2    TYPE REF TO data,
      END OF ty_container .

  data O_SSCR type ref to ZCL_MVCFW_BASE_SSCR .
  data O_CONTAINER type ref to TY_CONTAINER .
  constants C_SALV_1 type STRING value 'SALV_1' ##NO_TEXT.
  constants C_SALV_2 type STRING value 'SALV_2' ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !IR_SSCR type ref to ZCL_MVCFW_BASE_SSCR optional
      !IR_MODEL_1 type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      !IR_MODEL_2 type ref to ZCL_MVCFW_BASE_SALV_MODEL optional .
  methods DISPLAY_AS_SPLIT
    importing
      !IR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER optional
      !IR_CUSTOM_CONTAINER type ref to CL_GUI_CUSTOM_CONTAINER optional
      !IR_CONTAINER_1 type ref to CL_GUI_CONTAINER optional
      !IR_CONTAINER_2 type ref to CL_GUI_CONTAINER optional
      !IT_TABLE_1 type ref to DATA optional
      !IT_TABLE_2 type ref to DATA optional
    raising
      ZBCX_EXCEPTION .
  methods POPULATE_GUI_SPLITTER
    importing
      !IR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER .
  methods POPULATE_GUI_CONTAINER
    importing
      !IR_CONTAINER_1 type ref to CL_GUI_CONTAINER optional
      !IR_CONTAINER_2 type ref to CL_GUI_CONTAINER optional .
  methods GET_DISPLAY_CONTAINER
    returning
      value(RO_VALUE) type ref to TY_CONTAINER .
  methods SHOW_FULLSCREEN
    importing
      !IV_ID type I default 1
    raising
      ZBCX_EXCEPTION .
  methods SET_MODEL_TO_INSTANCE
    importing
      !IO_MODEL_1 type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
      !IO_MODEL_2 type ref to ZCL_MVCFW_BASE_SALV_MODEL optional
    returning
      value(RO_INSTANCE) type ref to ZCL_MVCFW_BASE_SPILTTING_SIMPL .
  methods SET_REF_TABLE_TO_INSTANCE
    importing
      !IV_ADAPTER_NAME type STRING optional
    changing
      !CV_RTNAME type LVC_RTNAME .
  methods REFRESH_SALV_SPLIT
    importing
      !IV_VIEW_1 type FLAG optional
      !IV_VIEW_2 type FLAG optional
      !IV_ALL type FLAG optional
      !IV_REFRESH_MODE type SALV_DE_CONSTANT default IF_SALV_C_REFRESH=>SOFT .

  methods SET_REF_TABLE_NAME
    redefinition .
protected section.

  methods _PREPARE_DISPLAY_AS_SPLIT
    importing
      !IR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER optional
      !IR_CUSTOM_CONTAINER type ref to CL_GUI_CUSTOM_CONTAINER optional
      !IR_CONTAINER_1 type ref to CL_GUI_CONTAINER optional
      !IR_CONTAINER_2 type ref to CL_GUI_CONTAINER optional
    changing
      !CT_TABLE_1 type TABLE optional
      !CT_TABLE_2 type TABLE optional .
  methods _DISPLAY
    raising
      ZBCX_EXCEPTION .
private section.

  data MV_HEIGHT1_OLD type I .
  data MV_HEIGHT2_OLD type I .
  data MV_HEIGHT1 type I .
  data MV_HEIGHT2 type I .
  data MV_SLIDER type FLAG .
  data MV_FIRST_SET type FLAG .
  data MV_CUST_SET type FLAG .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_SPILTTING_SIMPL IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).

*--------------------------------------------------------------------*
*
*   Parent_Class =  Child_Class   (Narrow/Up Casting)
*   Child_Class  ?= Parent_Class  (Widening/Down Casting)
*
*--------------------------------------------------------------------*
    o_container = NEW #( ).


    TRY.
        o_sscr  = COND #( WHEN ir_sscr IS BOUND THEN CAST #( ir_sscr ) ELSE NEW #( ) ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.

    TRY.
        o_container->o_model_1  = COND #( WHEN ir_model_1 IS BOUND THEN CAST #( ir_model_1 ) ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.

    TRY.
        o_container->o_model_2  = COND #( WHEN ir_model_2 IS BOUND THEN CAST #( ir_model_2 )
                                          WHEN o_container->o_model_1 IS BOUND THEN CAST #( o_container->o_model_1 ) ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.

  ENDMETHOD.


  METHOD display_as_split.
    DATA ptab TYPE abap_parmbind_tab.
    FIELD-SYMBOLS: <lft_table_1> TYPE table,
                   <lft_table_2> TYPE table.

    IF mv_first_set IS INITIAL.
      IF it_table_1 IS BOUND.
        ASSIGN it_table_1->* TO <lft_table_1>.
      ENDIF.

      IF it_table_2 IS BOUND.
        ASSIGN it_table_2->* TO <lft_table_2>.
      ENDIF.

      mv_cust_set = COND #( WHEN ir_custom_container IS BOUND THEN abap_true ).

      ptab = VALUE abap_parmbind_tab( ( name  = 'IR_SPLITTER'
                                        kind  = cl_abap_objectdescr=>exporting
                                        value = REF #( ir_splitter ) )
                                      ( name  = 'IR_CUSTOM_CONTAINER'
                                        kind  = cl_abap_objectdescr=>exporting
                                        value = REF #( ir_custom_container ) )
                                      ( name  = 'IR_CONTAINER_1'
                                        kind  = cl_abap_objectdescr=>exporting
                                        value = REF #( ir_container_1 ) )
                                      ( name  = 'IR_CONTAINER_2'
                                        kind  = cl_abap_objectdescr=>exporting
                                        value = REF #( ir_container_2 ) ) ).
      IF <lft_table_1> IS ASSIGNED.
        ptab = VALUE #( BASE ptab ( name  = 'CT_TABLE_1'
                                    kind  = cl_abap_objectdescr=>changing
                                    value = REF #( <lft_table_1> ) ) ).
      ENDIF.
      IF <lft_table_2> IS ASSIGNED.
        ptab = VALUE #( BASE ptab ( name  = 'CT_TABLE_2'
                                    kind  = cl_abap_objectdescr=>changing
                                    value = REF #( <lft_table_2> ) ) ).
      ENDIF.

      CALL METHOD me->('_PREPARE_DISPLAY_AS_SPLIT')
        PARAMETER-TABLE ptab.

      IF o_container->splitter IS NOT BOUND.
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'Splitter container is not created'.
      ENDIF.

      IF o_container IS BOUND.
        TRY.
            _display( ).
          CATCH zbcx_exception INTO DATA(lo_excpt).
            RAISE EXCEPTION TYPE zbcx_exception
              EXPORTING
                msgv1 = CONV #( lo_excpt->get_text( ) ).
        ENDTRY.
      ENDIF.
    ELSE.
      refresh_salv_split( EXPORTING iv_all = abap_true ).
    ENDIF.
  ENDMETHOD.


  METHOD get_display_container.
    ro_value = o_container.
  ENDMETHOD.


  METHOD populate_gui_container.
  ENDMETHOD.


  METHOD populate_gui_splitter.
    ir_splitter->set_border( EXPORTING border  = cl_gui_cfw=>false
                             EXCEPTIONS OTHERS = 99 ).
    ir_splitter->set_row_mode( EXPORTING mode    = ir_splitter->mode_relative
                               EXCEPTIONS OTHERS = 99 ).
  ENDMETHOD.


  METHOD refresh_salv_split.
    DATA(stable) = VALUE lvc_s_stbl( row = abap_true
                                     col = abap_true ).

    CASE abap_true.
      WHEN iv_all.
        IF o_container->salv_1 IS BOUND.
          o_container->salv_1->refresh( s_stable     = stable
                                        refresh_mode = iv_refresh_mode ).
        ENDIF.

        IF o_container->salv_2 IS BOUND.
          o_container->salv_2->refresh( s_stable     = stable
                                        refresh_mode = iv_refresh_mode ).
        ENDIF.
      WHEN OTHERS.
        IF iv_view_1 IS NOT INITIAL AND o_container->salv_1 IS BOUND.
          o_container->salv_1->refresh( s_stable     = stable
                                        refresh_mode = iv_refresh_mode ).
        ENDIF.

        IF iv_view_2 IS NOT INITIAL AND o_container->salv_2 IS BOUND.
          o_container->salv_2->refresh( s_stable     = stable
                                        refresh_mode = iv_refresh_mode ).
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD set_model_to_instance.
    ro_instance = me.

    IF o_container IS BOUND.
      IF io_model_1 IS BOUND.
        o_container->o_model_1 = CAST #( io_model_1 ).
      ENDIF.
      IF io_model_2 IS BOUND.
        o_container->o_model_2 = CAST #( io_model_2 ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_ref_table_name.
    DATA lv_rtname  TYPE lvc_rtname.

    set_ref_table_to_instance( EXPORTING iv_adapter_name = iv_adapter_name
                               CHANGING  cv_rtname       = lv_rtname ).

    CALL METHOD super->set_ref_table_name
      EXPORTING
        iv_rtname       = lv_rtname
        iv_adapter_name = iv_adapter_name.
  ENDMETHOD.


  METHOD set_ref_table_to_instance.
  ENDMETHOD.


  METHOD show_fullscreen.
    IF iv_id > 2.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Enter wrong ID'.
    ENDIF.

    IF o_container->splitter IS BOUND
   AND sy-batch              IS INITIAL.
      o_container->splitter->get_row_height( EXPORTING id      = 1
                                             IMPORTING result  = mv_height1
                                             EXCEPTIONS OTHERS = 99 ).

      o_container->splitter->get_row_height( EXPORTING id      = 2
                                             IMPORTING result  = mv_height2
                                             EXCEPTIONS OTHERS = 99 ).

      cl_gui_cfw=>flush( EXCEPTIONS OTHERS = 99 ).

      "--------------------------------------------------------------------"
      mv_slider = COND #( WHEN mv_slider IS INITIAL THEN abap_true ELSE abap_false ).

      IF mv_slider IS INITIAL.
        mv_height1 = mv_height1_old.
        mv_height2 = mv_height2_old.
      ELSE.
        mv_height1_old = mv_height1.  "60 --> 100
        mv_height2_old = mv_height2.  "40 --> 0

        IF mv_height1 = 0 OR mv_height2 = 0.
          mv_height1 = 50.
          mv_height2 = 50.
        ELSE.
          IF iv_id = 1.
            mv_height1 = 100.
            mv_height2 = 0.
          ELSEIF iv_id = 2.
            mv_height1 = 0.
            mv_height2 = 100.
          ENDIF.
        ENDIF.
      ENDIF.
      "--------------------------------------------------------------------"

      o_container->splitter->set_row_height( EXPORTING id      = 1
                                                       height  = mv_height1
                                              EXCEPTIONS OTHERS = 99 ).

      o_container->splitter->set_row_height( EXPORTING id      = 2
                                                       height  = mv_height2
                                              EXCEPTIONS OTHERS = 99 ).

      cl_gui_cfw=>flush( EXCEPTIONS OTHERS = 99 ).
    ENDIF.
  ENDMETHOD.


  METHOD _display.
    IF o_container->salv_1 IS NOT BOUND
   AND o_container->salv_2 IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'There are any SALV to display'.
    ENDIF.

* Display ALV_1
    IF o_container->salv_1 IS BOUND.
      o_container->salv_1->display( ).
    ENDIF.

* Display ALV_2
    IF o_container->salv_2 IS BOUND.
      o_container->salv_2->display( ).
    ENDIF.

    mv_first_set = abap_true.

    IF mv_cust_set IS INITIAL.
      WRITE space.
    ENDIF.
  ENDMETHOD.


  METHOD _prepare_display_as_split.
    DATA: lv_rows    TYPE i,
          lv_columns TYPE i VALUE 1,
          lv_top     TYPE i VALUE 1,
          lv_bottom  TYPE i VALUE 2.

    IF ir_splitter IS BOUND.
* Splitter - no_autodef_progid_dynnr paramter must be flag 'X'
      o_container->splitter = ir_splitter.
    ELSE.
      lv_rows = COND #( WHEN ct_table_1 IS SUPPLIED AND ct_table_2 IS SUPPLIED THEN 2 ELSE 1 ).

* Splitter - it is neccessary to specify the default_screen as parent
      o_container->splitter = NEW #( parent                  = COND #( WHEN ir_custom_container IS BOUND THEN ir_custom_container
                                                                       ELSE cl_gui_container=>screen0 )
                                     no_autodef_progid_dynnr = abap_true
                                     rows                    = lv_rows
                                     columns                 = lv_columns ).
    ENDIF.

    IF o_container->splitter IS NOT BOUND.
      RETURN.
    ENDIF.

    IF o_container->splitter IS BOUND.
      populate_gui_splitter( o_container->splitter ).
    ENDIF.

* Container 1 for top
    IF ir_container_1 IS BOUND.
      o_container->container_1 = ir_container_1.
    ELSE.
      o_container->container_1 = o_container->splitter->get_container( row    = lv_top
                                                                       column = lv_columns ).
    ENDIF.

* Container 2 for bottom
    IF ir_container_2 IS BOUND.
      o_container->container_2 = ir_container_2.
    ELSE.
      o_container->container_2 = o_container->splitter->get_container( row    = lv_bottom
                                                                       column = lv_columns ).
    ENDIF.

    IF o_container->container_1 IS BOUND
    OR o_container->container_2 IS BOUND.
      populate_gui_container( ir_container_1 = o_container->container_1
                              ir_container_2 = o_container->container_2 ).
    ENDIF.

* ALV1
    IF o_container->container_1 IS BOUND.
      TRY.
          o_container->o_view_1 = NEW #( ).

          o_container->o_view_1->set_model( o_container->o_model_1 ).

          o_container->o_view_1->set_adapter_name( iv_adapter_name = c_salv_1 ).

          me->set_ref_table_name( iv_adapter_name = o_container->o_view_1->get_adapter_name( ) ).

          o_container->o_view_1->set_ref_table_name( iv_rtname = ref_table_name ).

          o_container->o_view_1->display( EXPORTING ir_container    = o_container->container_1
                                                    iv_adapter_name = c_salv_1    "'SALV_1'
                                                    iv_no_display   = abap_true
                                          CHANGING  ct_data         = ct_table_1 ).

          o_container->salv_1   = o_container->o_view_1->mo_salv.
          o_container->outtab_1 = REF #( ct_table_1 ).
        CATCH zbcx_exception.
      ENDTRY.
    ENDIF.

* ALV2
    IF o_container->container_2 IS BOUND.
      TRY.
          o_container->o_view_2 = NEW #( ).

          o_container->o_view_2->set_model( o_container->o_model_2 ).

          o_container->o_view_2->set_adapter_name( iv_adapter_name = c_salv_2 ).

          me->set_ref_table_name( iv_adapter_name = o_container->o_view_2->get_adapter_name( ) ).

          o_container->o_view_2->set_ref_table_name( iv_rtname = ref_table_name ).

          o_container->o_view_2->display( EXPORTING ir_container    = o_container->container_2
                                                    iv_adapter_name = c_salv_2    "'SALV_2'
                                                    iv_no_display   = abap_true
                                          CHANGING  ct_data         = ct_table_2 ).

          o_container->salv_2   = o_container->o_view_2->mo_salv.
          o_container->outtab_2 = REF #( ct_table_2 ).
        CATCH zbcx_exception.
      ENDTRY.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
