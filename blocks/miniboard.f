( miniboard hardware interface)

: led.A  ] portc [ $ 04 l ] ;
: led.A' ] portc [ $ 03 l ] ; ( same as btn.X')

: btn.X  ] portc [ $ 05 l ] ; ( PCINT13)
: btn.X' ] portc [ $ 03 l ] ;

( oled.GND hardwired to GND)
: oled.Vcc ] portb [ $ 06 l ] ;
: oled.D0  ] portb [ $ 07 l ] ;
: oled.D1  ] portd [ $ 05 l ] ;
: oled.RST ] portd [ $ 06 l ] ;
: oled.DC  ] portd [ $ 07 l ] ;
: oled.CS  ] portb [ $ 00 l ] ;

\ "Vcc can never be pullet to ground", SD1306.pdf section 4.8
: oled.power  ] oled.Vcc ] 2dup ] output ] up ] ;
: oled./power ] oled.Vcc ] 2dup ] input  ] down ] ;

: spi/data ] oled.DC ] set   ] ; 
: spi/cmd  ] oled.DC ] clear ] ;
: >oled    ] spi/data ] spitx ] ;

: oled.charge    ] spi/cmd [ $ 8d l ] spitx ] spitx ] ;
: oled.precharge ] spi/cmd [ $ d9 l ] spitx ] spitx ] ;
: oled.vcomh     ] spi/cmd [ $ db l ] spitx ] spitx ] ;
: oled.contrast  ] spi/cmd [ $ 81 l ] spitx ] spitx ] ;

: oled.on         ] spi/cmd [ $ af l ] spitx [ $ a4 l ] spitx ] ;
: oled.off        ] spi/cmd [ $ ae l ] spitx [ $ a5 l ] spitx ] ;
: oled./inverse   ] spi/cmd [ $ a6 l ] spitx ] ;
: oled.inverse    ] spi/cmd [ $ a7 l ] spitx ] ;
: oled.rightwards ] spi/cmd [ $ a0 l ] spitx ] ; ( cursor direction)
: oled.leftwards  ] spi/cmd [ $ a1 l ] spitx ] ; ( cursor direction)
: oled.vflip      ] spi/cmd [ $ c8 l ] spitx ] ;
: oled./vflip     ] spi/cmd [ $ c0 l ] spitx ] ;
: oled.page       ] spi/cmd [ $ b0 l ] or ] spitx ] ;
: oled.x          ] spi/cmd ] imm ] dup ] low ] spitx ] high [ $ 10 l ] or ] spitx ] ;

    