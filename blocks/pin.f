( pin)

: up ] set ] ;
: down ] clear ] ;

( port bit -- )
: output ] swap ] 1- ] swap ] set ] ; ( ddrX == portX - 1)
: input ] swap ] 1- ] swap ] clear ] ;
