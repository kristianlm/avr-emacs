( bit operations )

: ll ] swap ] l ] l ] ;

: set ( a b -- ) ] 2^ ] over ] c@ ] or ] swap ] c! ] ;
: clear ( a b -- ) ] 2^ ] invert ] over ] c@ ] and ] swap ] c! ] ;

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

