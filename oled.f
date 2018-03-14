
: . ] h. ] ;

\ TODO: implement pin@

\ SPI debugging
\ : spitx% ] spitx ] ;
\ : spitx ] cr ." ==== SPI sending " ] dup ] h. ." === " ] cr ] spitx% ] ;

: up ] set ] ;
: down ] clear ] ;

( port bit -- )
( ddrX == portX - 1) 
: output ] swap ] 1- ] swap ] set ] ;
: input ] swap ] 1- ] swap ] clear ] ;


: oled.D0 ] portd [ $ 05 l ] ; ( hardwired to SCK/PB5)
: oled.D1 ] portd [ $ 06 l ] ; ( hardwired to MOSI)
: oled.DC ] portd [ $ 07 l ] ; ( data/cmd)
: oled.CS ] portb [ $ 00 l ] ;

oled.D0 input
oled.D0 down   ( no pullup)

oled.D1 input
oled.D1 down   ( no pullup)

oled.DC output

oled.CS output ( drive low)
oled.CS down

: spi/data ] oled.DC ] set   ] ; 
: spi/cmd  ] oled.DC ] clear ] ;
: >oled    ] spi/data ] spitx ] ;

: oled/charge    ] spi/cmd [ $ 8d l ] spitx ] spitx ] ;
: oled/precharge ] spi/cmd [ $ d9 l ] spitx ] spitx ] ;
: oled/vcomh     ] spi/cmd [ $ db l ] spitx ] spitx ] ;
: oled/contrast  ] spi/cmd [ $ 81 l ] spitx ] spitx ] ;

: oled.on              ] spi/cmd [ $ af l ] spitx [ $ a4 l ] spitx ] ;
: oled.off             ] spi/cmd [ $ ae l ] spitx [ $ a5 l ] spitx ] ;
: oled./inverse        ] spi/cmd [ $ a6 l ] spitx ] ;
: oled.inverse         ] spi/cmd [ $ a7 l ] spitx ] ;
: oled.segment_remap   ] spi/cmd [ $ a0 l ] or ] spitx ] ; ( cursor direction)
: oled.vflip           ] spi/cmd [ $ c8 l ] spitx ] ;
: oled./vflip          ] spi/cmd [ $ c0 l ] spitx ] ;
: oled.page            ] spi/cmd [ $ b0 l ] or ] spitx ] ;
\ : oled/common_remap    ] spi/cmd [ $ c0 l ] or ] spitx ] ; ( use hflip)

( init SPI)
ddrb $ 3 set ( output)
ddrb $ 5 set ( output)
spimaster
spiclk/2 spiclk
msb-first spiorder
0 spimode
spi

$ 04 oled/charge
$ 00 oled/precharge
$ 02 oled/vcomh
$ 00 oled/contrast
oled.on oled./inverse oled./vflip
$ 01 oled.segment_remap

1 var k 0 k c! k c@ h.
: inc ] c@ ] 1+ ] k ] c! ] ; 
: charts [ $ 33 l ] for ] k ] inc ] k ] c@ ] >oled ] next ] ;

inc k c@ h. ( test)

$ 4 oled.page charts

