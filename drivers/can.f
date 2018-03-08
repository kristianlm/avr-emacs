( can )

[ifdef] cangcon

s" brp" link, ( n -- )
  tosl 1 subi,
  tosl lsl,
  tosl 07e andi,
  canbt1 tosl store
  drop,
  ret,


s" sjw" link, ( n -- )
  tosl 1 subi,
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl 060 andi,

  temp0 canbt2 fetch
  temp0 00e andi,
  temp0 tosl or,
  canbt2 temp0 store

  drop,
  ret,


s" prs" link, ( n -- )
  tosl 1 subi,
  tosl lsl,
  tosl 00e andi,

  temp0 canbt2 fetch
  temp0 060 andi,
  temp0 tosl or,
  canbt2 temp0 store

  drop,
  ret,


s" phs2" link, ( n -- )
  tosl 1 subi,
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl lsl,
  tosl 070 andi,

  temp0 canbt3 fetch
  temp0 00f andi,
  temp0 tosl or,
  canbt3 temp0 store

  drop,
  ret,


s" phs1" link, ( n -- )
  tosl 1 subi,
  tosl lsl,
  tosl 00e andi,

  temp0 canbt3 fetch
  temp0 071 andi,
  temp0 tosl or,
  canbt3 temp0 store

  drop,
  ret,


s" smp" link, ( n -- )
  tosl 001 andi,

  temp0 canbt3 fetch
  temp0 07e andi,
  temp0 tosl or,
  canbt3 temp0 store

  drop,
  ret,


s" can" link, ( -- )
  temp0 enastb 2^ ldi,
  cangcon temp0 store
  ret,


s" /can" link, ( -- )
  cangcon zero store
  ret,


s" mob" link, ( n -- )
  tosl 00f andi,
  tosl swap,
  canpage tosl store
  drop,
  ret,


s" mobclr" link, ( -- )
label mobclr_
  ( clear mob control registers )
  xl canstmob lo ldi,
  xh canstmob hi ldi,
  zero stx+, ( canstmob )
  zero stx+, ( cancdmob )
  zero stx+, ( canidt4 )
  zero stx+, ( canidt3 )
  zero stx+, ( canidt2 )
  zero stx+, ( canidt1 )
  zero stx+, ( canidm4 )
  zero stx+, ( canidm3 )
  zero stx+, ( canidm2 )
  zero stx+, ( canidm1 )

  ( move to canmsg )
  xx 2 adiw,

  ( clear data fifo )
  zero stx,
  zero stx,
  zero stx,
  zero stx,
  zero stx,
  zero stx,
  zero stx,
  zero stx,
  ret,


s" mobclrall" link, ( -- )
  temp0 0e0 ldi,

  begin,
    canpage temp0 store
    mobclr_ call
    temp0 010 subi,
  c until,
  ret,


s" mobget" link, ( -- n ; f )
  temp0 0e0 ldi,

  begin,
    canpage temp0 store
    temp1 cancdmob fetch
    temp1 conmob1 2^ conmob0 2^ or andi,
    z if, ( found free mob )
      dup,
      tosl temp0 mov,
      tosl swap,
      tosh clr,
      true,
      ret,
    then,

    temp0 010 subi,
  c until,

  ( all mobs in use )
  false,
  ret,


( to standard id format )

label tostd_
  tosl lsl,
  tosh rol,
  tosl lsl,
  tosh rol,
  tosl lsl,
  tosh rol,
  tosl lsl,
  tosh rol,
  tosl lsl,
  tosh rol,
  ret,


( from standard id format )

label fromstd_
  tosh lsr,
  tosl ror,
  tosh lsr,
  tosl ror,
  tosh lsr,
  tosl ror,
  tosh lsr,
  tosl ror,
  tosh lsr,
  tosl ror,
  ret,


s" id!" link, ( x -- )
  tostd_ call
  canidt2 tosl store
  canidt1 tosh store
\  cbi_ cancdmob ide clear-bit
  cancdmob zero store
  drop,
  ret,


s" id@" link, ( -- x )
  dup,
  tosl canidt2 fetch
  tosh canidt1 fetch
  fromstd_ jump


s" mask!" link, ( x -- )
  tostd_ call
  canidm2 tosl store
  canidm1 tosh store
  drop,
  ret,


s" mask@" link, ( -- x )
  dup,
  tosl canidm2 fetch
  tosh canidm1 fetch
  fromstd_ jump


( to extended id format )

label toext_
  xl ldy+,
  xh ldy+,
  xl lsl,
  xh rol,
  tosl rol,
  tosh rol,
  xl lsl,
  xh rol,
  tosl rol,
  tosh rol,
  xl lsl,
  xh rol,
  tosl rol,
  tosh rol,
  ret,


( from extended id format )

label fromext_
  tosh lsr,
  tosl ror,
  xh ror,
  xl ror,
  tosh lsr,
  tosl ror,
  xh ror,
  xl ror,
  tosh lsr,
  tosl ror,
  xh ror,
  xl ror,
  xh st-y,
  xl st-y,
  ret,


s" xid!" link, ( d -- )
  toext_ call
  canidt4 xl store
  canidt3 xh store
  canidt2 tosl store
  canidt1 tosh store
\  cancdmob ide set-bit
  temp0 ide 2^ ldi,
  cancdmob temp0 store
  drop,
  ret,


s" xid@" link, ( -- d )
  dup,
  xl canidt4 fetch
  xh canidt3 fetch
  tosl canidt2 fetch
  tosh canidt1 fetch
  fromext_ jump


s" xmask!" link, ( d -- )
  toext_ call
  canidm4 xl store
  canidm3 xh store
  canidm2 tosl store
  canidm1 tosh store
  drop,
  ret,


s" xmask@" link, ( -- d )
  dup,
  xl canidm4 fetch
  xh canidm3 fetch
  tosl canidm2 fetch
  tosh canidm1 fetch
  fromext_ jump


s" dlc!" link, ( n -- )
  temp0 cancdmob fetch
  temp0 0f0 andi,

  tosl 00f andi,
  temp0 tosl or,
  cancdmob temp0 store

  drop,
  ret,


s" dlc@" link, ( -- n )
  dup,
  tosl cancdmob fetch
  tosl 00f andi,
  tosh clr,
  ret,


s" canc!" link, ( c -- )
  canmsg tosl store
  drop,
  ret,


s" can!" link, ( x -- )
  canmsg tosh store
  canmsg tosl store
  drop,
  ret,


s" canc@" link, ( -- c )
  dup,
  tosl canmsg fetch
  tosh clr,
  ret,


s" can@" link, ( -- x )
  dup,
  tosh canmsg fetch
  tosl canmsg fetch
  ret,


s" moboff" link, ( -- )
  temp0 cancdmob fetch
  temp0 conmob1 2^ conmob0 2^ or invert lo andi,
  cancdmob temp0 store
  ret,


s" mobtx" link, ( -- )
  canstmob zero store
  temp0 cancdmob fetch
  temp0 conmob0 2^ ori,
  cancdmob temp0 store
  ret,


s" mobrx" link, ( -- )
  canstmob zero store
  temp0 cancdmob fetch
  temp0 conmob1 2^ ori,
  cancdmob temp0 store
  ret,


s" mobrxb" link, ( -- )
  canstmob zero store
  temp0 cancdmob fetch
  temp0 conmob1 2^ conmob0 2^ or ori,
  cancdmob temp0 store
  ret,


s" cantx?" link, ( -- ; f )
  temp0 canstmob fetch
  temp0 txok 2^ andi,
  ret,


s" canrx?" link, ( -- ; f )
  temp0 canstmob fetch
  temp0 rxok 2^ andi,
  ret,


s" mobst" link, ( -- )
  canstmob zero store
  ret,

[endif]

