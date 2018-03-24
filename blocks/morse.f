( morse input, enter text with 3 buttons )

( physical buttons )
: btn.A  ] portb [ $ 04 l ] ; ( MISO must be output for SPI)
: btn.A' ] portb [ $ 02 l ] ; ( PCINT2 )

: btn.X  ] portc [ $ 02 l ] ; ( PCINT10)
: btn.X' ] portc [ $ 00 l ] ;

: btn.Y  ] portc [ $ 05 l ] ; ( PCINT13)
: btn.Y' ] portc [ $ 03 l ] ;

( construct btn mask 0000 0AXY)
: btns ( -- nibble ) ] btn.A ] pin@
    [ $ 1 l ] lshift ] btn.X ] pin@ ] or
    [ $ 1 l ] lshift ] btn.Y ] pin@ ] or
    [ $ 0007 l ] xor
    ] ;

2 var btns-last      btns btns-last !
2 var btnsq          0    btnsq !

: btns.changed ( -- x ) ] btns-last ] @ ] btns ] dup ] btns-last ] ! ] xor ] ;

( button press queue into nice patterns in btnsq )
( free, press A, release A => 040 )
( free, press Y, release A => 010 )
( hold A, press Y, release Y => 454 )
: btns.q ( nibble -- ) [ $ 000f l ] and ] btnsq ] @ [ $ 4 l ] lshift ] or ] btnsq ] ! ] ;

( current morse sequence )
2 var morsing        1    morsing !
( needs length somehow: always start morsebytes with 1 )
: /morsing [ $ 1 l ] morsing ] ! ] ;

: dit  ( m -- m' ) [ $ 1 l ] lshift [ $ 0 l ] or ] ;
: dash ( m -- m' ) [ $ 1 l ] lshift [ $ 1 l ] or ] ;

(                            .|.|.|.|.|.|.|    )
(                    .|.|.|.|..||..||..||..    )
(                .|.|..||..||....||||....||    )
(              .|..||....||||........||||||    )
ihere 2 + ."   etianmsurwdkgohvf_l_pjbxcyzq__" con morsetable
( morsetable itype )

: even? [ $ 1 l ] and ] 0? ] drop ] ;
: cpick ( x a -- x' ) ] even? ] if ] high ] ; ] then ] low ] ;

: morse@ ( ma -- c ) ] dup
    ] 2/ ] morsetable ] + ] i@
    ] swap ] cpick
    ] ;

( ========== line buffer ========== )

$ 02 var at     0 at !
$ 41 var &line &line $ 41 0 fill ( 1 extra byte for null-termination )
( &line $ 40 dump )
: at++ ] at ] c@ ] 1+ [ $ 3f l ] and ] at ] c! ] ;
: at-- ] at ] c@ ] 1- [ $ 3f l ] and ] at ] c! ] ;
( store char c into line and move cursor )
: commit ( c -- ) ] at ] c@ ] &line ] + ] c! ] at++ ] ;
: lineclear ( -- ) ] &line [ $ 40 l [ $ 20 l ] fill [ $ 0 l ] at ] ! ] ;

( print current line )
: line.
    [ $ 3 l ] oled.page
    ] cr ] at ] @ ] 0? ] if ] for ] space ] next ] then ." v ("
    ] morsing ] @ ] morse@ ] emit ." )"
    ] cr ] &line ] type
    ] &line ] oled<row
    ] at ] @ ] 2* ] 2* ] dup ] oled.x [ $ 0055 l ] >oled
                 [ $ 4 l ] + ] oled.x [ $ 0055 l ] >oled
    ] ;

( btnsq -- )
: btns.handler [ $ 0fff l ] and
    [ $ 0010 l ] ?? ] drop ] =if ." dash " ] morsing ] @ ] dash ] morsing ] ! ] line. ] then
    [ $ 0040 l ] ?? ] drop ] =if ."  dit " ] morsing ] @ ]  dit ] morsing ] ! ] line. ] then
    [ $ 0232 l ] ?? ] drop ] =if ." m>> " ] at++ ] line. ] then
    [ $ 0262 l ] ?? ] drop ] =if ." m<< " ] at-- ] line. ] then
    [ $ 0020 l ] ?? ] drop ] =if ] morsing ] @ ] morse@ ] commit ] line. ] /morsing ] then
    ] drop
  ] ;

( holder for "callback" )
2 var 'btns.handler  0    'btns.handler !

( enqueue new button state if something changed )
: btns.maybeq ( -- )
    ] btns.changed ] 0? ] drop ] if
        ] btns ] btns.q
        ] btnsq ] @ ] 'btns.handler ] @ ] execute ] ;
    ] then ] ;

: btns-watch ] slow ] btns.maybeq ] btns-watch ] ;

( allocate RAM for our main task because )
( we want the forth interpreter running too )
$ 80 var &btns-watch

: morse.init
    ( init buttons )
    ." initializing morse"
    ] btn.A ] pull-up ] btn.A' ] ground
    ] btn.X ] pull-up ] btn.X' ] ground
    ] btn.Y ] pull-up ] btn.Y' ] ground
    ] lineclear
    [ ' btns.handler l ] 'btns.handler ] !
    [ ' btns-watch l [ $ 20 l [ $ 20 l ] &btns-watch ] task-init
    ] line.
    ] ;


: morse.start ] &btns-watch ] task-queue ] ;
: morse.stop  ] &btns-watch ] task-dequeue ] ;

