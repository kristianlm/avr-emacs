( two wire interface )

[ifdef] twdr

s" twi" link, ( -- )
( enable twi )
  ( set scl to 400kHz at 16MHz system clock )
  temp0 0c ldi,
  twbr temp0 store

  ( enable twi )
  temp0 twen 2^ ldi,
  twcr temp0 store
  ret,


s" /twi" link, ( -- )
( disable twi )
  twcr zero store
  ret,


s" twiwait" link, ( -- )
( wait for twi operation to complete )
label twiwait_
  begin,
    twcr twint skip-bit-clear
      ret,
    pause_ call
  again,


s" twistart" link, ( -- )
( send a start condition )
  temp0 twint 2^ twsta 2^ or twen 2^ or ldi,
  twcr temp0 store
  twiwait_ jump


s" twistop" link, ( -- )
( send a stop condition )
  temp0 twint 2^ twsto 2^ or twen 2^ or ldi,
  twcr temp0 store
  ret,


s" twitx" link, ( c -- )
( send byte )
  twdr tosl store
  drop,
  temp0 twint 2^ twen 2^ or ldi,
  twcr temp0 store
  twiwait_ jump


s" twirx" link, ( -- c )
( receive byte, send ack )
  temp0 twint 2^ twea 2^ or twen 2^ or ldi,
  twcr temp0 store
  twiwait_ call
  dup,
  tosl twdr fetch
  tosh clr,
  ret,


s" twirxn" link, ( -- c )
( receive byte, send nack )
  temp0 twint 2^ twen 2^ or ldi,
  twcr temp0 store
  twiwait_ call
  dup,
  tosl twdr fetch
  tosh clr,
  ret,


s" twistat" link, ( -- c )
( get twi status code )
  dup,
  tosl twsr fetch
  tosl 0f8 andi,
  tosh clr,
  ret,

[then]

