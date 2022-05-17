*&---------------------------------------------------------------------*
*&  Include           ZXBC425G07U02
*&---------------------------------------------------------------------*
SUBMIT SAPBC425_BOOKING_07
 WITH so_car = flight-carrid
 WITH so_con = flight-connid
 WITH so_fld = flight-fldate
 AND RETURN.
