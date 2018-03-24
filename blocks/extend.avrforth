( extended precision arithmetic )

: +.
  temp0 ldy+,
  temp1 ldy+,
  tosl temp0 adc,
  tosh temp1 adc,
  ret,
          
: t+ ] >r ] >r ] >r ] rot ] r> ] + ] rot ] r> ] +. ] rot ] r> ] +. ] ;

: ut* ] dup ] >r ] rot ] um* ] rot [ $ 0 l ] swap
  ] r> ] um* [ $ 0 l ] -rot ] t+ ] ;

: 2*.
  tosl rol,
  tosh rol,
  ret,

: d2* ] swap ] 2* ] swap ] 2*. ] ;
: t2* ] rot ] 2* ] rot ] 2*. ] rot ] 2*. ] ;

: dlshift ] 0? ] if ] for ] d2* ] next ] ; ] then ] drop ] ;

: 2/.
  tosh ror,
  tosl ror,
  ret,

: d2/ ] 2/ ] swap ] 2/. ] swap ] ;
: t2/ ] 2/ ] -rot ] 2/. ] -rot ] 2/. ] -rot ] ;

: 1rshift
  tosh lsr,
  tosl ror,
  ret,

: 1drshift ] 1rshift ] swap ] 2/. ] swap ] ;
: drshift ] 0? ] if ] for ] 1drshift ] next ] ; ] then ] drop ] ;

