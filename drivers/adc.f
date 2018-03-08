( a/d converter driver )

[ifdef] admux

( reference )
s" ref-aref" link, $00 const,
s" ref-avcc" link, $01 const,
s" ref-int"  link, $03 const,

s" adcref" link, ( x -- )
  temp0 admux fetch
  tosl 0 bst,
  temp0 refs0 bld,
  tosl 1 bst,
  temp0 refs1 bld,
  admux temp0 store
  drop,
  ret,

( mux )
s" adcmux" link, ( x -- )
  temp0 admux fetch
  tosl $0f andi,
  temp0 $f0 andi,
  temp0 tosl or,
  admux temp0 store
  drop,
  ret,

( result justification )
s" just-right" link, $00 const,
s" just-left"  link, $01 const,

s" adcjust" link, ( x -- )
  temp0 admux fetch
  tosl 0 bst,
  temp0 adlar bld,
  admux temp0 store
  drop,
  ret,

( prescaler )
s" adcclk/2"   link, $01 const,
s" adcclk/4"   link, $02 const,
s" adcclk/8"   link, $03 const,
s" adcclk/16"  link, $04 const,
s" adcclk/32"  link, $05 const,
s" adcclk/64"  link, $06 const,
s" adcclk/128" link, $07 const,

s" adcclk" link, ( x -- )
  temp0 adcsra fetch
  tosl $07 andi,
  temp0 $f8 andi,
  temp0 tosl or,
  adcsra temp0 store
  drop,
  ret,

( interrupt )
s" adcflag" link, adcsra adif 2lit, ret,
s" adcint"  link, adcsra adie 2lit, ret,

s" 'adc" link, there constant &'adc 02 var,
&'adc adc ramvector

( enable )
s" adc" link, ( -- )
  adcsra aden set-bit
  ret,

( disable )
s" /adc" link, ( -- )
  adcsra aden clear-bit
  ret,

( start conversion )
s" adcstart" link, ( -- )
  adcsra adsc set-bit
  ret,

( wait for conversion )
s" adcwait" link, ( -- )
  begin,
    adcsra adsc skip-bit-set
      ret,
    pause_ call
  again,

( registers )
s" adcdata" link, adcl const,
[ifdef] didr0 s" adcdid" link, didr0 const, [then]

[then]

