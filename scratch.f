
: . ] h. ] ;

( ss-ddr )

spimaster
spiclk/2 spiclk
msb-first spiorder
0 spimode
spi

( pin directions)
ddrb $ 1 set
ddrb $ 3 set
ddrb $ 5 set

\ : spitx% ] spitx ] ;
\ : spitx ] cr ." ==== SPI sending " ] dup ] h. ." === " ] cr ] spitx% ] ;

: spi/data ] portb [ $ 01 l ] set   ] ; 
: spi/cmd  ] portb [ $ 01 l ] clear ] ;
: >oled    ] spi/data ] spitx ] ;

: oled/charge    ] spi/cmd [ $ 8d l ] spitx ] spitx ] ;
: oled/precharge ] spi/cmd [ $ d9 l ] spitx ] spitx ] ;
: oled/vcomh     ] spi/cmd [ $ db l ] spitx ] spitx ] ;
: oled/contrast  ] spi/cmd [ $ 81 l ] spitx ] spitx ] ;

$ 04 oled/charge
$ 00 oled/precharge
$ 02 oled/vcomh
$ 00 oled/contrast

: oled.on              ] spi/cmd [ $ af l ] spitx [ $ a4 l ] spitx ] ;
: oled.off             ] spi/cmd [ $ ae l ] spitx [ $ a5 l ] spitx ] ;
: oled./inverse        ] spi/cmd [ $ a6 l ] spitx ] ;
: oled.inverse         ] spi/cmd [ $ a7 l ] spitx ] ;
: oled.segment_remap   ] spi/cmd [ $ a0 l ] or ] spitx ] ; ( cursor direction)
: oled.vflip           ] spi/cmd [ $ c8 l ] spitx ] ;
: oled./vflip          ] spi/cmd [ $ c0 l ] spitx ] ;
\ : oled/common_remap    ] spi/cmd [ $ c0 l ] or ] spitx ] ; ( use hflip)

: oled.page            ] spi/cmd [ $ b0 l ] or ] spitx ] ;

oled.on oled./inverse oled./vflip
$ 01 oled/segment_remap


1 oled.page

1 var k $ aa k c! k c@ .

: inc ] k ] c@ ] 1+ ] k ] c! ] ;

inc k c@ .

: charts [ $ 33 l ] for ] inc ] k ] c@ ] >oled ] next ] ;

2 oled.page
charts

: endlessly ] begin ] charts ] inc ] next ] ;

endlessly



\ 
\ denne funka:
\ : tsmmont
\ $ 1234 l tos sts,
\ ] ; 
\  
\  
\ lds, r16, wdtcsr \ start timed sequence 
\ ori, r16, (1<< wdce | (1<<WDE) 
\ sts, wdtcsr, r16 
\ \ got four cycles to set the new values from here - 
\ \ set new prescaler(time-out) value = 64K cycles (~0.5 s)
\ ldi r16, (1<<WDE) | (1<<WDP2) | (1<<WDP0) 
\ sts WDTCSR, r16 
\ \ finished setting new values, used 2 cycles
\ 
\ sei, 
\ ret, 
\      