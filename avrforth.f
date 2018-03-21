( avrforth )
( daniel j kruszyna )

( configuration )
include config.f
  
( register defines )

  ( z )
  1f constant zh
  1e constant zl
  1e constant zz

  ( y : parameter stack pointer )
  1d constant yh
  1c constant yl
  1c constant yy

  ( x )
  1b constant xh
  1a constant xl
  1a constant xx

  ( top of stack register )
  19 constant tosh
  18 constant tosl
  18 constant tos
  
  ( for assembler macros )
  14 constant as

  ( temp registers )
  13 constant temp3
  12 constant temp2
  11 constant temp1
  10 constant temp0

  ( zero register )
  0f constant zeroh
  0e constant zerol
  0e constant zero

int_stack [if]
  ( interrupt temp )
  07 constant inth
  06 constant intl
[then]

  ( temp for shifting z )
  04 constant ztemp

  ( task pointer )
  03 constant meh
  02 constant mel
  02 constant me

  ( for lpm and multiplies )
  01 constant r1
  00 constant r0


( strings )
( str = a n )

: $! ( str a -- ) over over ! cell+ swap cmove ;
: $+! ( str a -- ) dup @ >r over over +! cell+ r> + swap cmove ;
: $@ ( a -- str ) dup cell+ swap @ ;

( device description )
s" asm/" pad $!
device pad $+!
s" .f" pad $+!
pad $@ included

pagesize 1 - invert constant pagemask

( assembler )
include asm/avr.f

[ifdef] rampz

( shift z left )
: szl,
  ztemp clr,
  zl lsl,
  zh rol,
  ztemp rol,
  rampz ztemp store ;

( shift z right )
: szr,
  ztemp rampz fetch
  ztemp lsr,
  zh ror,
  zl ror, ;

( load program memory )
: lpm   elpm, ;
: lpmz  elpmz, ;
: lpmz+ elpmz+, ;

[else]

( shift z left )
: szl,
  zl lsl,
  zh rol, ;

( shift z right )
: szr,
  zh lsr,
  zl ror, ;

( load program memory )
: lpm lpm, ;
: lpmz lpmz, ;
: lpmz+ lpmz+, ;

[then]

( dictionary links )

: istring ( a n -- )
  dup 1 and >r
  2/ 0 ?do
    dup c@ 00ff and over 1+ c@ 00ff and 8 << or i, 2 +
  loop
  r> if
    c@ 00ff and i,
  else
    0 i,
  then ;

variable link 0 link !
: link, ( a n -- )
  link @ i,
  ihere 1- link !
  istring ;
  
variable mlink 0 mlink !
: mlink, ( a n -- )
  mlink @ i,
  ihere 1- mlink !
  istring ;

( nrww flash section )
( flash writing words and isrs go here )
variable idp' flashend 01ff - idp' !
: idpx idp @ idp' @ idp ! idp' ! ;

( ram interrupt vector )
: ramvector ( a vec -- )
  vector

  zl push,
  zl sreg fetch
  zl push,
  zh push,

  zl over 0 + fetch
  zh swap 1 + fetch
  icall,

  zh pop,
  zl pop,
  sreg zl store
  zl pop,
  reti, ;

( macros )

: dup, ( x -- x x )
  tosh st-y,
  tosl st-y, ;

: drop, ( x -- )
  tosl ldy+,
  tosh ldy+, ;

: 1-, ( x1 -- x2 )
  tos 1 sbiw, ;

: 1+, ( x1 -- x2 )
  tos 1 adiw, ;

: 2*, ( x1 -- x2 )
  tosl lsl,
  tosh rol, ;

: 2/, ( x1 -- x2 )
  tosh asr,
  tosl ror, ;

: lit, ( -- x )
  dup,
  tosl over lo ldi,
  tosh swap hi ldi, ;

: drop_lit, ( x1 -- x2 )
  tosl over lo ldi,
  tosh swap hi ldi, ;

: 2lit, ( -- x1 x2 )
  swap lit, lit, ;

: +,
  dup 0 40 within if
    tos swap adiw,
  else
    negate
    tosl over lo subi,
    tosh swap hi sbci,
  then ;

: -,
  dup negate 0 40 within if
    tos swap sbiw,
  else
    tosl over lo subi,
    tosh swap hi sbci,
  then ;

: andd,
  tosl over lo andi,
  tosh swap hi andi, ;

: orr,
  tosl over lo ori,
  tosh swap hi ori, ;

: invert,
  tosl com,
  tosh com, ;

: low,
  tosh clr, ;

: high,
  tosl tosh mov,
  tosh clr, ;

: true,
  clz, ;

: false,
  sez, ;

: rdrop,
  temp0 pop,
  temp0 pop, ;

( stack manipulations )

s" nip" link, ( x1 x2 -- x2 )
label nip_
  yy 02 adiw,
  ret,

s" tuck" link, ( x1 x2 -- x2 x1 x2 )
label tuck_
  temp0 ldy+,
  temp1 ldy+,
  tosh st-y,
  tosl st-y,
  temp1 st-y,
  temp0 st-y,
  ret,

idpx

s" over" link, ( x1 x2 -- x1 x2 x1 )
label over_
  dup,
  tosl 02 lddy,
  tosh 03 lddy,
  ret,

idpx

s" rot" link, ( x1 x2 x3 -- x2 x3 x1 )
label rot_
  temp0 ldy+,
  temp1 ldy+,
  temp2 ldy+,
  temp3 ldy+,
  temp1 st-y,
  temp0 st-y,
  tosh st-y,
  tosl st-y,
  tos temp2 movw,
  ret,

s" -rot" link, ( x1 x2 x3 -- x3 x1 x2 )
label -rot_
  temp0 ldy+,
  temp1 ldy+,
  temp2 ldy+,
  temp3 ldy+,
  tosh st-y,
  tosl st-y,
  temp3 st-y,
  temp2 st-y,
  tos temp0 movw,
  ret,

idpx

s" swap" link, ( x1 x2 -- x2 x1 )
label swap_
  xx tos movw,
  drop,
  xh st-y,
  xl st-y,
  ret,

idpx

( logical )

s" and" link, ( x1 x2 -- x3 )
label and_
  xl ldy+,
  xh ldy+,
  tosl xl and,
  tosh xh and,
  ret,

s" or" link, ( x1 x2 -- x3 )
label or_
  temp0 ldy+,
  temp1 ldy+,
  tosl temp0 or,
  tosh temp1 or,
  ret,

s" ><" link, ( x1 -- x2 )
label ><_
  temp0 tosl mov,
  tosl tosh mov,
  tosh temp0 mov,
  ret,

s" xor" link, ( x1 x2 -- x3 )
label xor_
  temp0 ldy+,
  temp1 ldy+,
  tosl temp0 eor,
  tosh temp1 eor,
  ret,

s" lshift" link, ( x1 u -- x2 )
label lshift_
  xx tos movw,
  drop,
  ( make z bit valid )
  xx 0 sbiw,
label lshift_loop
  z ~if,
    tosl lsl,
    tosh rol,
    xx 1 sbiw,
    lshift_loop jump
  then,
  ret,

s" rshift" link, ( x1 u -- x2 )
label rshift_
  xx tos movw,
  drop,
  ( make z bit valid)
  xx 0 sbiw,
label rshift_loop
  z ~if,
    tosh lsr,
    tosl ror,
    xx 1 sbiw,
    rshift_loop jump
  then,
  ret,

s" ones" link, ( x -- u )
label ones_

  temp0 clr,

  tosl 0 skip-bit-clear
  temp0 inc,
  tosl 1 skip-bit-clear
  temp0 inc,
  tosl 2 skip-bit-clear
  temp0 inc,
  tosl 3 skip-bit-clear
  temp0 inc,
  tosl 4 skip-bit-clear
  temp0 inc,
  tosl 5 skip-bit-clear
  temp0 inc,
  tosl 6 skip-bit-clear
  temp0 inc,
  tosl 7 skip-bit-clear
  temp0 inc,
  tosh 0 skip-bit-clear
  temp0 inc,
  tosh 1 skip-bit-clear
  temp0 inc,
  tosh 2 skip-bit-clear
  temp0 inc,
  tosh 3 skip-bit-clear
  temp0 inc,
  tosh 4 skip-bit-clear
  temp0 inc,
  tosh 5 skip-bit-clear
  temp0 inc,
  tosh 6 skip-bit-clear
  temp0 inc,
  tosh 7 skip-bit-clear
  temp0 inc,

  tosh clr,
  tosl temp0 mov,
  ret,

( ram )

s" !" link, ( x a -- )
label !_
  zz tos movw,
  drop,
  tosl stz+,
  tosh stz+,
  drop,
  ret,

s" c!" link, ( c ca -- )
label c!_
  zz tos movw,
  drop,
  tosl stz+,
  drop,
  ret,

s" @" link, ( a -- x )
label @_
  zz tos movw,
  tosl ldz+,
  tosh ldz+,
  ret,

s" c@" link, ( ca -- c )
label c@_
  zz tos movw,
  tosl ldz+,
  tosh clr,
  ret,

s" cmove" link, ( ca1 ca2 u -- )
label cmove_
  ( destination )
  zl ldy+,
  zh ldy+,

  ( source )
  xl ldy+,
  xh ldy+,

label cmove_loop
  temp0 ldx+,
  temp0 stz+,
  tos 01 sbiw,
  cmove_loop brne,

  drop,
  ret,

s" cmove>" link, ( ca1 ca2 u -- )
label cmove>_
  ( destination )
  zl ldy+,
  zh ldy+,
  zl tosl add,
  zh tosh adc,
  
  ( source )
  xl ldy+,
  xh ldy+,
  xl tosl add,
  xh tosh adc,
  
label cmove>_loop
  temp0 ld-x,
  temp0 st-z,
  tos 01 adiw,
  cmove>_loop brne,

  drop,
  ret,

s" fill" link, ( ca u c -- )
label fill_
  ( count )
  xl ldy+,
  xh ldy+,

  ( address )
  zl ldy+,
  zh ldy+,

label fill_loop
  tosl stz+,
  xx 1 sbiw,
  fill_loop brne,

  drop,
  ret,

( multitasking )

s" pause" link,
label pause_
  dup,
  yl push,
  yh push,
  zz me movw,
  cli,
  temp0 spl fetch
  temp1 sph fetch
  temp0 stz+,
  temp1 stz+,
  mel ldz+,
  meh ldz+,
  zz me movw,
  temp0 ldz+,
  temp1 ldz+,
  spl temp0 store
  sph temp1 store
  yh pop,
  yl pop,
  sei,
  drop,
  ret,

s" me" link,
label me_
  dup,
  tos me movw,
  ret,

( eeprom access )

label eeprom_wait
  begin,
    eecr eewe skip-bit-set
      ret,
    pause_ call
  again,

label spm_wait
  begin,
    spmcsr spmen skip-bit-set
      ret,
    pause_ call
  again,

s" ec!" link, ( c a -- )
label ec!_
  eeprom_wait call
  spm_wait call

  eearh tosh store
  eearl tosl store

  drop,
  eedr tosl store

  intoff
  eecr eemwe set-bit
  eecr eewe set-bit
  inton

  drop,
  ret,

s" e!" link, ( x a -- )
label e!_
  over_ call
  over_ call
  ec!_ call

  swap_ call
  ><_ call
  swap_ call
  1 +,
  ec!_ jump

s" ec@" link, ( a -- c )
label ec@_
  eeprom_wait call
  
  eearh tosh store
  eearl tosl store

  eecr eere set-bit
  tosl eedr fetch

  tosh clr,
  ret,

s" e@" link, ( a -- x )
label e@_
  dup,
  ec@_ call

  swap_ call
  1 +,
  ec@_ call
  ><_ call
  or_ jump

( return stack manipulations )

( return stack is big endian )

idpx

s" >r" link, ( x -- ) ( r: -- x )
label >r_
  temp1 pop,
  temp0 pop,
  tosl push,
  tosh push,
  temp0 push,
  temp1 push,
  drop,
  ret,

s" r>" link, ( -- x ) ( r: x -- )
label r>_
  dup,
  temp1 pop,
  temp0 pop,
  tosh pop,
  tosl pop,
  temp0 push,
  temp1 push,
  ret,

idpx

s" r@" link, ( -- x ) ( r: x -- x )
label r@_
  dup,
  zh sph fetch
  zl spl fetch
  tosh 03 lddz,
  tosl 04 lddz,
  ret,

\ .include "words/rpstore.asm"
\ .include "words/rpfetch.asm"

( math )

s" -" link, ( x1 x2 -- x3 )
label -_
  xx tos movw,
  drop,
  tosl xl sub,
  tosh xh sbc,
  ret,

s" -!" link, ( x a -- )
label -!_
  xx tos movw,
  drop,
  temp0 ldx+,
  temp1 ldx+,
  temp0 tosl sub,
  temp1 tosh sbc,
  temp1 st-x,
  temp0 st-x,
  drop,
  ret,

s" +" link, ( x1 x2 -- x3 )
label +_
  temp0 ldy+,
  temp1 ldy+,
  tosl temp0 add,
  tosh temp1 adc,
  ret,

s" +!" link, ( x a -- )
label +!_
  xx tos movw,
  drop,
  temp0 ldx+,
  temp1 ldx+,
  temp0 tosl add,
  temp1 tosh adc,
  temp1 st-x,
  temp0 st-x,
  drop,
  ret,

s" um*" link, ( u1 u2 -- ud )
label um*_
  xl ldy+,
  xh ldy+,

  ( tosh * xh )
  tosh xh mul,
  temp2 r0 movw,

  ( tosl * xl )
  tosl xl mul,
  temp0 r0 movw,

  ( tosh * xl )
  tosh xl mul,
  temp1 r0 add,
  temp2 r1 adc,
  temp3 zero adc,

  ( xh * tosl )
  xh tosl mul,
  temp1 r0 add,
  temp2 r1 adc,
  temp3 zero adc,

  ( put low cell on stack )
  temp1 st-y,
  temp0 st-y,

  ( high cell is above low cell on stack )
  tos temp2 movw,
  ret,

s" m*" link, ( n1 n2 -- d )
label m*_
( accumulator is tosh:tosl:xh:xl )
( multiplier and multiplicand are in )
( temp3:temp2 and temp1:temp0 because )
( of register restrictions with mulsu )
  
  temp0 ldy+,
  temp1 ldy+,
  temp2 tos movw,

  ( temp3 * temp1 )
  temp3 temp1 muls,
  tos r0 movw,

  ( temp2 * temp0 )
  temp2 temp0 mul,
  xx r0 movw,

  ( temp3 * temp0 )
  temp3 temp0 mulsu,
  tosh zero sbc,
  xh r0 add,
  tosl r1 adc,
  tosh zero adc,

  ( temp1 * temp2 )
  temp1 temp2 mulsu,
  tosh zero sbc,
  xh r0 add,
  tosl r1 adc,
  tosh zero adc,

  ( put low cell on stack )
  xh st-y,
  xl st-y,
  ret,

s" um/mod" link, ( ud u1 -- u2 u3 )
label um/mod_
  ( load dividend )
  temp2 ldy+,
  temp3 ldy+,
  temp0 ldy+,
  temp1 ldy+,

  ( set loop counter )
  xl 10 ldi,

label um/mod_loop
  ( shift left, saving high bit )
  xh clr,
  temp0 lsl,
  temp1 rol,
  temp2 rol,
  temp3 rol,
  xh rol,

  ( try subtracting divisor )
  temp2 tosl cp,
  temp3 tosh cpc,
  xh zero cpc,

  c ~if,
    ( dividend is large enough )
    ( do the subtraction for real )
    ( and set lowest bit )
    temp0 inc,
    temp2 tosl sub,
    temp3 tosh sbc,
  then,

  xl dec,
  um/mod_loop brne,

  ( put remainder on stack )
  temp3 st-y,
  temp2 st-y,

  ( put quotient on stack )
  tos temp0 movw,
  ret,

s" umin" link, ( u1 u2 -- u3 )
label umin_
  xx tos movw,
  drop,
  tosl xl cp,
  tosh xh cpc,
  c ~if,
    tos xl movw,
  then,
  ret,

s" umax" link, ( u1 u2 -- u3 )
label umax_
  xx tos movw,
  drop,
  tosl xl cp,
  tosh xh cpc,
  c if,
    tos xl movw,
  then,
  ret,

( control )

s" ??" link, ( x1 x2 -- x1 x2 )
label ??_
( set condition codes from comparison )
  xl 0 lddy,
  xh 1 lddy,
  xl tosl cp,
  xh tosh cpc,
  ret,

s" jump" link, ( x -- )
label jump_
  zh pop,
  zl pop,
  zl tosl add,
  zh tosh adc,
  szl,
  tosl lpmz+
  tosh lpmz+
  zz tos movw,
  drop,
  ijmp,

s" f@" link, ( -- x )
label f@_
( fetch condition codes )
  dup,
  tosl sreg fetch
  tosh clr,
  sreg tosl store
  ret,

s" f!" link, ( x -- )
label f!_
( store condition codes )
  sreg tosl store
  drop,
  ret,

( flash )

idpx

s" i@" link, ( a -- x )
label i@_
  zz tos movw,
  szl,

  tosl lpmz+
  tosh lpmz+
  ret,

s" dospm" link, ( spmcsr x a -- )
( execute spm instruction )
label dospm_
\  spm_wait call
\  eeprom_wait call

  begin,
    eecr eewe skip-bit-clear
  again,

  begin,
    spmcsr spmen skip-bit-clear
  again,

  ( address )
  zz tos movw,
  szl,
  drop,

  ( data )
  r0 tos movw,
  drop,

  ( spm timed sequence )
\  cli,
  spmcsr tosl store
\  sei,
  spm,
  
  drop,
  ret,

s" spmbuf" link, ( x a -- )
label spmbuf_
  >r_ call
  >r_ call
  spmen 2^ lit,
  r>_ call
  r>_ call
  dospm_ jump

s" spmerase" link, ( a -- )
label spmerase_
  pagemask andd,

  >r_ call
  pgers 2^ spmen 2^ or lit,
  0 lit,
  r>_ call
  dospm_ jump

s" spmwrite" link, ( a -- )
label spmwrite_
  pagemask andd,
  
  >r_ call
  pgwrt 2^ spmen 2^ or lit,
  0 lit,
  r>_ call
  dospm_ jump

s" spmrww" link, ( -- )
label spmrww_
  rwwsre 2^ spmen 2^ or lit,
  0 lit,
  0 lit,
  dospm_ jump

s" pageload" link, ( a -- )
label pageload_
  ( save complete address for later )
  dup,
  >r_ call

  ( get beginning of page )
  pagemask andd,

  ( loop counter in words )
  pagesize lit,
  swap_ call

  begin,
  
    over_ call
    tos 0 adiw,
    drop,
  z ~while,

    ( don't update temp buffer if it's the )
    ( value we're changing. each location )
    ( can only be written once. )
    r@_ call
    ??_ call
    drop,
    z ~if,
      dup,
      i@_ call
      over_ call
      spmbuf_ call
    then,
  
    1 +,
    swap_ call
    1 -,
    swap_ call
  repeat,

  drop,
  drop,
  r>_ call
  drop,
  ret,

s" i!" link, ( x a -- )
label i!_
( store cell to instruction memory )
  over_ call
  over_ call
  ( if all isrs are in nrww memory, then )
  ( interrupts need only be disabled in dospm )
  cli,
  spmbuf_ call
  dup,
  pageload_ call

  ( an erase cycle is only necessary )
  ( when changing a bit from 0 to 1 )
  over_ call
  over_ call
  i@_ call
  invert,
  and_ call
  tos 0 adiw,
  drop,
  z ~if,
    ( erase block )
    dup,
    spmerase_ call
  then,

  ( write block )
  dup,

  spmwrite_ call
  spmrww_ call
  sei,

  drop,
  drop,
  ret,

idpx

( constants, variables )

s" const" link,
label const_
  dup,
  tosh pop,
  tosl pop,
  i@_ call
  ret,

: const, const_ call i, ;
: var, there const, tallot ;
: evar, ehere const, eallot ;

s" tib"     link, there constant &tib     label tib_     80 var,
s" wordbuf" link, there constant &wordbuf label wordbuf_ 40 var,
s" >in"     link, there constant &>in     label >in_     02 var,
s" link"    link, there constant &link    label link_    02 var,
s" mlink"   link, there constant &mlink   label mlink_   02 var,
s" dict"    link, there constant &dict    label dict_    02 var,
s" dp"      link, there constant &dp      label dp_      02 var,
s" idp"     link, there constant &idp     label idp_     02 var,
s" edp"     link, there constant &edp     label edp_     02 var,
s" source"  link, there constant &source  label source_  02 var,
s" list"    link, there constant &list    label list_    04 var,
s" interp"  link, there constant &interp  label interp_ 100 var,
s" 'key"    link, there constant &'key    label 'key_    02 var,
s" 'emit"   link, there constant &'emit   label 'emit_   02 var,
int_stack [if]
s" ints"    link, there constant &ints    label ints_
  int_rs_size int_ds_size + var,
[then]

s" ~dp"    link, ehere constant &~dp    label ~dp_    02 evar,
s" ~idp"   link, ehere constant &~idp   label ~idp_   02 evar,
s" ~edp"   link, ehere constant &~edp   label ~edp_   02 evar,
s" ~link"  link, ehere constant &~link  label ~link_  02 evar,
s" ~mlink" link, ehere constant &~mlink label ~mlink_ 02 evar,
s" it"     link, ehere constant &it     label it_     02 evar,

s" bl" link, label bl_ 0020 const,

( dictionary )

s" allot"  link, ( n -- ) label allot_  dp_  call +!_ jump
s" iallot" link, ( n -- ) label iallot_ idp_ call +!_ jump
s" eallot" link, ( n -- ) label eallot_ edp_ call +!_ jump

s" here"  link, ( -- a ) label here_  dp_  call @_ jump
s" ihere" link, ( -- a ) label ihere_ idp_ call @_ jump
s" ehere" link, ( -- a ) label ehere_ edp_ call @_ jump

s" ,"  link, ( x -- ) label ,_  here_  call !_  call 2 lit, allot_  jump
s" i," link, ( x -- ) label i,_ ihere_ call i!_ call 1 lit, iallot_ jump
s" e," link, ( x -- ) label e,_ ehere_ call e!_ call 2 lit, eallot_ jump

s" latest" ( -- a )
label latest_
  dict_ call
  @_ jump

( i/o )

s" key" link, ( -- c )
label key_
  zl &'key fetch
  zh &'key 1 + fetch
  ijmp,

s" emit" link, ( c -- )
label emit_
  zl &'emit fetch
  zh &'emit 1 + fetch
  ijmp,

s" cr" link, ( -- )
label cr_
  0d lit,
  emit_ call
  0a lit,
  emit_ jump

s" space" link, ( -- )
label space_
  bl_ call
  emit_ jump

s" type" link, ( ca -- )
label type_
  begin,
    dup,
    c@_ call
    tos 0 adiw,
  z ~while,
    emit_ call
    1 +,
  repeat,
  drop,
  drop,
  ret,

label itype'_drop_two
  drop,

label itype'_drop_one
  drop,
  1 +,
  ret,

s" itype'" link, ( a1 -- a2 )
label itype'_
  dup,
  i@_ call
  dup,
  low,
  
  tos 0 adiw,
  itype'_drop_two breq,

  emit_ call

  high,

  tos 0 adiw,
  itype'_drop_one breq,

  emit_ call
  
  1 +,
  itype'_ jump

s" itype" link, ( a -- )
label itype_
  itype'_ call
  drop,
  ret,

s\" x\"" link, ( -- )
label x"_
  r>_ call
  itype'_ call
  zz tos movw,
  drop,
  ijmp,

label word_eol
  zz 1 sbiw,

label word_address
  tos zz movw,
  source_ call
  !_ call

  wordbuf_ call
  ret,

s" word" link, ( c -- ca | 0 )
label word_
  source_ call
  @_ call
  wordbuf_ call
  xx tos movw,
  drop,
  zz tos movw,
  drop,

  ( skip past opening delimeters )
label word_find_start
  temp0 ldz+,

  temp0 tst,
  z if,
    ( not found )
    ( store new source )
    tos zz movw,
    source_ call
    !_ call

    dup,
    tos zero movw,
    ret,
  then,
  
  tosl temp0 cp,
  word_find_start breq,

  zz 1 sbiw,

label word_find_end
  temp0 ldz+,
  temp0 stx+,

  temp0 tst,
  word_eol breq,
  
  tosl temp0 cp,
  word_find_end brne,

  ( word found )
  ( replace delimeter with null )
  zero st-x,
  xx 1 adiw,
  word_address jump

( interpreter )

s" accept" link, ( ca1 u -- ca2 )
( in: buffer address and length )
( out: address of asciiz string )

label accept_
  over_ call
  +_ call
  1-,
  over_ call

label accept_getkey
  key_ call

  tosl 0d cpi,
  z ~if,

    ( ignore line feeds )
    tosl 0a cpi,
    z if,
      drop,
      accept_getkey jump
    then,

    dup,
    emit_ call

    tosl 08 cpi,
    z ~if,
      ( normal key )
      over_ call
      c!_ call
      1+,
      over_ call
      umin_ call
      accept_getkey jump
    then,
    
    ( backspace )
    drop,
    1-,
    >r_ call
    over_ call
    r>_ call
    umax_ call
    accept_getkey jump
  then,

  ( end of line )
  ( null byte )
  0000 drop_lit,
  over_ call
  c!_ call
  drop,
  drop,
  ret,

s" execute" link, ( i*x xt -- j*x )
label execute_
  zz tos movw,
  drop,
  ijmp,

s" @execute" link, ( i*x a -- j*x )
label @execute_
  @_ call
  execute_ call
  ret,

label find_found
  drop,
  drop,
  1 +,
  >r_ call
  drop,
  drop,
  drop,
  r>_ call
  true,
  ret,

s" find" link, ( ca a -- ca z=1 | xt z=0 )
label find_
  over_ call
  over_ call

  ( name starts at offset 1 in header )
  1 +,

  begin,
    over_ call
    @_ call
    over_ call
    i@_ call

    over_ call
    low,
    over_ call
    low,
    ??_ call
    drop,
    drop,
    z if,

      tosl tst,
      find_found breq,
  
      over_ call
      high,
      over_ call
      high,
      ??_ call
      drop,
      drop,
      z if,

        tosh tst,
        find_found breq,

        drop,
        drop,

        1 +,
        swap_ call

        2 +,
        swap_ call

  rot again,

  then, then,
  
  drop,
  drop,
  drop,
  drop,
  i@_ call

  tos 0 adiw,
  z ~if,
    find_ jump
  then,

  ( not found )
  drop,
  false,
  ret,

s" go" link, 
label abort_
label go_
  ( init return stack pointer )
  sph &interp 0ff + hi load
  spl &interp 0ff + lo load

  ( init parameter stack pointer )
  yh &interp 080 + hi load
  yl &interp 080 + lo load

label go_get_line
  x"_ call s" > " istring

  tib_ call
  07e lit,
  accept_ call

  source_ call
  !_ call

label go_get_word
  bl_ call
  word_ call

  tos 0 adiw,
  z if,
    drop,
    x"_ call s\" \x1b[32m ok \x1b[0m\r\n" istring
    go_get_line jump
  then,

  latest_ call
  @_ call
  find_ call

  z ~if,
    execute_ call
    go_get_word jump
  then,

  ( word not found )
  space_ call
  x"_ call s\" \x1b[31m" istring
  type_ call
  x"_ call s\" ?\x1b[0m\r\n" istring

  go_ jump

s" '" link, ( -- xt )
label '_
  bl_ call
  word_ call

  latest_ call
  @_ call
  find_ call

  z if,
    ( rjmp abort )
    ( return zero instead of aborting )
    drop,
    0 lit,
    ret,
  then,
  ret,

s" forth" link, ( -- )
label forth_
  link_ call
  dict_ call
  !_ jump

s" macro" link, ( -- )
label macro_
  mlink_ call
  dict_ call
  !_ jump

( compiler )

label ,xt_relative
  ( use relative addressing )
  drop,
  00fff andd,
  
  ( rcall opcode )
  0d000 orr,
  i,_ call
  
  drop,
  ret,

s" ,xt" link, ( xt -- )
label ,xt_
  ( update list )
  ihere_ call
  list_ call
  !_ call

  ( get offset )
  dup,
  ihere_ call
  -_ call
  1 -,

  ( check if an rcall will reach )
  dup,
  0f800 andd,
  tosh 00 cpi,
  ,xt_relative breq,
  tosh 0f8 cpi,
  ,xt_relative breq,

  ( try rcall with pc wraparound )
  drop,
  dup,
  tosh tst,
  n ~if,
    flashsize -,
  else,
    flashsize +,
  then,

  0f800 andd,
  tosh 000 cpi,
  ,xt_relative breq,
  tosh 0f8 cpi,
  ,xt_relative breq,

  ( use absolute addressing )
  drop,
  drop,

  ( call opcode )
  0940e lit,
  i,_ call

  ( xt )
  i,_ jump

s" :" link, ( -- )
label :_
  bl_ call
  word_ call

  tos 0 adiw,
  z if,
    abort_ jump
  then,
  
  ihere_ call
  latest_ call
  @_ call
  i,_ call
  latest_ call
  !_ call

  begin,
    dup,
    @_ call
    tosl tst,
    z if,
      tosh clr,
    then,
    tosh tst,
  z ~while,
    i,_ call
    2 +,
  repeat,

  i,_ call
  drop,
  forth_ call
  ret,

s" :" mlink,
  :_ jump


s" ]" link, ( -- )
label ]_
  bl_ call
  word_ call
  mlink_ call
  @_ call
  find_ call
  
  z ~if,
    execute_ call
    ret,
  then,

  link_ call
  @_ call
  find_ call

  ,xt_ call
  ret,

s" c" link, ( -- )
label c_
  macro_ call
  '_ call
  forth_ call
  tos 0 adiw,
  z ~if,
    ,xt_ call
    ret,
  then,  
  drop,
  ret,

s" ;;" mlink, ( -- )
label ;;_
  ( ret opcode )
  9508 lit,
  i,_ jump

label ;_ret
  drop,
  ;;_ jump

s" ;" mlink, ( -- )
label ;_
  list_ call
  @_ call
  ihere_ call
  02 -,
  -_ call
  z ~if,
    drop,
    list_ call
    @_ call
    ihere_ call
    01 -,
    -_ call
    ;_ret brne,

    ( check for rcall instruction )
    drop,
    list_ call
    @_ call
    i@_ call
    dup,
    0f000 andd,
    0d000 -,
    ;_ret brne,

    ( rcall found; change to rjmp )
    drop,
    00fff andd,
    0c000 orr,
    list_ call
    @_ call
    i!_ call

    00000 lit,
    list_ call
    !_ jump
  then,

  ( check for call instruction )
  drop,
  list_ call
  @_ call
  i@_ call
  0940e -,
  ;_ret brne,

  ( call found; change to jump )
  drop,
  0940c lit,
  list_ call
  @_ call
  i!_ call

  00000 lit,
  list_ call
  !_ jump

( stack macros )

s" dup" mlink, ( x -- x x )
label mdup_
  939a lit, i,_ call
  938a lit, i,_ jump

s" drop" mlink, ( x -- )
label mdrop_
  ihere_ call
  list_ call
  !_ call

  9189 lit, i,_ call
  9199 lit, i,_ jump

s" ?dup" mlink, ( x -- x x )
label ?dup_
  list_ call
  @_ call
  ihere_ call
  2 -,
  -_ call
  drop,
  z if,
    list_ call
    @_ call
    i@_ call
    9189 -,
    drop,
    z if,
      list_ call
      @_ call
      1 +,
      i@_ call
      9199 -,
      drop,
      z if,
        list_ call
        @_ call
        idp_ call
        !_ jump
      then,
    then,
  then,
  mdup_ jump

s" l" link, ( x -- )
label l_
  ?dup_ call

  list_ call
  @_ call
  list_ call
  02 +,
  !_ call

  ihere_ call
  list_ call
  !_ call

  dup,

  tosh tosl mov,
  tosh swap,
  00f0f andd,
  0e080 orr,
  i,_ call
  
  tosl tosh mov,
  tosh swap,
  00f0f andd,
  0e090 orr,
  i,_ jump

label ?lit_lit_nodup
  idp_ call
  !_ call
  mdrop_ call

label ?lit_done
  true,
  ret,
  
label ?lit_nolit
  false,
  ret,

s" ?lit" link, ( -- x z=0 | z=1 )
label ?lit_
  ( check for literal )
  list_ call
  @_ call
  ihere_ call
  02 -,
  -_ call
  drop,
\  ?lit_nolit brne,
  z ~if, ?lit_nolit jump then,

  list_ call
  @_ call
  i@_ call
  0f0f0 andd,
  0e080 -,
  drop,
\  ?lit_nolit brne,
  z ~if, ?lit_nolit jump then,

  list_ call
  @_ call
  1 +,
  i@_ call,
  0f0f0 andd,
  0e090 -,
  drop,
\  ?lit_nolit brne,
  z ~if, ?lit_nolit jump then,
  
  ( reclaim literal )
  list_ call
  @_ call
  i@_ call
  00f0f andd,
  tosh swap,
  tosl tosh or,
  tosh clr,
  
  list_ call
  @_ call
  1 +,
  i@_ call
  00f0f andd,
  tosh swap,
  tosh tosl or,
  tosl clr,

  or_ call

  ( move back saved )
  ( optimization address )
  list_ call
  @_ call
  
  list_ call
  02 +,
  @_ call
  list_ call
  !_ call
  
  ( check for dup )
  dup,
  02 -,
  i@_ call
  0939a -,
  drop,
  z ~if, ?lit_lit_nodup jump then,

  dup,
  01 -,
  i@_ call
  0938a -,
  drop,
  z ~if, ?lit_lit_nodup jump then,

label ?lit_lit_dup
  02 -,
  idp_ call
  !_ call
  ?lit_done jump

s" imm" link, ( x1 -- x2 )
label imm_
  tosh tosl mov,
  tosh swap,
  0f0f andd,
  ret,

s\" .\"" link, ( -- )
label ."_
  022 lit,
  word_ call

  x"_ lit,
  ,xt_ call

  begin,
    dup,
    @_ call
    tosl tst,
    z if,
      tosh clr,
    then,

  tosh tst, z ~while,
    i,_ call
    02 +,
  repeat,

  i,_ call
  drop,
  ret,

s" digit" link, ( c -- n )
label digit_
  tosl 0a cpi,
  c if,
    tosl -30 subi,
    ret,
  then,
  tosl -57 subi,
  ret,

s" #" link, ( x -- x' )
label #_
  temp0 clr,
  tosl lsl,
  tosh rol,
  temp0 rol,
  tosl lsl,
  tosh rol,
  temp0 rol,
  tosl lsl,
  tosh rol,
  temp0 rol,
  tosl lsl,
  tosh rol,
  temp0 rol,
  dup,
  tosh clr,
  tosl temp0 mov,
  digit_ call
  emit_ jump

( numeric input )

s" 10*" link, ( x1 -- x2 )
label 10*_
  2*, 2*, 2*, 2*,
  ret,

s" $" link, ( -- x )
label $_
  bl_ call
  word_ call
  tos 0 adiw, z if,
    drop,
    ret,
  then,
  
  zz tos movw,
  tos zero movw,

label $_get_char
  temp0 ldz+,
  temp0 tst, z if, ( done )
    ret,
  then,
  
  10*_ call

  temp0 char 0 cpi,
  $_get_char brlo,

  temp0 char 9 1 + cpi,
  c if,

    temp0 char 0 subi,
    tosl temp0 or,
    $_get_char jump

  then,

  temp0 char a cpi,
  $_get_char brlo,

  temp0 char f 1 + cpi,
  $_get_char brsh,

  temp0 char a 0a - subi,
  tosl temp0 or,
  $_get_char jump

( avrforth version )

s" ver" link, ( -- )
label ver_
  x"_ call
    s\" \r\navrforth " pad $!
    version pad $+!
    s"  [" pad $+!
    device pad $+!
    s\" ]\r\n" pad $+!
  pad $@ istring
  ret,

\ .include "words/spstore.asm" ;;;
\ .include "words/spfetch.asm" ;;;

( drivers )

include drivers/usart.f
include drivers/adc.f
include drivers/timer.f
include drivers/tick.f
include drivers/spi.f
include drivers/can.f
include drivers/twi.f
include drivers/xmem.f
include drivers/gpio.f
include drivers/pll.f
include drivers/usb.f
include drivers/usb-device.f

( startup )

s" empty" link, ( -- )
label empty_
  ~dp_    call e@_ call dp_    call !_ call
  ~idp_   call e@_ call idp_   call !_ call
  ~edp_   call e@_ call edp_   call !_ call
  ~link_  call e@_ call link_  call !_ call
  ~mlink_ call e@_ call mlink_ call !_ call
  ret,

s" mark" link, ( -- )
label mark_
  dp_    call @_ call ~dp_    call e!_ call 
  idp_   call @_ call ~idp_   call e!_ call 
  edp_   call @_ call ~edp_   call e!_ call 
  link_  call @_ call ~link_  call e!_ call 
  mlink_ call @_ call ~mlink_ call e!_ call 
  ret,

s" doit" link, ( -- )
label doit_
  it_ call
  e@_ call
  tosl 0ff cpi, z ~if,
    tosh 0ff cpi, z ~if,
      execute_ call
      ret,
    then,
  then,
  drop,
  ret,

s" cold" link, ( -- )
label cold_
  empty_ call
  forth_ call

usart 01 = [if]
  temp0 rx1_ lo ldi,
  temp1 rx1_ hi ldi,
  &'key temp0 store
  &'key 1 + temp1 store

  temp0 tx1_ lo ldi,
  temp1 tx1_ hi ldi,
  &'emit temp0 store
  &'emit 1 + temp1 store
[else]
  temp0 rx0_ lo ldi,
  temp1 rx0_ hi ldi,
  &'key temp0 store
  &'key 1 + temp1 store

  temp0 tx0_ lo ldi,
  temp1 tx0_ hi ldi,
  &'emit temp0 store
  &'emit 1 + temp1 store
[endif]

  doit_ call

  ver_ call

  0000 lit,
  list_ call
  !_ call

  go_ jump

s" single" link, ( -- )
label single_
  &interp lit,
  &interp 2 + lit,
  !_ jump

s" >int" link, ( -- )
label >int_
  zh pop,
  zl pop,

int_stack [if]
  yl push,
  yh push,

  intl spl fetch
  inth sph fetch

  yl &ints int_ds_size + int_rs_size + 1 - lo load
  yh &ints int_ds_size + int_rs_size + 1 - hi load
  spl yl store
  sph yh store

  yl &ints int_ds_size + lo load
  yh &ints int_ds_size + hi load
[then]

  xl push,
  xh push,

  tosl push,
  tosh push,

  as push,

  temp2 push,
  temp3 push,

  temp0 push,
  temp1 push,

  ztemp push,

  r0 push,
  r1 push,

[ifdef] rampz
  r0 rampz fetch
  r0 push,
[then]

  ijmp,

s" int>" link, ( -- )
label int>_
  zh pop,
  zl pop,

[ifdef] rampz
  r0 pop,
  rampz r0 store
[then]

  r1 pop,
  r0 pop,

  ztemp pop,

  temp1 pop,
  temp0 pop,

  temp3 pop,
  temp2 pop,

  as pop,

  tosh pop,
  tosl pop,

  xh pop,
  xl pop,

int_stack [if]
  spl intl store
  sph inth store

  yh pop,
  yl pop,
[then]

  ijmp,

( main entry point )

reset vector
  ( init return stack pointer )
  sph &interp 0ff + hi load
  spl &interp 0ff + lo load

  ( init parameter stack pointer )
  yh &interp 080 + hi ldi,
  yl &interp 080 + lo ldi,

  ( init task pointer )
  temp1 &interp hi ldi,
  temp0 &interp lo ldi,
  me temp0 movw,

  ( init round robin task list )
  ( interp's next points to itself )
\  zz me movw,
\  zz 02 adiw,
\  mel stz+,
\  meh stz+,
  single_ call

  ( init zeroes register )
  zeroh clr,
  zerol clr,

  ( set baud rate and enable usart )

  cpu_frequency baud_rate 10 * / 1 - lit,

  usart 01 = [if]
    baud1_ call
    usart1_ call
  [else]
    baud0_ call
    usart0_ call
  [endif]

  sei,

  cold_ jump

( eeprom initial values )
tdp   @ &~dp    e!
idp   @ &~idp   e!
edp   @ &~edp   e!
link  @ &~link  e!
mlink @ &~mlink e!

( output files )
s" flash" write-flash
s" eeprom" write-eeprom

( status information )
cr ." flash:  " ihere 04 u.r ."  + 200"
cr ." ram:    " there 04 u.r
cr ." eeprom: " ehere 04 u.r
cr

