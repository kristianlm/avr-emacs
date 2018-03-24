
( wait a little )
: idle [ $ 8000 l ] for ] next  ] ;

( $ 00 portb c! )

: on  [ $ 00 l ] ddrb ] c! ] ;
: off [ $ ff l ] ddrb ] c! ] ;

( testing )
on
off

: blink ] on ] idle ] off ] idle ] ;
: blinks ] for ] blink ] next ] ;

( blink 10 times )
$ a blinks
