
: . ] h. ] ;

\ TODO: implement pin@

\ SPI debugging
\ : spitx% ] spitx ] ;
\ : spitx ] cr ." ==== SPI sending " ] dup ] h. ." === " ] cr ] spitx% ] ;

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

oled.power
oled.D0  2dup  input  down ( high impedance, hardwired to SCK/PB5)
oled.D1  2dup  input  down ( high impedance, hardwiared to MOSI)
oled.RST 2dup  output up   ( drive high)
oled.DC  2dup  output down ( for now)
oled.CS  2dup  output down ( drive low)

: spi/data ] oled.DC ] set   ] ; 
: spi/cmd  ] oled.DC ] clear ] ;
: >oled    ] spi/data ] spitx ] ;

: oled.charge    ] spi/cmd [ $ 8d l ] spitx ] spitx ] ;
: oled.precharge ] spi/cmd [ $ d9 l ] spitx ] spitx ] ;
: oled.vcomh     ] spi/cmd [ $ db l ] spitx ] spitx ] ;
: oled.contrast  ] spi/cmd [ $ 81 l ] spitx ] spitx ] ;

: oled.on              ] spi/cmd [ $ af l ] spitx [ $ a4 l ] spitx ] ;
: oled.off             ] spi/cmd [ $ ae l ] spitx [ $ a5 l ] spitx ] ;
: oled./inverse        ] spi/cmd [ $ a6 l ] spitx ] ;
: oled.inverse         ] spi/cmd [ $ a7 l ] spitx ] ;
: oled.rightwards      ] spi/cmd [ $ a0 l ] spitx ] ; ( cursor direction)
: oled.leftwards       ] spi/cmd [ $ a1 l ] spitx ] ; ( cursor direction)
: oled.vflip           ] spi/cmd [ $ c8 l ] spitx ] ;
: oled./vflip          ] spi/cmd [ $ c0 l ] spitx ] ;
: oled.page            ] spi/cmd [ $ b0 l ] or ] spitx ] ;

( init SPI)
ddrb $ 3 set ( MOSI output)
ddrb $ 5 set ( SCK output)
spimaster
spiclk/2 spiclk
msb-first spiorder
0 spimode
spi

oled.power
\ TODO: reset here?
$ 04 oled.charge
$ 80 oled.precharge
$ 00 oled.vcomh
$ ff oled.contrast
oled.on
oled.rightwards
oled./inverse
oled./vflip

1 var k 0 k c! k c@ h.
: inc ] c@ ] 1+ ] k ] c! ] ; 
: charts [ $ 33 l ] for ] k ] inc ] k ] c@ ] >oled ] next ] ;

: blank [ $ 33 l ] for [ $ 00 l ] >oled ] next ] ;
: fill [ $ 33 l ] for ] dup ] >oled ] next ] drop ] ;


inc k c@ h. ( test)

$ 0 oled.page charts

$ ff fill $ 00 fill
