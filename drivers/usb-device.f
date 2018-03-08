( usb device )

[ifdef] udcon

( remote wake up )
s" usb-wakeup" link, ( -- )
  udcon rmwkup set-bit
  ret,

( attach )
s" usb-attach" link, ( -- )
  udcon detach clear-bit
  ret,

( detach )
s" usb-detach" link, ( -- )
  udcon detach set-bit
  ret,

( detect reset )
s" usb-reset?" link, ( -- f )
  dup,
  tos zero movw,
  udint eorsti skip-bit-clear
    tos 1 sbiw,
  ret,

( acknowledge reset )
s" usb-reset-ack" link, ( -- )
  udint eorsti clear-bit
  ret,

( address )

s" usb-address" link, ( n -- )
  tosl $7f andi,
  udaddr tosl store
  drop,
  ret,

s" usb-address-enable" link, ( -- )
  udaddr adden set-bit
  ret,

( endpoint control )

s" ep-set" link, ( n -- )
  tosl $07 andi,
  uenum tosl store
  drop,
  ret,

s" ep-get" link, ( -- n )
  dup,
  tosl uenum fetch
  tosl $07 andi,
  tosh clr,
  ret,

s" ep-stall" link, ( -- )
  ueconx stallrq set-bit
  ret,

s" ep-continue" link, ( -- )
  ueconx stallrqc set-bit
  ret,

s" ep-reset-toggle" link, ( -- )
  ueconx rstdt set-bit
  ret,

s" ep-enable" link, ( -- )
  ueconx epen set-bit
  ret,

s" ep-disable" link, ( -- )
  ueconx epen clear-bit
  ret,

s" ep-enabled?" link, ( -- f )
  dup,
  tos zero movw,
  ueconx epen skip-bit-clear
    tos 1 sbiw,
  ret,

s" type-control"     link, $00 const,
s" type-isochronous" link, $40 const,
s" type-bulk"        link, $80 const,
s" type-interrupt"   link, $c0 const,

s" ep-type" link, ( n -- )
  tosl $c0 andi,
  temp0 uecfg0x fetch
  temp0 $3f andi,
  temp0 tosl or,
  uecfg0x temp0 store
  drop,
  ret,

s" dir-out" link, $00 const,
s" dir-in"  link, $01 const,

s" ep-dir" link, ( n -- )
  tosl $01 andi,
  temp0 uecfg0x fetch
  temp0 $fe andi,
  temp0 tosl or,
  uecfg0x temp0 store
  drop,
  ret,

s" size-8bytes"   link, $00 const,
s" size-16bytes"  link, $10 const,
s" size-32bytes"  link, $20 const,
s" size-64bytes"  link, $30 const,
s" size-128bytes" link, $40 const,
s" size-256bytes" link, $50 const,

s" ep-size" link, ( n -- )
  tosl $70 andi,
  temp0 uecfg1x fetch
  temp0 $8f andi,
  temp0 tosl or,
  uecfg1x temp0 store
  drop,
  ret,

s" bank-single" link, $00 const,
s" bank-double" link, $04 const,

s" ep-bank" link, ( n -- )
  tosl $0c andi,
  temp0 uecfg1x fetch
  temp0 $f3 andi,
  temp0 tosl or,
  uecfg1x temp0 store
  drop,
  ret,

s" ep-allocate" link, ( -- )
  uecfg1x alloc set-bit
  ret,

s" ep-deallocate" link, ( -- )
  uecfg1x alloc clear-bit
  ret,

s" ep-ready?" link, ( -- f )
  dup,
  tos zero movw,
  ueintx rwal skip-bit-clear
    tos 1 sbiw,
  ret,

s" rx-setup?" link, ( -- f )
  dup,
  tos zero movw,
  ueintx rxstpi skip-bit-clear
    tos 1 sbiw,
  ret,

s" setup-ack" link, ( -- )
  ueintx rxstpi clear-bit
  ret,

s" rx-out?" link, ( -- f )
  dup,
  tos zero movw,
  ueintx rxouti skip-bit-clear
    tos 1 sbiw,
  ret,

s" out-ack" link, ( -- )
  ueintx rxouti clear-bit
  ueintx fifocon clear-bit
  ret,

s" tx-in?" link, ( -- f )
  dup,
  tos zero movw,
  ueintx txini skip-bit-clear
    tos 1 sbiw,
  ret,

s" in-ack" link, ( -- )
  ueintx txini clear-bit
  ueintx fifocon clear-bit
  ret,

s" epc!" link, ( c -- )
  uedatx tosl store
  drop,
  ret,

s" ep!" link, ( x -- )
  uedatx tosl store
  uedatx tosh store
  drop,
  ret,

s" epc@" link, ( -- c )
  dup,
  tosl uedatx fetch
  tosh clr,
  ret,

s" ep@" link, ( -- x )
  dup,
  tosl uedatx fetch
  tosh uedatx fetch
  ret,

s" ep-bytes" link, ( -- n )
  dup,
  tosl uebclx fetch
  tosh uebchx fetch
  ret,

[then]

