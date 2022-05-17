REPORT  zbc425_07_iep_fm.

PARAMETERS: netprice TYPE bc425_price,
 discount TYPE i.
DATA: fullprice TYPE bc425_price,
 discprice TYPE bc425_price.
* Calling the enhanced function module
CALL FUNCTION 'BC425_07_CALC_PRICE'
 EXPORTING
 IM_NETPRICE = netprice
 IM_DISCOUNT = discount
 IMPORTING
 EX_FULLPRICE = fullprice
 EX_DISCPRICE = discprice
 .
WRITE: / 'Full price :', 18 fullprice,
 / 'Discount price :', 18 discprice.
