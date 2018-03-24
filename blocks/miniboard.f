( miniboard hardware interface)


( TODO we really need a timer here ... )
: slow  [ $ 00ff l ] for ] pause ] next ] ;
: slow2 [ $ 1fff l ] for ] pause ] next ] ;


( status leds )
: led.A  ] portc [ $ 04 l ] ;
: led.A' ] portc [ $ 03 l ] ; ( same as btn.X')

( buttons )

: btn.A  ] portb [ $ 04 l ] ; ( MISO must be output for SPI)
: btn.A' ] portb [ $ 02 l ] ; ( PCINT2 )

: btn.X  ] portc [ $ 02 l ] ; ( PCINT10)
: btn.X' ] portc [ $ 00 l ] ;

: btn.Y  ] portc [ $ 05 l ] ; ( PCINT13)
: btn.Y' ] portc [ $ 03 l ] ;

