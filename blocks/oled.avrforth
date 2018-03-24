( driver for SSD1306 $2 OLED )

( pins )
( oled.GND hardwired to GND)
: oled.Vcc ] portb [ $ 06 l ] ;
: oled.D0  ] portb [ $ 07 l ] ;
: oled.D1  ] portd [ $ 05 l ] ;
: oled.RST ] portd [ $ 06 l ] ;
: oled.DC  ] portd [ $ 07 l ] ;
: oled.CS  ] portb [ $ 00 l ] ;


: spi/data   ( -- ) ] oled.DC ] set   ] ;
: spi/cmd    ( -- ) ] oled.DC ] clear ] ;
: >oled   ( ub -- ) ] spi/data ] spitx ] ;

: oled.charge    ( ub -- ) ] spi/cmd [ $ 8d l ] spitx ] spitx ] ;
: oled.precharge ( ub -- ) ] spi/cmd [ $ d9 l ] spitx ] spitx ] ;
: oled.vcomh     ( ub -- ) ] spi/cmd [ $ db l ] spitx ] spitx ] ;
: oled.contrast  ( ub -- ) ] spi/cmd [ $ 81 l ] spitx ] spitx ] ;
: oled.reset ( -- )
    ] oled.RST ] ground
    ] slow2
    ] oled.RST ] pull-up
    ] ;

: oled.on         ( -- ) ] spi/cmd [ $ af l ] spitx [ $ a4 l ] spitx ] ;
: oled.off        ( -- ) ] spi/cmd [ $ ae l ] spitx [ $ a5 l ] spitx ] ;
: oled./inverse   ( -- ) ] spi/cmd [ $ a6 l ] spitx ] ;
: oled.inverse    ( -- ) ] spi/cmd [ $ a7 l ] spitx ] ;
: oled.rightwards ( -- ) ] spi/cmd [ $ a0 l ] spitx ] ; ( cursor direction)
: oled.leftwards  ( -- ) ] spi/cmd [ $ a1 l ] spitx ] ; ( cursor direction)
: oled.vflip      ( -- ) ] spi/cmd [ $ c8 l ] spitx ] ;
: oled./vflip     ( -- ) ] spi/cmd [ $ c0 l ] spitx ] ;
: oled.page     ( n -- ) ] spi/cmd [ $ b0 l ] or ] spitx ] ;
: oled.x        ( n -- ) ] spi/cmd ] imm ] dup ] low ] spitx ] high [ $ 10 l ] or ] spitx ] ;

: oled.fillpage ( c -- ) [ $ 80 l ] for ] dup ] >oled ] next ] drop ] ;
: oled.fill ( c -- )
    [ $ 00 l ] oled.x
    [ $ 00 l ] oled.page ] dup ] oled.fillpage
    [ $ 01 l ] oled.page ] dup ] oled.fillpage
    [ $ 02 l ] oled.page ] dup ] oled.fillpage
    [ $ 03 l ] oled.page ] dup ] oled.fillpage
    [ $ 04 l ] oled.page ] dup ] oled.fillpage
    [ $ 05 l ] oled.page ] dup ] oled.fillpage
    [ $ 06 l ] oled.page ] dup ] oled.fillpage
    [ $ 07 l ] oled.page       ] oled.fillpage
    ] ;

: >oled16 ] dup
    [ $ 5 l ] oled.page ] high ] >oled
    [ $ 4 l ] oled.page ] low ] >oled
    ] ;

: logo
    [ $ 8001 l ] >oled16
    [ $ 803d l ] >oled16
    [ $ 81e1 l ] >oled16
    [ $ 8fc1 l ] >oled16
    [ $ b921 l ] >oled16
    [ $ 8211 l ] >oled16
    [ $ 8409 l ] >oled16
    [ $ 8805 l ] >oled16
    [ $ 9001 l ] >oled16
    [ $ 907d l ] >oled16
    [ $ a005 l ] >oled16
    [ $ e0c5 l ] >oled16
    [ $ c385 l ] >oled16
    [ $ ce01 l ] >oled16
    [ $ 9801 l ] >oled16
    [ $ be01 l ] >oled16
    [ $ 8381 l ] >oled16
    [ $ 80e1 l ] >oled16
    [ $ 8381 l ] >oled16
    [ $ 8e01 l ] >oled16
    [ $ b801 l ] >oled16
    [ $ bffd l ] >oled16
    [ $ 8001 l ] >oled16
    [ $ 8001 l ] >oled16
    ] ;

: oled.splash
    [ $ 00 l ] oled.fill
    [ $ 28 l ] oled.x ] logo
    ] slow2 ] slow2 ] slow2 ] slow2
    ] slow2 ] slow2 ] slow2 ] slow2
    [ $ 00 l ] oled.fill
    ] ;

( OBS: SD1306.pdf section 4.8  says: )
( Power Pins [ VDD VCC ] can never be pulled to ground2 )
: oled.init
    ] oled.D0   ] floating ( hardwired to SCK/PB5 )
    ] oled.D1   ] floating ( hardwired to MOSI )
    ] oled.RST  ] pull-up
    ] oled.DC   ] ground
    ] oled.CS   ] ground
    ] oled.Vcc  ] vcc
    ( init SPI )
    ] ddrb [ $ 3 l ] set ( unused, but MOSI must be output for SPI to work )
    ] ddrb [ $ 5 l ] set ( SCK output )
    ] spimaster
    ] spiclk/2 ] spiclk
    ] msb-first ] spiorder
    ] 0 ] spimode
    ] spi
    ( reset oled display, will cause delay )
    ] oled.reset
    [ $ 04 l ] oled.charge
    [ $ f0 l ] oled.precharge
    [ $ 00 l ] oled.vcomh
    [ $ ff l ] oled.contrast
    ] oled.on
    ] oled.rightwards
    ] oled./inverse
    ] oled.vflip
    ] ;

