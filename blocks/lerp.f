( linear interpolation )

: um/ ] um/mod ] nip ] ;
: range ] over ] - ] -rot ] - [ $ 0 l ] swap ] rot ] um/ ] ;

: lerp ( x length table -- y ) ] >r ] 2dup [ $ 10 l ] swap ] - ] rshift
  ] -rot ] lshift ] swap
  ] r> ] + ] dup ] >r
  ] dup ] 1+ ] i@ ] swap ] i@ ] - ] um* ] nip ] r> ] i@ ] + ] ;

: i2@ ] dup ] i@ ] swap ] 1+ ] i@ ] ;
: dlerp ( x length table -- dy ) ] >r ] 2dup [ $ 10 l ] swap ] - ] rshift ] 2*
  ] -rot ] lshift ] swap
  ] r> ] + ] dup ] >r
  ] dup [ $ 2 l ] + ] i2@ ] rot ] i2@ ] d- ] rot ] ut* ] rot ] drop
  ] r> ] i2@ ] d+ ] ;

