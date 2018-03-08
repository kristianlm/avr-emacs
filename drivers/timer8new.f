( new 8 bit timer )

s" tcnt" s" " indexedname find-name [if]
  s" t" s" cnt" indexedname link, s" tcnt" s" "  indexedname evaluate const,
  s" t" s" ovfint" indexedname link, toie  2lit, ret,
  s" t" s" ovfflag" indexedname link, tov  2lit, ret,
  s" 't" s" ovf" indexedname link, there s" &'t" s" ovf" indexedname nextname constant 02 var,
  s" &'t" s" ovf" indexedname evaluate s" timer" s" _overflow"  indexedname evaluate ramvector

s" t" s" clk" indexedname link, ( n -- )
  tosl $07 andi,

  temp0 tccrb fetch
  temp0 $f8 andi,
  temp0 tosl or,
  tccrb temp0 store

  drop,
  ret,

s" t" s" wgm" indexedname link, ( n -- )
  tosh tosl mov,

  tosh $08 andi,

  temp0 tccrb fetch
  temp0 $f7 andi,
  temp0 tosh or,
  tccrb temp0 store

  tosh tosl mov,
  tosh lsr,
  tosh $02 andi,

  tosl $01 andi,

  temp0 tccra fetch
  temp0 $fc andi,
  temp0 tosh or,
  temp0 tosl or,
  tccra temp0 store

  drop,
  ret,

[then]

s" ocr" s" a" indexedname find-name [if]
  s" t" s" oca" indexedname link, s" ocr"  s" a" indexedname evaluate const,
  s" t" s" ocaint" indexedname link, ociea 2lit, ret,
  s" t" s" ocaflag" indexedname link, ocfa 2lit, ret,
  s" 't" s" oca" indexedname link, there s" &'t" s" oca" indexedname nextname constant 02 var,
  s" &'t" s" oca" indexedname evaluate s" timer" s" _compare_a" indexedname evaluate ramvector

s" t" s" coma" indexedname link, ( n -- )
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl $c0 andi,

  temp0 tccra fetch
  temp0 $3f andi,
  temp0 tosl or,
  tccra temp0 store

  drop,
  ret,

[then]

s" ocr" s" b" indexedname find-name [if]
  s" t" s" ocb" indexedname link, s" ocr"  s" b" indexedname evaluate const,
  s" t" s" ocbint" indexedname link, ocieb 2lit, ret,
  s" t" s" ocbflag" indexedname link, ocfb 2lit, ret,
  s" 't" s" ocb" indexedname link, there s" &'t" s" ocb" indexedname nextname constant 02 var,
  s" &'t" s" ocb" indexedname evaluate s" timer" s" _compare_b" indexedname evaluate ramvector

s" t" s" comb" indexedname link, ( n -- )
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl $30 andi,

  temp0 tccra fetch
  temp0 $cf andi,
  temp0 tosl or,
  tccra temp0 store

  drop,
  ret,

[then]

