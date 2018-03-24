( bit operations )

: ll ] swap ] l ] l ] ;

: get ( a b -- x) ] 2^ ] swap ] c@ ] and ] ones ] ;
: set ( a b -- ) ] 2^ ] over ] c@ ] or ] swap ] c! ] ;
: clear ( a b -- ) ] 2^ ] invert ] over ] c@ ] and ] swap ] c! ] ;
: toggle ( a b --) ] 2dup ] get ] 0? ] if ] drop ] clear ] ; ] then ] drop ] set ] ;

macro : set
  ] ?lit ] if
    ] ?lit ] if
      ] dup [ $ 20 l $ 40 l ] within ] if
        [ $ 20 l ] - ] swap ] sbi, ] ;
      ] then ] l
    ] then ] l
  ] then [ ' set l ] ,xt ] ;

macro : clear
  ] ?lit ] if
    ] ?lit ] if
      ] dup [ $ 20 l $ 40 l ] within ] if
        [ $ 20 l ] - ] swap ] cbi, ] ;
      ] then ] l
    ] then ] l
  ] then [ ' clear l ] ,xt ] ;

