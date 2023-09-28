*&---------------------------------------------------------------------*
*& Include          YDEMO_SALV_SPILTTING_2_MODL
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_model DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_model DEFINITION INHERITING FROM zcl_mvcfw_base_salv_model.

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_scarr.
             INCLUDE TYPE scarr.
    TYPES:   alv_cellstyl TYPE zcl_mvcfw_base_salv_model=>ts_incl_outtab_ext-alv_cellstyl,
           END OF ty_scarr.
    TYPES: tty_scarr TYPE TABLE OF ty_scarr WITH EMPTY KEY.

    TYPES: BEGIN OF ty_spfli.
             INCLUDE TYPE spfli.
    TYPES:   alv_cellstyl TYPE zcl_mvcfw_base_salv_model=>ts_incl_outtab_ext-alv_cellstyl,
           END OF ty_spfli.
    TYPES: tty_spfli TYPE TABLE OF ty_spfli WITH EMPTY KEY.

    METHODS select_data REDEFINITION.
    METHODS process_data REDEFINITION.
    METHODS get_outtab_1
      RETURNING VALUE(ro_outtab) TYPE REF TO data.
    METHODS get_outtab_2
      RETURNING VALUE(ro_outtab) TYPE REF TO data.

  PROTECTED SECTION.


  PRIVATE SECTION.

    DATA: mt_alv_1 TYPE tty_scarr,
          mt_alv_2 TYPE tty_spfli.

ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_model IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_model IMPLEMENTATION.
  METHOD select_data.
    SELECT * FROM scarr
      INTO CORRESPONDING FIELDS OF TABLE @mt_alv_1.
    IF mt_alv_1[] IS NOT INITIAL.
      SELECT * FROM spfli
         FOR ALL ENTRIES IN @mt_alv_1
       WHERE carrid = @mt_alv_1-carrid
        INTO CORRESPONDING FIELDS OF TABLE @mt_alv_2.
    ENDIF.
  ENDMETHOD.

  METHOD process_data.

    LOOP AT mt_alv_1 ASSIGNING FIELD-SYMBOL(<lfs_alv_1>).
      IF sy-tabix BETWEEN 1 AND 5.
        me->set_editable_cell(
             EXPORTING iv_fname    = 'CARRNAME'
                       iv_tname    = 'MT_ALV_1'
                       iv_disabled = abap_true
             CHANGING  ct_style    = <lfs_alv_1>-alv_cellstyl ).
      ENDIF.
    ENDLOOP.

    "--------------------------------------------------------------------"
    LOOP AT mt_alv_2 ASSIGNING FIELD-SYMBOL(<lfs_alv_2>).
      IF sy-tabix BETWEEN 1 AND 5.
        me->set_editable_cell(
             EXPORTING iv_fname    = 'COUNTRYFR'
                       iv_tname    = 'MT_ALV_2'
                       iv_disabled = abap_true
             CHANGING  ct_style    = <lfs_alv_2>-alv_cellstyl ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_outtab_1.
    ro_outtab = REF #( mt_alv_1 ).
  ENDMETHOD.

  METHOD get_outtab_2.
    ro_outtab = REF #( mt_alv_2 ).
  ENDMETHOD.

ENDCLASS.
