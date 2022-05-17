METHOD GET_CITY .
   SELECT SINGLE city FROM scustom
 INTO re_city
 WHERE id = iv_id.

 IF sy-subrc <> 0.
 CLEAR re_city.
 ENDIF.
ENDMETHOD.
