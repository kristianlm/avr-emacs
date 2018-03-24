: drop ] drop ] ;
: dup ] dup ] ;

: [ ] ;
: ( [ $ 0029 l ] word ] drop ] ;

: low [ $ 00ff l ] and ] ;
: high ] >< ] low ] ;

( constants )
: 0 [ $ 0000 l ] ;
: 1 [ $ 0001 l ] ;
: 2 [ $ 0002 l ] ;
: 4 [ $ 0004 l ] ;
: -1 [ $ ffff l ] ;

( variables )
: var c : ] here ] l c ; ] allot ] ;
: evar c : ] ehere ] l c ; ] eallot ] ;
: con c : [ ' const l ] ,xt ] i, ] ;

( math )
macro : 1+ [ $ 9601 l ] i, ] ; : 1+ ] 1+ ] ;
macro : 1- [ $ 9701 l ] i, ] ; : 1- ] 1- ] ;
macro : 2* [ $ 0f88 l ] i, [ $ 1f99 l ] i, ] ; : 2* ] 2* ] ;
macro : 2/ [ $ 9595 l ] i, [ $ 9587 l ] i, ] ; : 2/ ] 2/ ] ;
macro : invert [ $ 9580 l ] i, [ $ 9590 l ] i, ] ;
: negate ] invert ] 1+ ] ;

: 2^ ] 1 ] swap ] lshift ] ;

: ntz ] dup ] 1- ] swap ] invert ] and ] ones ] ;

( conditionals )
macro : 0? [ $ 9600 l ] i, ] ;
macro : ? ] ?lit ( literal only )
  ] dup ] low ] imm [ $ e000 l ] or ] i,
  ] high ] imm [ $ e010 l ] or ] i,
  [ $ 1780 l ] i, [ $ 0791 l ] i, ] ;

macro : if ] ihere [ $ f001 l ] i, ] ;
macro : =if ] ihere [ $ f401 l ] i, ] ;
macro : -if ] ihere [ $ f402 l ] i, ] ;
macro : u<if ] ihere [ $ f400 l ] i, ] ;
macro : <if ] ihere [ $ f404 l ] i, ] ;

macro : then ] ihere ] over ] - ] 1-
  [ $ 007f l ] and ] 2* ] 2* ] 2*
  ] over ] i@ ] or ] swap ] i! ] ;

macro : true [ $ 9498 l ] i, ] ;
macro : false [ $ 9418 l ] i, ] ;

( literal optimizations )
macro : or
  ] ?lit ] if
    ] dup ] low ] imm [ $ 6080 l [ ' or ,xt ] i,
    ] high ] imm [ $ 6090 l [ ' or ,xt ] i, ] ;
  ] then [ ' or l ] ,xt ] ;

macro : and
  ] ?lit ] if
    ] dup ] low ] imm [ $ 7080 l ] or ] i,
    ] high ] imm [ $ 7090 l ] or ] i, ] ;
  ] then [ ' and l ] ,xt ] ;

: -, ] dup ] low ] imm [ $ 5080 l ] or ] i,
  ] high ] imm [ $ 4090 l ] or ] i, ] ;
macro : - ] ?lit ] if ] -, ] ; ] then [ ' - l ] ,xt ] ;
macro : + ] ?lit ] if ] negate ] -, ] ; ] then [ ' + l ] ,xt ] ;

macro : @
  ] ?lit ] if
    c ?dup [ $ 9180 l ] i, ] dup ] i, [ $ 9190 l ] i, ] 1+ ] i, ] ;
  ] then [ ' @ l ] ,xt ] ;
macro : c@
  ] ?lit ] if
    c ?dup [ $ 9180 l ] i, ] i, [ $ 2799 l ] i, ] ;
  ] then [ ' c@ l ] ,xt ] ;

macro : !
  ] ?lit ] if
    ] ?lit ] if
      ] dup ] low ] imm [ $ e0a0 l ] or ] i, ] high ] imm [ $ e0b0 l ] or ] i,
      [ $ 93a0 l ] i, ] dup ] i, [ $ 93b0 l ] i, ] 1+ ] i, ] ;
    ] then [ $ 9380 l ] i, ] dup ] i, [ $ 9390 l ] i, ] 1+ ] i, c drop ] ;
  ] then [ ' ! l ] ,xt ] ;
macro : c!
  ] ?lit ] if
    ] ?lit ] if
      ] imm [ $ e0a0 l ] or ] i, [ $ 93a0 l ] i, ] i, ] ;
    ] then [ $ 9380 l ] i, ] i, c drop ] ;
  ] then [ ' c! l ] ,xt ] ;
    
( interrupts )
: int: c : [ ' >int l ] ,xt ] ;
macro : int; [ ' int> l ] ,xt c ;; ] ;

macro : inton [ $ 9478 l ] i, ] ; : inton ] inton ] ;
macro : intoff [ $ 94f8 l ] i, ] ; : intoff ] intoff ] ;

( postincrement )
: c@+ ] dup $ 1 l ] + ] swap ] c@ ] ;
:  @+ ] dup $ 2 l ] + ] swap ]  @ ] ;
: c!+ ] dup ] -rot ] c! $ 1 l ] + ] ;
:  !+ ] dup ] -rot ]  ! $ 2 l ] + ] ;

( predecrement )
: c@- $ 1 l ] - ] dup ] c@ ] ;
:  @- $ 2 l ] - ] dup ]  @ ] ;
: c!- $ 1 l ] - ] dup ] -rot ] c! ] ;
:  !- $ 2 l ] - ] dup ] -rot ]  ! ] ;

( double cell )
: 2@ ] dup [ $ 2 l ] + ] @ ] swap ] @ ] ;
: 2! ] swap ] over ] ! [ $ 2 l ] + ] ! ] ;
: 2drop ] drop ] drop ] ;
: 2dup ] over ] over ] ;
: 2swap ] rot ] >r ] rot ] r> ] ;;
: 2over ] >r ] >r ] 2dup ] r> ] r> ] 2swap ] ;

: d+ ] >r ] rot ] + ] swap ] u<if ] 1+ ] then ] r> ] + ] ;
: d- ] >r ] rot ] swap ] - ] swap ] u<if ] 1- ] then ] r> ] - ] ;

: dinvert ] >r ] invert ] r> ] invert ] ;
: d1+ ] swap ] 1+ ] if ] swap ] ; ] then ] swap ] 1+ ] ;
: dnegate ] dinvert ] d1+ ] ;
: extend ] 0? ] -if [ $ ffff l ] ; ] then [ $ 0000 l ] ;

( multiplication )
: * ] m* ] drop ] ;
: u* ] um* ] drop ] ;

( division )
: m/mod
  ] 0? ] f@ ] >r ] <if ] negate ] >r ] dnegate ] r> ] then
  ] >r ] 0? ] <if ] r@ ] + ] then ] r> ] um/mod
  ] r> ] f! ] <if ] swap ] negate ] swap ] ; ] then ] ;

: /mod ] >r ] extend ] r> ] m/mod ] ;
: / ] /mod ] nip ] ;
: mod ] /mod ] drop ] ;

: */mod ] >r ] m* ] r> ] m/mod ] ;
: */ ] */mod ] nip ] ;

: u/mod [ $ 0000 l ] swap ] um/mod ] ;
: u/ ] u/mod ] nip ] ;
: umod ] u/mod ] drop ] ;

: u*/mod ] >r ] um* ] r> ] um/mod ] ;
: u*/ ] u*/mod ] nip ] ;

( counted loops )
macro : for ] ihere [ ' >r l ] ,xt ] ;
: next' [ ' r> l ] ,xt c 1- ] >r
  ] ihere ] - ] 1- [ $ 007f l ] and ] 2* ] 2* ] 2* ] r> ] or ] i,
  c drop ] ;
macro : next [ $ f401 l ] next' ] ;
macro : -next [ $ f402 l ] next' ] ;

( hex output )
: h. ] # ] # ] # ] # ] drop ] space ] ;
: b. ] >< ] # ] # ] drop ] space ] ;

( display wordlists )
: words' ] 0? ] if ] space ] dup ] 1+ ] itype ] i@ ] words' ] ;
  ] then ] drop ] ;
: words ] link ] @ ] words' ] ;
: macros ] mlink ] @ ] words' ] ;

( multitasking )
: task-init ( xt rs ds task -- )
  ] dup ] >r ] +
  ] dup ] >r ] +
  ] swap ] >< ] swap ] !-
  ] r> $ 2 l ] - ] >< ] swap ] !-
  $ 1 l ] - ] r> ] ! ] ;
: task-queue ( task -- )
  ] me   $ 2 l ] + ] @
  ] over $ 2 l ] + ] !
  ] me   $ 2 l ] + ] ! ] ;
: task-next ( task1 -- task2 )
  $ 2 l ] + ] @ ] ;
: task-prev' ( task1 task2 -- task3 )
  ] dup ] task-next ] rot ] ?? ] =if ] drop ] drop ] ;
  ] then ] -rot ] nip ] task-prev' ] ;
: task-prev ( task1 -- task2 )
  ] dup ] task-prev' ] ;
: task-dequeue ( task -- )
  ] dup ] task-next ] swap ] task-prev $ 2 l ] + ] ! ] ;

: wait ( reg mask -- )
  ] over ] c@ ] over ] and ] 0? ] drop ] if
    ] drop ] drop ] ;
  ] then ] pause ] wait ] ;

: within ] over ] - ] >r ] - ] r> ] - ] drop ] u<if ] true ] ;
  ] then ] false ] ;

[ mark

