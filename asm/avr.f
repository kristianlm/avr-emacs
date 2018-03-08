( avr assembler )

hex
: << lshift ;
: >> rshift ;
: lo ff and ;
: hi 8 >> lo ;
: 2^ 1 swap << ;

( target memory )
20 constant regsize
0 constant regstart
1f constant regend
20 constant iostart
iostart iosize + 1- constant ioend
ioend 1+ constant ramstart
ioend ramsize + constant ramend
0 constant flashstart
flashsize 1- constant flashend
0 constant eepromstart
eepromsize 1- constant eepromend

create tflash flashsize 2* allot
tflash flashsize 2* ff fill

create tram ramsize allot
tram ramsize 00 fill

create teeprom eepromsize allot
teeprom eepromsize ff fill

variable idp
variable tdp
variable edp

: ihere idp @ ;
: there tdp @ ;
: ehere edp @ ;

: itarget 2* tflash + ;
: target tram + regsize - iosize - ;
: etarget teeprom + ;

1 constant icell
: icells icell * ;
: icell+ icell + ;
: i@ ( ta -- x ) itarget dup c@ swap 1 + c@ 8 << or ;
: i! ( x ta -- ) itarget over lo over c! swap hi swap 1 + c! ;
: iallot idp +! ;
: i, ihere i! 1 icells iallot ;

2 constant tcell
: tcells tcell * ;
: tcell+ tcell + ;
: tc@ ( ta -- c ) target c@ ;
: tc! ( c ta -- ) target c! ;
: t@ ( ta -- x ) target dup c@ swap 1 + c@ 8 << or ;
: t! ( x ta -- ) target over ff and over c! swap 8 >> ff and swap 1 + c! ;
: tallot tdp +! ;
: tc, there tc! 1 tallot ;
: t, there t! 1 tcells tallot ;

2 constant ecell
: ecells ecell * ;
: ecell+ ecell + ;
: ec@ ( ta -- c ) etarget c@ ;
: ec! ( c ta -- ) etarget c! ;
: e@ ( ta -- x ) etarget dup c@ swap 1 + c@ 8 << or ;
: e! ( x ta -- ) etarget over ff and over c! swap 8 >> ff and swap 1 + c! ;
: eallot edp +! ;
: ec, ehere ec! 1 eallot ;
: e, ehere e! 1 ecells eallot ;


( opcodes )

( sreg bits )

0 constant c
1 constant z
2 constant n
3 constant v
4 constant s
5 constant h
6 constant t
7 constant i

( inherent )
( op )
( oooo oooo oooo oooo )

: inherent i, ;

: break, 9598 inherent ;
: eicall, 9519 inherent ;
: eijmp, 9419 inherent ;
: elpm, 95d8 inherent ;
: espm, 95f8 inherent ;
: icall, 9509 inherent ;
: ijmp, 9409 inherent ;
: lpm, 95c8 inherent ;
: nop, 0000 inherent ;
: ret, 9508 inherent ;
: reti, 9518 inherent ;
: sleep, 9588 inherent ;
: spm, 95e8 inherent ;
: wdr, 95a8 inherent ;

( two 5-bit registers )
( d r op )
( oooo oord dddd rrrr )

: 2reg5bit ( d r op -- )
  >r
  dup 0010 and 5 << r> or >r
  000f and r> or >r
  001f and 4 << r> or i, ;

: adc, 1c00 2reg5bit ;
: add, 0c00 2reg5bit ;
: and, 2000 2reg5bit ;
: cp, 1400 2reg5bit ;
: cpc, 0400 2reg5bit ;
: cpse, 1000 2reg5bit ;
: eor, 2400 2reg5bit ;
: mov, 2c00 2reg5bit ;
: mul, 9c00 2reg5bit ;
: or, 2800 2reg5bit ;
: sbc, 0800 2reg5bit ;
: sub, 1800 2reg5bit ;

: clr, dup eor, ;
: lsl, dup add, ;
: rol, dup adc, ;
: tst, dup and, ;

( one 5-bit register )
( d op )
( oooo oood dddd oooo )

: 1reg5bit ( d op -- )
  >r
  001f and 4 << r> or i, ;

: asr, 9405 1reg5bit ;
: com, 9400 1reg5bit ;
: dec, 940a 1reg5bit ;
: elpmz, 9006 1reg5bit ;
: elpmz+, 9007 1reg5bit ;
: inc, 9403 1reg5bit ;
: ldx, 900c 1reg5bit ;
: ldx+, 900d 1reg5bit ;
: ld-x, 900e 1reg5bit ;
: ldy, 8008 1reg5bit ;
: ldy+, 9009 1reg5bit ;
: ld-y, 900a 1reg5bit ;
: ldz, 8000 1reg5bit ;
: ldz+, 9001 1reg5bit ;
: ld-z, 9002 1reg5bit ;
: lpmz, 9004 1reg5bit ;
: lpmz+, 9005 1reg5bit ;
: lsr, 9406 1reg5bit ;
: neg, 9401 1reg5bit ;
: pop, 900f 1reg5bit ;
: push, 920f 1reg5bit ;
: ror, 9407 1reg5bit ;
: stx, 920c 1reg5bit ;
: stx+, 920d 1reg5bit ;
: st-x, 920e 1reg5bit ;
: sty, 8208 1reg5bit ;
: sty+, 9209 1reg5bit ;
: st-y, 920a 1reg5bit ;
: stz, 8200 1reg5bit ;
: stz+, 9201 1reg5bit ;
: st-z, 9202 1reg5bit ;
: swap, 9402 1reg5bit ;

( one 4-bit register with immediate data )
( d k op )
( oooo kkkk dddd kkkk )

: 1reg4bitimm ( d k op -- )
  >r
  dup 00f0 and 4 << r> or >r
  000f and r> or >r
  000f and 4 << r> or i, ;

: andi, 7000 1reg4bitimm ;
: cpi, 3000 1reg4bitimm ;
: ldi, e000 1reg4bitimm ;
: ori, 6000 1reg4bitimm ;
: sbci, 4000 1reg4bitimm ;
: subi, 5000 1reg4bitimm ;

: cbr, invert andi, ;
: sbr, ori, ;
: ser, ff ldi, ;

( one 2-bit word with immediate data )
( d k op )
( oooo oooo kkdd kkkk )

: 1word2bitimm ( d k op -- )
  >r
  dup 0030 and 2 << r> or >r
  000f and r> or >r
  0006 and 3 << r> or i, ;

: adiw, 9600 1word2bitimm ;
: sbiw, 9700 1word2bitimm ;

( branch )
( s k op )
( k op )
( oooo ookk kkkk ksss )

: branch ( s k op -- )
  >r
  ihere - 1- 007f and 3 << r> or >r
  0007 and r> or i, ;

: brbc, f400 branch ;
: brcc, c swap brbc, ;
: brsh, brcc, ;
: brne, z swap brbc, ;
: brpl, n swap brbc, ;
: brvc, v swap brbc, ;
: brge, s swap brbc, ;
: brhc, h swap brbc, ;
: brtc, t swap brbc, ;
: brid, i swap brbc, ;

: brbs, f000 branch ;
: brcs, c swap brbs, ;
: brlo, brcs, ;
: breq, z swap brbs, ;
: brmi, n swap brbs, ;
: brvs, v swap brbs, ;
: brli, s swap brbs, ;
: brhs, h swap brbs, ;
: brts, t swap brbs, ;
: brie, i swap brbs, ;

( sreg )
( s op )
( oooo oooo osss oooo )

: sregbit ( s op -- )
  >r
  0007 and 4 << r> or i, ;

: bclr, 9488 sregbit ;

: clc, c bclr, ;
: clz, z bclr, ;
: cln, n bclr, ;
: clv, v bclr, ;
: cls, s bclr, ;
: clh, h bclr, ;
: clt, t bclr, ;
: cli, i bclr, ;

: bsei, 9408 sregbit ;

: sec, c bsei, ;
: sez, z bsei, ;
: sen, n bsei, ;
: sev, v bsei, ;
: ses, s bsei, ;
: seh, h bsei, ;
: set, t bsei, ;
: sei, i bsei, ;

( one 5-bit register with i/o location )
( d a op )
( oooo oaad dddd aaaa )

: 1reg5bitio ( d a op -- )
  >r
  dup 0030 and 5 << r> or >r
  000f and r> or >r
  001f and 4 << r> or i, ;

: in, b000 1reg5bitio ;
: out, swap b800 1reg5bitio ;

( two 4-bit registers )
( d r op )
( oooo oooo dddd rrrr )

: 2reg4bit ( d r op -- )
  >r
  000f and r> or >r
  000f and 4 << r> or i, ;

: muls, 0200 2reg4bit ;

( two 3-bit registers )
( d r op )
( oooo oooo oddd orrr )

: 2reg3bit ( d r op -- )
  >r
  0007 and r> or >r
  0007 and 4 << r> or i, ;

: mulsu, 0300 2reg3bit ;
: fmul, 0308 2reg3bit ;
: fmuls, 0380 2reg3bit ;
: fmulsu, 0388 2reg3bit ;

( relative )
( k op )
( oooo kkkk kkkk kkkk )

: relative ( k op -- )
  >r
  ihere - 1- 0fff and r> or i, ;

: rcall, d000 relative ;
: rjmp, c000 relative ;

( one 5-bit register bit operation )
( d b op )
( oooo oood dddd obbb )

: 1reg5bitbit ( d b op -- )
  >r
  0007 and r> or >r
  001f and 4 << r> or i, ;

: bld, f800 1reg5bitbit ;
: bst, fa00 1reg5bitbit ;
: sbrc, fc00 1reg5bitbit ;
: sbrs, fe00 1reg5bitbit ;

( absolute )
( doesn't handle 22-bit addresses yet )
( k op )
( oooo oook kkkk oook )
( kkkk kkkk kkkk kkkk )

: absolute ( k op -- )
  i, i, ;

: call, 940e absolute ;
: jmp, 940c absolute ;

( one i/o register bit operation )
( a b op )
( oooo oooo aaaa abbb )

: 1iobit ( a b op -- )
  >r
  0007 and r> or >r
  001f and 3 << r> or i, ;

: cbi, 9800 1iobit ;
: sbi, 9a00 1iobit ;
: sbic, 9900 1iobit ;
: sbis, 9b00 1iobit ;

( direct )
( k r op )
( oooo oood dddd oooo )
( kkkk kkkk kkkk kkkk )

: direct ( k r op -- )
  >r
  001f and 4 << r> or i, i, ;

: sts, 9200 direct ;
: lds, swap 9000 direct ;

( two words )
( d r op )
( oooo oooo dddd rrrr )

: 2words ( d r op -- )
  >r
  001e and 1 >> r> or >r
  001e and 3 << r> or i, ;

: movw, 0100 2words ;

( indirect with displacement )
( d q op )
( ooqo qqod dddd oqqq )

: displacement ( d q op -- )
  >r
  dup 0020 and 8 << r> or >r
  dup 0018 and 7 << r> or >r
  0007 and r> or >r
  001f and 4 << r> or i, ;

: lddy, 8008 displacement ;
: lddz, 8000 displacement ;
: stdy, swap 8208 displacement ;
: stdz, swap 8200 displacement ;

start idp !
ramstart tdp !
eepromstart edp !

( binary file output )

0 Value flash-file
: write-flash ( ca n -- )
  w/o bin create-file throw to flash-file
  tflash flashsize 2* flash-file write-file throw
  flash-file close-file throw ;

0 Value eeprom-file
: write-eeprom ( ca n -- )
  w/o bin create-file throw to eeprom-file
  teeprom eepromsize eeprom-file write-file throw
  eeprom-file close-file throw ;

( structured assembler constructs )

( fetch and store )
: fetch dup 20 60 within if 20 - in, else lds, then ;
: store over 20 60 within if swap 20 - swap out, else sts, then ;
: load over 0 20 within if 
    over 10 20 within if
      ldi, 
    else as swap ldi, as mov, then
  else as swap ldi, as store then ;

( bit operations )
: skip-bit-clear over 20 40 within if swap 20 - swap sbic,
  else as rot fetch as swap sbrc, then ;
: skip-bit-set over 20 40 within if swap 20 - swap sbis,
  else as rot fetch as swap sbrs, then ;
: set-bit over 20 40 within if swap 20 - swap sbi,
  else over as swap fetch as swap 2^ ori, as store then ;
: clear-bit over 20 40 within if swap 20 - swap cbi,
  else over as swap fetch as swap 2^ invert andi, as store then ;

( address labels )
: label create ihere , does> @ ;

( subroutines )
: rel? ( dest src -- f ) - 1- -800 800 within ;
: call dup ihere rel? if rcall, else call, then ;
: jump dup ihere rel? if rjmp, else jmp, then ;

( variables )
: var create there , tallot does> @ ;
: evar create ehere , eallot does> @ ;

( conditionals )
: if, ( cc -- a ) 0007 and f400 or i, ihere 1- ;
: ~if, ( cc -- a ) 0007 and f000 or i, ihere 1- ;
: then, ( a -- ) ihere over - 1- 007f and 3 << over i@ or swap i! ;
: then, ( a -- ) dup i@
  dup f800 and f000 = if drop ihere over - 1- 007f and 3 << over i@ or swap i!
  else c000 = if ihere over - 1- 0fff and over i@ or swap i!
  then then ;
: else, ( a -- a' ) c000 i, ihere 1- swap then, ;

( loops )
: begin, ( -- a ) ihere ;
: again, ( a -- ) rjmp, ;
: until, ( a cc -- ) swap brbc, ;
: ~until, ( a cc -- ) swap brbs, ;
: do, ( -- a ) ihere ;
: loop, ( a r -- ) dec, brne, ;
: while, ( a cc -- a a ) if, swap ;
: ~while, ( a cc -- a a ) ~if, swap ;
: repeat, ( a a -- ) again, then, ;

\ ( jump table )
\ : jump, ( r -- )
\   ihere 5 +
\   zl over lo ldi,
\   zh swap hi ldi,
\   zl swap add,
\   zh zero adc,
\   ijmp, ;

( interrupts )
: vector idp @ swap idp ! dup jump idp ! ;
: inton sei, ;
: intoff cli, ;

( save/restore sreg in isrs )
: pushsreg
  as push,
  as sreg fetch
  as push, ;
: popsreg
  as pop,
  sreg as store
  as pop, ;

\ ( copy initial ram contents )
\ : mirror ramstart target flashsize itarget ramsize - ramsize move ;
\ : mirror,
\   zh flashend 2* ramsize - hi ldi,
\   zl flashend 2* ramsize - lo ldi,
\   yh ramstart hi ldi,
\   yl ramstart lo ldi,
\   xh flashend 2* hi ldi,
\   xl flashend 2* lo ldi,
\ 
\   begin,
\     zl xl cp,
\     zh xh cpc,
\   z ~while,
\     wh lpmz+,
\     wh sty+,
\   repeat, ;

