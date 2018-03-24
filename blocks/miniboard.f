( miniboard hardware interface)


( TODO we really need a timer here ... )
: slow  [ $ 00ff l ] for ] pause ] next ] ;
: slow2 [ $ 1fff l ] for ] pause ] next ] ;


( status leds )
: led.A  ] portc [ $ 04 l ] ;
: led.A' ] portc [ $ 03 l ] ; ( same as btn.X')

