( spi )

[ifdef] spdr

( transfer complete interrupt enable )
s" spiint" link, ( -- bit )
  spcr spie 2lit,
  ret,

( transfer complete interrupt flag )
s" spiflag" link, ( -- bit )
  spsr spif 2lit,
  ret,

( spi mode )
s" spimode" link, ( x -- )
  tosl $03 andi,
  tosl lsl,
  tosl lsl,
  temp0 spcr fetch
  temp0 $f3 andi,
  temp0 tosl or,
  spcr temp0 store
  drop,
  ret,

( spi clock prescaler )

s" spiclk/4"   link, $00 const,
s" spiclk/16"  link, $01 const,
s" spiclk/64"  link, $02 const,
s" spiclk/128" link, $03 const,
s" spiclk/2"   link, $04 const,
s" spiclk/8"   link, $05 const,
s" spiclk/32"  link, $06 const,

s" spiclk" link, ( x -- )
  temp0 spsr fetch
  tosl $02 bst,
  temp0 spi2x bld,
  spsr temp0 store
  tosl $03 andi,
  temp0 spcr fetch
  temp0 $fc andi,
  temp0 tosl or,
  spcr temp0 store
  drop,
  ret,

( enable spi )
s" spi" link, ( -- )
  spcr spe set-bit
  ret,

( disable spi )
s" /spi" link, ( -- )
  spcr spe clear-bit
  ret,

( data order )

s" msb-first" link, $00 const,
s" lsb-first" link, $01 const,

s" spiorder" link, ( x -- )
  temp0 spcr fetch
  tosl $00 bst,
  temp0 dord bld,
  spcr temp0 store
  drop,
  ret,

( write collision flag )
s" spicol" link, ( -- bit )
  spsr wcol 2lit,
  ret,

( configure master mode )
s" spimaster" link, ( -- )
  spcr mstr set-bit
  ss-ddr set-bit
  sck-ddr set-bit
  mosi-ddr set-bit
  miso-ddr clear-bit
  ret,

( configure slave mode )
s" spislave" link, ( -- )
  spcr mstr clear-bit
  ss-ddr clear-bit
  sck-ddr clear-bit
  mosi-ddr clear-bit
  miso-ddr set-bit
  ret,

( spi data register )
s" spidata" link, spdr const,

( transfer byte )
s" spix" link, ( c1 -- c2 )
label spix_
  ( start transmission )
  spdr tosl store

  ( wait until complete )
  begin,
    temp0 spsr fetch
    temp0 spif 2^ andi,
  z while,
    pause_ call
  repeat,
  
  ( get response )
  tosl spdr fetch
  tosh clr,
  ret,

( send byte )
s" spitx" link, ( c -- )
  spix_ call
  drop,
  ret,

( receive byte )
s" spirx" link, ( -- c )
  0 lit,
  spix_ jump

[then]

