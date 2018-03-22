
oled.power
oled.D0  2dup  input  down ( high impedance, hardwired to SCK/PB5)
oled.D1  2dup  input  down ( high impedance, hardwired to MOSI)
oled.RST 2dup  output up   ( drive high)
oled.DC  2dup  output down ( for now)
oled.CS  2dup  output down ( drive low)

btn.A pull-up
btn.A' ground
btn.X pull-up
btn.X' ground
btn.Y pull-up
btn.Y' ground

( init SPI)
ddrb $ 3 set ( unused, but MOSI must be output for SPI to work)
ddrb $ 5 set ( SCK output)
spimaster
spiclk/2 spiclk
msb-first spiorder
0 spimode
spi

oled.power
\ TODO: reset here?
$ 04 oled.charge
$ f0 oled.precharge
$ 00 oled.vcomh
$ ff oled.contrast
oled.on
oled.rightwards
oled./inverse
oled.vflip

$ 4 >oled

$ 4 oled.page

\ t0cnt c@ >oled
\ clk/1024 t0clk t0cnt @ h.
\ int: int.oled ] k ] inc ] k ] c@ ] >oled ] int;
\ ' int.oled 't0ovf !
\ t0ovfint clear
\ t0ovfint set
\ 
\ t0ovfint clear
\ k inc k c@ >oled
\ $ 00 >oled

2 var counter
0 counter !
: counter++ ] counter ] @ ] 1+ ] counter ] ! ] ;

int: int.blink ] led.A ] toggle ] counter++ ] int;
' int.blink 't0ovf !
t0ovfint set
clk-none t0clk
clk/8 t0clk
clk/1024 t0clk

led.A pull-up
led.A toggle
led.A' ground

\ : forever ] led.A ] drop ] c@ ] >oled ] forever ] ; 
\ : forever ] counter ] @ ] >oled ] forever ] ; 

$ 10 oled.x
$ 00 >oled $ 00 >oled
$ 00 >oled $ 00 >oled
$ 00 >oled $ 00 >oled
$ 00 >oled $ 00 >oled
$ ff >oled $ ff >oled
$ 00 >oled $ 00 >oled
$ ff >oled $ ff >oled

\ ========== screen ==========

( screen as in textbuffer => oled )

$ 100 var &tbuf ( 128*64 pixels, 4x8 font = 32 * 8 characters)
: sclear ] &tbuf [ $ 100 l [ $ 20 l ] fill ] ;
: sdump ] &tbuf [ $ fff0 l ] and [ $ 112 l ] dump ] ;

$ 2 var cursorp
0 cursorp !
cursorp @ h.

: oled<row ( a -- ) [ $ 0 l ] oled.x [ $ 20 l ] for ] c@+ ] oled.emit ] next ] drop ] ;
: cursor++ ( -- ) ] cursorp ] c@ ] 1+ ] cursorp ] c! ] ;
: >sb  ( c -- ) ] &tbuf ] cursorp ] c@ ] + ] c! ] cursor++ ] ;
: sb.cr ] cursorp ] c@ [ $ 00e0 l ] and ] cursorp ] c! ] ;

: srefresh
    [ $ 07 l ] oled.page ] &tbuf [ $ 0000 l ] + ] oled<row
    [ $ 06 l ] oled.page ] &tbuf [ $ 0020 l ] + ] oled<row
    [ $ 05 l ] oled.page ] &tbuf [ $ 0040 l ] + ] oled<row
    [ $ 04 l ] oled.page ] &tbuf [ $ 0060 l ] + ] oled<row
    [ $ 03 l ] oled.page ] &tbuf [ $ 0080 l ] + ] oled<row
    [ $ 02 l ] oled.page ] &tbuf [ $ 00a0 l ] + ] oled<row
    [ $ 01 l ] oled.page ] &tbuf [ $ 00c0 l ] + ] oled<row
    [ $ 00 l ] oled.page ] &tbuf [ $ 00e0 l ] + ] oled<row ] ;


: oh.
    ] dup [ $ 0c l ] rshift [ $ f l ] and ] digit ] >sb
    ] dup [ $ 08 l ] rshift [ $ f l ] and ] digit ] >sb
    ] dup [ $ 04 l ] rshift [ $ f l ] and ] digit ] >sb
          [ $ 00 l ] rshift [ $ f l ] and ] digit ] >sb
    ] srefresh
    ] ;

\ : forever ] sb.cr ] o.counter ] srefresh ] forever ] ;
\ : display ] sb.cr ] clicks ] @ ] oh. ] srefresh ] ;


\ sclear sb.cr $ 0002 oh.