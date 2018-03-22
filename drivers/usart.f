( usart driver )

[ifdef] udr0

( data buffer )

usart0_tx_size 1 - constant usart0_tx_mask
usart0_rx_size 1 - constant usart0_rx_mask

01 var usart0_tx_in
01 var usart0_tx_out
usart0_tx_size var usart0_tx_data

01 var usart0_rx_in
01 var usart0_rx_out
usart0_rx_size var usart0_rx_data

s" usart0" link, ( -- )
( enable usart )
label usart0_
  usart0_tx_in zero store
  usart0_tx_out zero store
  usart0_rx_in zero store
  usart0_rx_out zero store
  temp0 usbs 2^ ucsz0 2^ or ucsz1 2^ or ldi, ( 2 stop bits, 8cs)
  ucsr0c temp0 store
  temp0 txen 2^ rxen 2^ or rxcie 2^ or ldi,
  ucsr0b temp0 store
  ret,

s" /usart0" link, ( -- )
( disable usart )
label /usart0_
  ucsr0b zero store
  ret,

s" baud0" link, ( u -- )
( set baud divisor )
label baud0_
  ubrr0l tosl store
  ubrr0h tosh store
  drop,
  ret,

s" tx0" link, ( c -- )
( send character to usart )
label tx0_
  begin,
    xl usart0_tx_in fetch
    xl inc,
    xl usart0_tx_mask andi,

    xh usart0_tx_out fetch
    xh xl cp,
  z while,
    pause_ call
  repeat,
  
  usart0_tx_in xl store
  zl usart0_tx_data lo ldi,
  zh usart0_tx_data hi ldi,
  zl xl add,
  zh zero adc,
  tosl stz,
  drop,
  ucsr0b udrie set-bit
  ret,

s" tx0?" link, ( -- ; f )
( test if character can be sent )
label tx0?_
  xl usart0_tx_in fetch
  xl inc,
  xl usart0_tx_mask andi,
  xh usart0_tx_out fetch
  xh xl cp,
  ret,

idpx

usart0_udre vector
  pushsreg
  xl push,
  xh push,
  zl push,
  zh push,

  xl usart0_tx_in fetch
  xh usart0_tx_out fetch

  xh xl cp,
  z if,
    ucsr0b udrie clear-bit
  else,
    xh inc,
    xh usart0_tx_mask andi,
    usart0_tx_out xh store
  
    zl usart0_tx_data lo ldi,
    zh usart0_tx_data hi ldi,
    zl xh add,
    zh zero adc,
  
    xl ldz,
    udr0 xl store
  then,

  zh pop,
  zl pop,
  xh pop,
  xl pop,
  popsreg
  reti,

idpx

s" rx0" link, ( -- c )
( fetch character from uart )
label rx0_
  begin,
    xh usart0_rx_out fetch

    xl usart0_rx_in fetch
    xh xl cp,
  z while,
    pause_ call
  repeat,
  
  xh inc,
  xh usart0_rx_mask andi,
  usart0_rx_out xh store

  zl usart0_rx_data lo ldi,
  zh usart0_rx_data hi ldi,
  zl xh add,
  zh zero adc,

  dup,
  tosl ldz,
  tosh clr,
  ret,

s" rx0?" link, ( -- ; f )
( test if character is available )
label rx0?_
  usart0_rx_out fetch
  usart0_rx_in fetch
  xh xl cp,
  ret,

idpx

usart0_rxc vector
  pushsreg
  xl push,
  xh push,
  zl push,
  zh push,

  xl usart0_rx_in fetch
  xh usart0_rx_out fetch

  xl inc,
  xl usart0_rx_mask andi,
  xh xl cp,
  z if,
    xl udr0 fetch
  else,
    usart0_rx_in xl store

    zl usart0_rx_data lo ldi,
    zh usart0_rx_data hi ldi,
    zl xl add,
    zh zero adc,

    xl udr0 fetch
    xl stz,
  then,

  zh pop,
  zl pop,
  xh pop,
  xl pop,
  popsreg
  reti,

idpx

[endif]

[ifdef] udr1

( data buffer )

usart1_tx_size 1 - constant usart1_tx_mask
usart1_rx_size 1 - constant usart1_rx_mask

01 var usart1_tx_in
01 var usart1_tx_out
usart1_tx_size var usart1_tx_data

01 var usart1_rx_in
01 var usart1_rx_out
usart1_rx_size var usart1_rx_data

s" usart1" link, ( -- )
( enable usart )
label usart1_
  usart1_tx_in zero store
  usart1_tx_out zero store
  usart1_rx_in zero store
  usart1_rx_out zero store
  temp0 txen 2^ rxen 2^ or rxcie 2^ or ldi,
  ucsr1b temp0 store
  ret,

s" /usart1" link, ( -- )
( disable usart )
label /usart1_
  ucsr1b zero store
  ret,

s" baud1" link, ( u -- )
( set baud divisor )
label baud1_
  ubrr1l tosl store
  ubrr1h tosh store
  drop,
  ret,

s" tx1" link, ( c -- )
( send character to usart )
label tx1_
  begin,
    xl usart1_tx_in fetch
    xl inc,
    xl usart1_tx_mask andi,

    xh usart1_tx_out fetch
    xh xl cp,
  z while,
    pause_ call
  repeat,
  
  usart1_tx_in xl store
  zl usart1_tx_data lo ldi,
  zh usart1_tx_data hi ldi,
  zl xl add,
  zh zero adc,
  tosl stz,
  drop,
  ucsr1b udrie set-bit
  ret,

s" tx1?" link, ( -- ; f )
( test if character can be sent )
label tx1?_
  xl usart1_tx_in fetch
  xl inc,
  xl usart1_tx_mask andi,
  xh usart1_tx_out fetch
  xh xl cp,
  ret,

idpx

usart1_udre vector
  pushsreg
  xl push,
  xh push,
  zl push,
  zh push,

  xl usart1_tx_in fetch
  xh usart1_tx_out fetch

  xh xl cp,
  z if,
    ucsr1b udrie clear-bit
  else,
    xh inc,
    xh usart1_tx_mask andi,
    usart1_tx_out xh store
  
    zl usart1_tx_data lo ldi,
    zh usart1_tx_data hi ldi,
    zl xh add,
    zh zero adc,
  
    xl ldz,
    udr1 xl store
  then,

  zh pop,
  zl pop,
  xh pop,
  xl pop,
  popsreg
  reti,

idpx

s" rx1" link, ( -- c )
( fetch character from uart )
label rx1_
  begin,
    xh usart1_rx_out fetch

    xl usart1_rx_in fetch
    xh xl cp,
  z while,
    pause_ call
  repeat,
  
  xh inc,
  xh usart1_rx_mask andi,
  usart1_rx_out xh store

  zl usart1_rx_data lo ldi,
  zh usart1_rx_data hi ldi,
  zl xh add,
  zh zero adc,

  dup,
  tosl ldz,
  tosh clr,
  ret,

s" rx1?" link, ( -- ; f )
( test if character is available )
label rx1?_
  usart1_rx_out fetch
  usart1_rx_in fetch
  xh xl cp,
  ret,

idpx

usart1_rxc vector
  pushsreg
  xl push,
  xh push,
  zl push,
  zh push,

  xl usart1_rx_in fetch
  xh usart1_rx_out fetch

  xl inc,
  xl usart1_rx_mask andi,
  xh xl cp,
  z if,
    xl udr1 fetch
  else,
    usart1_rx_in xl store

    zl usart1_rx_data lo ldi,
    zh usart1_rx_data hi ldi,
    zl xl add,
    zh zero adc,

    xl udr1 fetch
    xl stz,
  then,

  zh pop,
  zl pop,
  xh pop,
  xl pop,
  popsreg
  reti,

idpx

[endif]

