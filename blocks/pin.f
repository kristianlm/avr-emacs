( pin)

\ TODO: implement pin@

( port bit -- )
: output ] swap ] 1- ] swap ] set ] ; ( ddrX == portX - 1)
: input  ] swap ] 1- ] swap ] clear ] ;

: up   ] set ] ;   ( TODO make output and rename to vcc)
: down ] clear ] ; ( TODO make output and rename to ground)

: ground ] 2dup ] output ] clear ] ;
: vcc    ] 2dup ] output ] set   ] ;

: pull-up        ] 2dup ] input ] up  ] ;
: high-impedance ] 2dup ] input ] down  ] ;

( external and pin change interrupt)

: eimsk [ $ 3d l ] ;
: eimsk.int0 ] eimsk [ $ 0 l ] ;
: eimsk.int1 ] eimsk [ $ 1 l ] ;

: pcicr [ $ 68 l ] ;
: pcicr.pcie0 ] pcicr [ $ 0 l ] ;
: pcicr.pcie1 ] pcicr [ $ 1 l ] ;
: pcicr.pcie2 ] pcicr [ $ 2 l ] ;

: eicra [ $ 69 l ] ;
: eicra.isc00 ] eicra [ $ 0 l ] ;
: eicra.isc01 ] eicra [ $ 1 l ] ;
: eicra.isc10 ] eicra [ $ 2 l ] ;
: eicra.isc11 ] eicra [ $ 3 l ] ;

: pcmsk0 [ $ 6b l ] ;
: pcmsk1 [ $ 6c l ] ;
: pcmsk2 [ $ 6d l ] ;

: pcmsk.pcint2  ] pcmsk0 [ $ 2 l ] ;
: pcmsk.pcint4  ] pcmsk0 [ $ 4 l ] ;

: pcmsk.pcint13 ] pcmsk1 [ $ 5 l ] ;

: eifr [ $ 3c l ] ;
: eifr.intf0 ] eifr [ $ 0 l ] ;
: eifr.intf1 ] eifr [ $ 1 l ] ;

: pcifr [ $ 3b l ] ;
: pcifr.pcif0 ] pcifr [ $ 0 l ] ;
: pcifr.pcif1 ] pcifr [ $ 1 l ] ;
: pcifr.pcif2 ] pcifr [ $ 2 l ] ;
