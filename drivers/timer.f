( timers )

( synchronous timer )
s" clk-none"     link, $00 const,
s" clk/1"        link, $01 const,
s" clk/8"        link, $02 const,
s" clk/64"       link, $03 const,
s" clk/256"      link, $04 const,
s" clk/1024"     link, $05 const,
s" clk-ext-fall" link, $06 const,
s" clk-ext-rise" link, $07 const,

( asynchronous timer )
s" aclk-none" link, $00 const,
s" aclk/1"    link, $01 const,
s" aclk/8"    link, $02 const,
s" aclk/32"   link, $03 const,
s" aclk/64"   link, $04 const,
s" aclk/128"  link, $05 const,
s" aclk/256"  link, $06 const,
s" aclk/1024" link, $07 const,

( waveform generation mode )
s" wgm-normal"     link, $00 const,
s" wgm-pwm8"       link, $01 const,
s" wgm-pwm9"       link, $02 const,
s" wgm-pwm10"      link, $03 const,
s" wgm-ctc-oc"     link, $04 const,
s" wgm-fast8"      link, $05 const,
s" wgm-fast9"      link, $06 const,
s" wgm-fast10"     link, $07 const,
s" wgm-correct-ic" link, $08 const,
s" wgm-correct-oc" link, $09 const,
s" wgm-pwm-ic"     link, $0a const,
s" wgm-pwm-oc"     link, $0b const,
s" wgm-ctc-ic"     link, $0c const,
s" wgm-fast-ic"    link, $0e const,
s" wgm-fast-oc"    link, $0f const,

( output compare pin action )
s" com-normal" link, $00 const,
s" com-toggle" link, $01 const,
s" com-clear"  link, $02 const,
s" com-set"    link, $03 const,

( input capture edge )
s" ice-fall" link, $00 const,
s" ice-rise" link, $01 const,

2variable index

: indexedname ( str1 str2 -- str3 )
  2swap pad $!
  index 2@ pad $+!
  pad $+!
  pad $@ ;

: tccra s" tccr" s" a" indexedname evaluate ;
: tccrb s" tccr" s" b" indexedname evaluate ;
: tccrc s" tccr" s" c" indexedname evaluate ;

: toie  s" toie"  s" -bit" indexedname evaluate ;
: ociea s" ocie" s" a-bit" indexedname evaluate ;
: ocieb s" ocie" s" b-bit" indexedname evaluate ;
: ociec s" ocie" s" c-bit" indexedname evaluate ;
: icie  s" icie"  s" -bit" indexedname evaluate ;

: tov   s" tov"   s" -bit" indexedname evaluate ;
: ocfa  s" ocf"  s" a-bit" indexedname evaluate ;
: ocfb  s" ocf"  s" b-bit" indexedname evaluate ;
: ocfc  s" ocf"  s" c-bit" indexedname evaluate ;
: icf   s" icf"   s" -bit" indexedname evaluate ;


[ifdef] tcnt0
  [ifdef] wgm02
    s" 0" index 2! include timer8new.f
  [else]
    s" 0" index 2! include timer8old.f
  [then]
[then]
[ifdef] tcnt0l s" 0" index 2! include timer16.f [then]

[ifdef] tcnt1
  [ifdef] wgm12
    s" 1" index 2! include timer8new.f
  [else]
    s" 1" index 2! include timer8old.f
  [then]
[then]
[ifdef] tcnt1l s" 1" index 2! include timer16.f [then]

[ifdef] tcnt2
  [ifdef] wgm22
    s" 2" index 2! include timer8new.f
  [else]
    s" 2" index 2! include timer8old.f
  [then]
[then]
[ifdef] tcnt2l s" 2" index 2! include timer16.f [then]

[ifdef] tcnt3
  [ifdef] wgm32
    s" 3" index 2! include timer8new.f
  [else]
    s" 3" index 2! include timer8old.f
  [then]
[then]
[ifdef] tcnt3l s" 3" index 2! include timer16.f [then]

