class ZCL_MVCFW_BASE_LIST_SPLIT_VIEW definition
  public
  inheriting from ZCL_MVCFW_BASE_SALV_LIST_VIEW
  create public .

public section.

  aliases GET_MODEL
    for ZIF_MVCFW_BASE_SALV_VIEW~GET_MODEL .

  types:
    BEGIN OF ty_container,
        splitter    TYPE REF TO cl_gui_splitter_container,
        container_1 TYPE REF TO cl_gui_container,
        container_2 TYPE REF TO cl_gui_container,
        salv_1      TYPE REF TO cl_salv_table,
        salv_2      TYPE REF TO cl_salv_table,
        outtab_1    TYPE REF TO data,
        outtab_2    TYPE REF TO data,
      END OF ty_container .

  methods DISPLAY_AS_SPLIT
    importing
      !IR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER optional
      !IR_CONTAINER_1 type ref to CL_GUI_CONTAINER optional
      !IR_CONTAINER_2 type ref to CL_GUI_CONTAINER optional
    changing
      !CT_TABLE_1 type TABLE
      !CT_TABLE_2 type TABLE
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
protected section.

  methods _PREPARE_DISPLAY_AS_SPLIT
    importing
      !IR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER optional
      !IR_CONTAINER_1 type ref to CL_GUI_CONTAINER optional
      !IR_CONTAINER_2 type ref to CL_GUI_CONTAINER optional
    changing
      !CT_TABLE_1 type TABLE
      !CT_TABLE_2 type TABLE
    returning
      value(RO_VALUE) type ref to TY_CONTAINER .
private section.

  data LMR_CONTAINER type ref to TY_CONTAINER .

  methods _DISPLAY
    raising
      ZBCX_EXCEPTION .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_LIST_SPLIT_VIEW IMPLEMENTATION.


  METHOD display_as_split.
    _prepare_display_as_split( EXPORTING ir_splitter    = ir_splitter
                                         ir_container_1 = ir_container_1
                                         ir_container_2 = ir_container_2
                               CHANGING  ct_table_1     = ct_table_1
                                         ct_table_2     = ct_table_2 ).

    CHECK me->lmr_container IS BOUND.

    TRY.
        _display( ).
      CATCH zbcx_exception INTO DATA(lo_excpt).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = CONV #( lo_excpt->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD get_display_container.
    ro_value = me->lmr_container.
  ENDMETHOD.


  METHOD populate_gui_container.
  ENDMETHOD.


  METHOD populate_gui_splitter.
    ir_splitter->set_border( EXPORTING border  = cl_gui_cfw=>false
                             EXCEPTIONS OTHERS = 99 ).
    ir_splitter->set_row_mode( EXPORTING mode    = ir_splitter->mode_relative
                               EXCEPTIONS OTHERS = 99 ).
  ENDMETHOD.


  METHOD _display.
    IF me->lmr_container->salv_1 IS NOT BOUND
   AND me->lmr_container->salv_2 IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'There are any SALV to display'.
    ENDIF.

* Display ALV_1
    IF me->lmr_container->salv_1 IS BOUND.
      me->lmr_container->salv_1->display( ).
    ENDIF.

* Display ALV_2
    IF me->lmr_container->salv_2 IS BOUND.
      me->lmr_container->salv_2->display( ).
    ENDIF.

    WRITE space.
  ENDMETHOD.


  METHOD _prepare_display_as_split.
    DATA: lr_salv TYPE REF TO zcl_mvcfw_base_list_split_view.

    IF me->lmr_container IS NOT BOUND.
      me->lmr_container = NEW #( ).
    ENDIF.

    IF ir_splitter IS BOUND.
* Splitter - no_autodef_progid_dynnr paramter must be flag 'X'
      me->lmr_container->splitter = ir_splitter.
    ELSE.
* Splitter - it is neccessary to specify the default_screen as parent
      me->lmr_container->splitter = NEW #( parent                  = cl_gui_container=>screen0
                                           no_autodef_progid_dynnr = abap_true
                                           rows                    = 2
                                           columns                 = 1 ).
    ENDIF.

    IF me->lmr_container->splitter IS BOUND.
      populate_gui_splitter( me->lmr_container->splitter ).
    ENDIF.

* Container 1 for top
    IF ir_container_1 IS BOUND.
      me->lmr_container->container_1 = ir_container_1.
    ELSE.
      me->lmr_container->container_1 = me->lmr_container->splitter->get_container( row    = 1
                                                                                   column = 1 ).
    ENDIF.

* Container 2 for bottom
    IF ir_container_2 IS BOUND.
      me->lmr_container->container_2 = ir_container_2.
    ELSE.
      me->lmr_container->container_2 = me->lmr_container->splitter->get_container( row    = 2
                                                                                   column = 1 ).
    ENDIF.

    IF me->lmr_container->container_1 IS BOUND
    OR me->lmr_container->container_2 IS BOUND.
      populate_gui_container( ir_container_1 = me->lmr_container->container_1
                              ir_container_2 = me->lmr_container->container_2 ).
    ENDIF.

* ALV1
    TRY.
        lr_salv = NEW #( ).

        lr_salv->display( EXPORTING ir_container    = me->lmr_container->container_1
                                    iv_adapter_name = 'SALV_1'
                                    iv_no_display   = abap_true
                          CHANGING  ct_data         = ct_table_1 ).

        me->lmr_container->salv_1 = lr_salv->lmo_salv.
      CATCH zbcx_exception.
    ENDTRY.

* ALV2
    TRY.
        lr_salv = NEW #( ).

        lr_salv->display( EXPORTING ir_container    = me->lmr_container->container_2
                                    iv_adapter_name = 'SALV_2'
                                    iv_no_display   = abap_true
                          CHANGING  ct_data         = ct_table_2 ).

        me->lmr_container->salv_2 = lr_salv->lmo_salv.
      CATCH zbcx_exception.
    ENDTRY.

* Store Table 1 and Table 2
    me->lmr_container->outtab_1 = REF #( ct_table_1 ).
    me->lmr_container->outtab_2 = REF #( ct_table_2 ).
  ENDMETHOD.
ENDCLASS.
