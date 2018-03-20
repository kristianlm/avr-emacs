
oled.power
oled.D0  2dup  input  down ( high impedance, hardwired to SCK/PB5)
oled.D1  2dup  input  down ( high impedance, hardwired to MOSI)
oled.RST 2dup  output up   ( drive high)
oled.DC  2dup  output down ( for now)
oled.CS  2dup  output down ( drive low)

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

int: int.blink ] led.A ] toggle ] int;
' int.blink 't0ovf !
t0ovfint set
clk/1024 t0clk

led.A toggle
led.A' ground



$ 00 oled.x
$ 00 >oled $ 00 >oled
$ 00 >oled $ 00 >oled
$ 00 >oled $ 00 >oled
$ 00 >oled $ 00 >oled
$ ff >oled $ ff >oled
$ 00 >oled $ 00 >oled
$ ff >oled $ ff >oled
