( external memory )

[ifdef] xmcra

( enable )
s" xmem" link, ( -- )
  xmcra sre set-bit
  ret,

( disable )
s" /xmem" link, ( -- )
  xmcra sre clear-bit
  ret,

( upper/lower split address )

s" xmem-split" link, ( x -- )
  tosl $07 andi,
  tosl swap,
  temp0 xmcra fetch
  temp0 $8f andi,
  temp0 tosl or,
  xmcra temp0 store
  ret,

( wait states )

s" xmem-wait-lower" link, ( x -- )
  tosl $03 andi,
  temp0 xmcra fetch
  temp0 $fc andi,
  temp0 tosl or,
  xmcra temp0 store
  drop,
  ret,

s" xmem-wait-upper" link, ( x -- )
  tosl $03 andi,
  tosl lsl,
  tosl lsl,
  temp0 xmcra fetch
  temp0 $f3 andi,
  temp0 tosl or,
  xmcra temp0 store
  ret,

( bus keepers )
s" xmem-keep" link, ( -- bit )
  xmcrb xmbk 2lit,
  ret,

( address mask bits )
s" xmem-mask" link, ( x -- )
  tosl $07 andi,
  temp0 xmcrb fetch
  temp0 $f8 andi,
  temp0 tosl or,
  xmcrb temp0 store
  ret,

[then]

