"Name: \TY:CL_BC425_CUSTOMER_07\ME:CONSTRUCTOR\SE:END\EI
ENHANCEMENT 0 ZBC425_SOURCE_ENH_07.
* Fill the birthday attribute
 mv_birthday = iv_birthday.
* Call GET_CITY to fill the city attribute
 mv_city = me->get_city( mv_id ).
ENDENHANCEMENT.
