*&---------------------------------------------------------------------*
*& Include          YDEMO_APP_MODL
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_model DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_model DEFINITION INHERITING FROM zcl_mvcfw_base_model.

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_outtab,
             chkbox TYPE flag.
             INCLUDE TYPE spfli.
             INCLUDE TYPE zcl_mvcfw_base_model=>ty_incl_outtab_ext.
    TYPES:   END OF ty_outtab.
    TYPES: tty_outtab TYPE TABLE OF ty_outtab WITH EMPTY KEY.

    METHODS select_data REDEFINITION.
    METHODS process_data REDEFINITION.
    METHODS get_outtab REDEFINITION.
    METHODS set_outtab REDEFINITION.
    METHODS build_salv_tree_node REDEFINITION.

  PROTECTED SECTION.


  PRIVATE SECTION.

    DATA mt_outtab TYPE tty_outtab.

    METHODS _get_main_outtab
      RETURNING VALUE(ro_data) TYPE REF TO data.
    METHODS _build_salv_main_tree_node
      IMPORTING io_view TYPE REF TO	zcl_mvcfw_base_salv_tree_view
      CHANGING  ct_data TYPE table.

ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_model IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_model IMPLEMENTATION.
  METHOD select_data.
    DATA: ls_cell TYPE lvc_s_styl.

*      me->get_xxx( ).

    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE @mt_outtab
      FROM spfli
     WHERE carrid IN @so_airid.

    LOOP AT mt_outtab ASSIGNING FIELD-SYMBOL(<lfs_out>).
      IF sy-tabix BETWEEN 1 AND 5.
        <lfs_out>-alv_traff = 1. "Red
        me->set_editable_cell(
             EXPORTING iv_fname = 'CARRID'
             CHANGING  ct_style = <lfs_out>-alv_cellstyl ).
      ELSEIF sy-tabix BETWEEN 6 AND 8.
        <lfs_out>-alv_traff = 2. "Yellow
      ELSE.
        <lfs_out>-alv_traff = 3. "Green
      ENDIF.

      me->set_salv_checkbox(
           EXPORTING iv_fname    = 'CHKBOX'
                     iv_disabled = COND #( WHEN sy-tabix BETWEEN 1 AND 5 THEN abap_true )
           CHANGING  ct_celltype = <lfs_out>-alv_celltype ).
    ENDLOOP.

    IF mt_outtab IS INITIAL.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'No data found'.
    ENDIF.
  ENDMETHOD.

  METHOD process_data.
    TRY .
*      me->xxx( ).
      CATCH zbcx_exception INTO DATA(lo_except).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'Error processing data'.
    ENDTRY.
  ENDMETHOD.

  METHOD get_outtab.
    CASE lmv_current_stack.
      WHEN mc_stack_main.
        ro_data = _get_main_outtab( ).
      WHEN 'SUB01'.

      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD set_outtab.
    mt_outtab = it_data.
  ENDMETHOD.

  METHOD build_salv_tree_node.
    CASE lmv_current_stack.
      WHEN mc_stack_main.
        _build_salv_main_tree_node( EXPORTING io_view = io_view
                                    CHANGING  ct_data = ct_data ).
    ENDCASE.
  ENDMETHOD.

  METHOD _build_salv_main_tree_node.
    DATA: lo_out   TYPE REF TO tty_outtab,
          lo_nodes TYPE REF TO cl_salv_nodes,
          lo_node  TYPE REF TO cl_salv_node,
          lo_item  TYPE REF TO cl_salv_item.
    FIELD-SYMBOLS: <lft_out> TYPE STANDARD TABLE,
                   <lfs_out> TYPE any,
                   <lf_val>  TYPE any.

    lo_out = REF #( ct_data ).

    TRY.
        "Build Parent --> Carrid
        CALL METHOD io_view->add_salv_tree_node
          EXPORTING
            iv_related_node = space
*           iv_relationship = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
*           is_data_row     = lrs_carrid->*
*           iv_collapsed_icon = MC_COLLAPSE_ICON
*           iv_expanded_icon  = MC_EXPAND_ICON
*           iv_row_style    = IF_SALV_C_TREE_STYLE=>DEFAULT
            iv_text         = 'Flight'
            iv_visible      = abap_true
            iv_expander     = abap_true
            iv_enabled      = abap_true
            iv_folder       = abap_true
            io_tree         = io_view->get_salv_tree_instance( )
          IMPORTING
            ev_last_key     = DATA(lv_parent_key)
            er_nodes        = lo_nodes
            er_node         = lo_node.

        lo_node->expand( level = 1 ).
      CATCH zbcx_exception
            cx_salv_msg.
    ENDTRY.

    LOOP AT lo_out->* REFERENCE INTO DATA(lr_out) GROUP BY ( carrid = lr_out->carrid )
                                                  ASCENDING REFERENCE INTO DATA(lrg_carrid).
      LOOP AT GROUP lrg_carrid REFERENCE INTO DATA(lrs_carrid). EXIT. ENDLOOP.

      TRY.
          "Build Parent --> Carrid
          CALL METHOD io_view->add_salv_tree_node
            EXPORTING
              iv_related_node = lv_parent_key "space
*             iv_relationship = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
              is_data_row     = lrs_carrid->*
*             iv_collapsed_icon = MC_COLLAPSE_ICON
*             iv_expanded_icon  = MC_EXPAND_ICON
*             iv_row_style    = IF_SALV_C_TREE_STYLE=>DEFAULT
              iv_text         = lrs_carrid->carrid
*             iv_visible      = ABAP_TRUE
              iv_expander     = abap_true
*             iv_enabled      = ABAP_TRUE
*             iv_folder       =
              io_tree         = io_view->get_salv_tree_instance( )
            IMPORTING
              ev_last_key     = DATA(lv_carrid_key)
              er_nodes        = lo_nodes
              er_node         = lo_node.

*          lo_node->expand( complete_subtree = abap_true ).
        CATCH zbcx_exception.
      ENDTRY.

*  ... §0.2 if information should be displayed at
*    the hierarchy column set the carrid as text for this nod
*      lo_node->set_text( CONV #( lrs_carrid->carrid ) ).

*  ... §0.3 set the data for the nes node
*      lo_node->set_data_row( p_ls_data ).

      LOOP AT GROUP lrg_carrid REFERENCE INTO lrs_carrid GROUP BY ( connid = lrs_carrid->connid )
                                                         ASCENDING REFERENCE INTO DATA(lrg_connid).
        LOOP AT GROUP lrg_connid REFERENCE INTO DATA(lrs_connid). EXIT. ENDLOOP.

        TRY.
            "Build Sub Parent --> Connid
            CALL METHOD io_view->add_salv_tree_node
              EXPORTING
                iv_related_node = lv_carrid_key
*               iv_relationship = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
                is_data_row     = lrs_connid->*
*               iv_collapsed_icon = MC_COLLAPSE_ICON
*               iv_expanded_icon  = MC_EXPAND_ICON
*               iv_row_style    = IF_SALV_C_TREE_STYLE=>DEFAULT
                iv_text         = lrs_connid->connid
*               iv_visible      = ABAP_TRUE
*               iv_expander     =
*               iv_enabled      = ABAP_TRUE
*               iv_folder       =
                io_tree         = io_view->get_salv_tree_instance( )
              IMPORTING
                ev_last_key     = DATA(lv_connid_key)
                er_nodes        = lo_nodes
                er_node         = lo_node.
          CATCH zbcx_exception.
        ENDTRY.

*  ... §0.2 if information should be displayed at
*    the hierarchy column set the carrid as text for this nod
*        lo_node->set_text( CONV #( lrs_connid->connid ) ).

*  ... §0.3 set the data for the nes node
*      lo_node->set_data_row( p_ls_data ).

        LOOP AT GROUP lrg_connid REFERENCE INTO lrs_connid.
          TRY.
              CALL METHOD io_view->add_salv_tree_node
                EXPORTING
                  iv_related_node   = lv_connid_key
*                 iv_relationship   = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
                  is_data_row       = lrs_connid->*
                  iv_collapsed_icon = space "MC_COLLAPSE_ICON
                  iv_expanded_icon  = space " MC_EXPAND_ICON
*                 iv_row_style      = IF_SALV_C_TREE_STYLE=>DEFAULT
*                 iv_text           =
*                 iv_visible        = ABAP_TRUE
*                 iv_expander       =
*                 iv_enabled        = ABAP_TRUE
*                 iv_folder         =
                  io_tree           = io_view->get_salv_tree_instance( )
                IMPORTING
*                 ev_last_key       = DATA(lv_last_key)
                  er_nodes          = lo_nodes
                  er_node           = lo_node.
            CATCH zbcx_exception.
          ENDTRY.

          "Set data setting
          TRY.
              lo_item = lo_node->get_item( 'CARRID' ).
              lo_item->set_type(  if_salv_c_item_type=>button ).
              lo_item->set_value( lrs_connid->carrid ).
*
*              lo_item = lo_node->get_item( 'CITYFROM' ).
*              lo_item->set_font( if_salv_c_item_font=>fixed_size ).
*              lo_item->set_enabled( abap_false ).

              lo_item = lo_node->get_item( 'CHKBOX' ).
              lo_item->set_type(  if_salv_c_item_type=>checkbox ).
*              lo_item->set_checked( abap_true ).
              lo_item->set_editable( abap_true ).

*              lo_item = lo_node->get_item( 'ACTIVE_ICON' ).
*              lo_item->set_icon( ' ' ).
            CATCH cx_salv_msg.
          ENDTRY.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD _get_main_outtab.
    ro_data = REF #( mt_outtab ).
  ENDMETHOD.

ENDCLASS.
