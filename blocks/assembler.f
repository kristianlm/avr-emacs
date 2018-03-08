( avrforth assembler )
( daniel kruszyna )
( public domain )

( register defines )

( z )
: zh [ $ 1f l ] ;
: zl [ $ 1e l ] ;
: zz [ $ 1e l ] ;

( y : parameter stack pointer )
: yh [ $ 1d l ] ;
: yl [ $ 1c l ] ;
: yy [ $ 1c l ] ;

( x )
: xh [ $ 1b l ] ;
: xl [ $ 1a l ] ;
: xx [ $ 1a l ] ;

( top of stack register )
: tosh [ $ 19 l ] ;
: tosl [ $ 18 l ] ;
: tos  [ $ 18 l ] ;

( temp registers )
: temp3 [ $ 13 l ] ;
: temp2 [ $ 12 l ] ;
: temp1 [ $ 11 l ] ;
: temp0 [ $ 10 l ] ;

( sreg bits )

: cbit [ $ 0 l ] ;
: zbit [ $ 1 l ] ;
: nbit [ $ 2 l ] ;
: vbit [ $ 3 l ] ;
: sbit [ $ 4 l ] ;
: hbit [ $ 5 l ] ;
: tbit [ $ 6 l ] ;
: ibit [ $ 7 l ] ;

( inherent )
( op )
( oooo oooo oooo oooo )

: break, [ $ 9598 l ] i, ] ;
: eicall, [ $ 9519 l ] i, ] ;
: eijmp, [ $ 9419 l ] i, ] ;
: elpm, [ $ 95d8 l ] i, ] ;
: espm, [ $ 95f8 l ] i, ] ;
: icall, [ $ 9509 l ] i, ] ;
: ijmp, [ $ 9409 l ] i, ] ;
: lpm, [ $ 95c8 l ] i, ] ;
: nop, [ $ 0000 l ] i, ] ;
: ret, [ $ 9508 l ] i, ] ;
: reti, [ $ 9518 l ] i, ] ;
: sleep, [ $ 9588 l ] i, ] ;
: spm, [ $ 95e8 l ] i, ] ;
: wdr, [ $ 95a8 l ] i, ] ;

( two 5-bit registers )
( d r op )
( oooo oord dddd rrrr )

: 2reg5bit ( d r op -- )
  ] >r
  ] dup [ $ 0010 l ] and [ $ 5 l ] lshift ] r> ] or ] >r
  [ $ 000f l ] and ] r> ] or ] >r
  [ $ 001f l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] ;

: adc, [ $ 1c00 l ] 2reg5bit ] ;
: add, [ $ 0c00 l ] 2reg5bit ] ;
: and, [ $ 2000 l ] 2reg5bit ] ;
: cp, [ $ 1400 l ] 2reg5bit ] ;
: cpc, [ $ 0400 l ] 2reg5bit ] ;
: cpse, [ $ 1000 l ] 2reg5bit ] ;
: eor, [ $ 2400 l ] 2reg5bit ] ;
: mov, [ $ 2c00 l ] 2reg5bit ] ;
: mul, [ $ 9c00 l ] 2reg5bit ] ;
: or, [ $ 2800 l ] 2reg5bit ] ;
: sbc, [ $ 0800 l ] 2reg5bit ] ;
: sub, [ $ 1800 l ] 2reg5bit ] ;

: clr, ] dup ] eor, ] ;
: lsl, ] dup ] add, ] ;
: rol, ] dup ] adc, ] ;
: tsi, ] dup ] and, ] ;

( one 5-bit register )
( d op )
( oooo oood dddd oooo )

: 1reg5bit ( d op -- )
  ] >r
  [ $ 001f l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] ;

: asr, [ $ 9405 l ] 1reg5bit ] ;
: com, [ $ 9400 l ] 1reg5bit ] ;
: dec, [ $ 940a l ] 1reg5bit ] ;
: elpmz, [ $ 9006 l ] 1reg5bit ] ;
: elpmz+, [ $ 9007 l ] 1reg5bit ] ;
: inc, [ $ 9403 l ] 1reg5bit ] ;
: ldx, [ $ 900c l ] 1reg5bit ] ;
: ldx+, [ $ 900d l ] 1reg5bit ] ;
: ld-x, [ $ 900e l ] 1reg5bit ] ;
: ldy, [ $ 8008 l ] 1reg5bit ] ;
: ldy+, [ $ 9009 l ] 1reg5bit ] ;
: ld-y, [ $ 900a l ] 1reg5bit ] ;
: ldz,  [ $ 8000 l ] 1reg5bit ] ;
: ldz+, [ $ 9001 l ] 1reg5bit ] ;
: ld-z, [ $ 9002 l ] 1reg5bit ] ;
: lpmz, [ $ 9004 l ] 1reg5bit ] ;
: lpmz+, [ $ 9005 l ] 1reg5bit ] ;
: lsr, [ $ 9406 l ] 1reg5bit ] ;
: neg, [ $ 9401 l ] 1reg5bit ] ;
: pop, [ $ 900f l ] 1reg5bit ] ;
: push, [ $ 920f l ] 1reg5bit ] ;
: ror, [ $ 9407 l ] 1reg5bit ] ;
: stx, [ $ 920c l ] 1reg5bit ] ;
: stx+, [ $ 920d l ] 1reg5bit ] ;
: st-x, [ $ 920e l ] 1reg5bit ] ;
: sty, [ $ 8208 l ] 1reg5bit ] ;
: sty+, [ $ 9209 l ] 1reg5bit ] ;
: st-y, [ $ 920a l ] 1reg5bit ] ;
: stz, [ $ 8200 l ] 1reg5bit ] ;
: stz+, [ $ 9201 l ] 1reg5bit ] ;
: st-z, [ $ 9202 l ] 1reg5bit ] ;
: swap, [ $ 9402 l ] 1reg5bit ] ;

( one 4-bit register with immediate data )
( d k op )
( oooo kkkk dddd kkkk )

: 1reg4bitimm ( d k op -- )
  ] >r
  ] dup [ $ 00f0 l ] and [ $ 4 l ] lshift ] r> ] or ] >r
  [ $ 000f l ] and ] r> ] or ] >r
  [ $ 000f l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] ;

: andi, [ $ 7000 l ] 1reg4bitimm ] ;
: cpi, [ $ 3000 l ] 1reg4bitimm ] ;
: ldi, [ $ e000 l ] 1reg4bitimm ] ;
: ori, [ $ 6000 l ] 1reg4bitimm ] ;
: sbci, [ $ 4000 l ] 1reg4bitimm ] ;
: subi, [ $ 5000 l ] 1reg4bitimm ] ;

: cbr, ] invert ] andi, ] ;
: sbr, ] ori, ] ;
: ser, [ $ ff l ] ldi, ] ;

( one 2-bit word with immediate data )
( d k op )
( oooo oooo kkdd kkkk )

: 1word2bitimm ( d k op -- )
  ] >r
  ] dup [ $ 0030 l ] and [ $ 2 l ] lshift ] r> ] or ] >r
  [ $ 000f l ] and ] r> ] or ] >r
  [ $ 0006 l ] and [ $ 3 l ] lshift ] r> ] or ] i, ] ;

: adiw, [ $ 9600 l ] 1word2bitimm ] ;
: sbiw, [ $ 9700 l ] 1word2bitimm ] ;

( branch )
( s k op )
( k op )
( oooo ookk kkkk ksss )

: branch ( s k op -- )
  ] >r
  ] ihere ] - ] 1- [ $ 007f l ] and [ $ 3 l ] lshift ] r> ] or ] >r
  [ $ 0007 l ] and ] r> ] or ] i, ] ;

: brbc, [ $ f400 l ] branch ] ;
: brcc, ] cbit ] swap ] brbc, ] ;
: brsh, ] brcc, ] ;
: brne, ] zbit ] swap ] brbc, ] ;
: brpl, ] nbit ] swap ] brbc, ] ;
: brvc, ] vbit ] swap ] brbc, ] ;
: brge, ] sbit ] swap ] brbc, ] ;
: brhc, ] hbit ] swap ] brbc, ] ;
: brtc, ] tbit ] swap ] brbc, ] ;
: brid, ] ibit ] swap ] brbc, ] ;

: brbs, [ $ f000 l ] branch ] ;
: brcs, ] cbit ] swap ] brbs, ] ;
: brlo, ] brcs, ] ;
: breq, ] zbit ] swap ] brbs, ] ;
: brmi, ] nbit ] swap ] brbs, ] ;
: brvs, ] vbit ] swap ] brbs, ] ;
: brli, ] sbit ] swap ] brbs, ] ;
: brhs, ] hbit ] swap ] brbs, ] ;
: brts, ] tbit ] swap ] brbs, ] ;
: brie, ] ibit ] swap ] brbs, ] ;

( sreg )
( s op )
( oooo oooo osss oooo )

: sregbit ( s op -- )
  ] >r
  [ $ 0007 l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] ;

: bclr, [ $ 9488 l ] sregbit ] ;

: clc, [ cbit l ] bclr, ] ;
: clz, [ zbit l ] bclr, ] ;
: cln, [ nbit l ] bclr, ] ;
: clv, [ vbit l ] bclr, ] ;
: cls, [ sbit l ] bclr, ] ;
: clh, [ hbit l ] bclr, ] ;
: clt, [ tbit l ] bclr, ] ;
: cli, [ ibit l ] bclr, ] ;

: bsei, [ $ 9408 l ] sregbit ] ;

: sec, [ cbit l ] bsei, ] ;
: sez, [ zbit l ] bsei, ] ;
: sen, [ nbit l ] bsei, ] ;
: sev, [ vbit l ] bsei, ] ;
: ses, [ sbit l ] bsei, ] ;
: seh, [ hbit l ] bsei, ] ;
: set, [ tbit l ] bsei, ] ;
: sei, [ ibit l ] bsei, ] ;

( one 5-bit register with i/o location )
( d a op )
( oooo oaad dddd aaaa )

: 1reg5bitio ( d a op -- )
  ] >r
  ] dup [ $ 0030 l ] and [ $ 5 l ] lshift ] r> ] or ] >r
  [ $ 000f l ] and ] r> ] or ] >r
  [ $ 001f l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] ;

: in, [ $ b000 l ] 1reg5bitio ] ;
: out, ] swap [ $ b800 l ] 1reg5bitio ] ;

( two 4-bit registers )
( d r op )
( oooo oooo dddd rrrr )

: 2reg4bit ( d r op -- )
  ] >r
  [ $ 000f l ] and ] r> ] or ] >r
  [ $ 000f l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] ;

: muls, [ $ 0200 l ] 2reg4bit ] ;

( two 3-bit registers )
( d r op )
( oooo oooo oddd orrr )

: 2reg3bit ( d r op -- )
  ] >r
  [ $ 0007 l ] and ] r> ] or ] >r
  [ $ 0007 l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] ;

: mulsu, [ $ 0300 l ] 2reg3bit ] ;
: fmul, [ $ 0308 l ] 2reg3bit ] ;
: fmuls, [ $ 0380 l ] 2reg3bit ] ;
: fmulsu, [ $ 0388 l ] 2reg3bit ] ;

( relative )
( k op )
( oooo kkkk kkkk kkkk )

: relative ( k op -- )
  ] >r
  ] ihere ] - ] 1- [ $ 0fff l ] and ] r> ] or ] i, ] ;

: rcall, [ $ d000 l ] relative ] ;
: rjmp, [ $ c000 l ] relative ] ;

( one 5-bit register bit operation )
( d b op )
( oooo oood dddd obbb )

: 1reg5bitbit ( d b op -- )
  ] >r
  [ $ 0007 l ] and ] r> ] or ] >r
  [ $ 001f l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] ;

: bld, [ $ f800 l ] 1reg5bitbit ] ;
: bst, [ $ fa00 l ] 1reg5bitbit ] ;
: sbrc, [ $ fc00 l ] 1reg5bitbit ] ;
: sbrs, [ $ fe00 l ] 1reg5bitbit ] ;

( absolute )
( doesn't handle 22-bit addresses yet )
( k op )
( oooo oook kkkk oook )
( kkkk kkkk kkkk kkkk )

: absolute ( k op -- )
  ] i, ] i, ] ;

: call, [ $ 940e l ] absolute ] ;
: jmp, [ $ 940c l ] absolute ] ;

( one i/o register bit operation )
( a b op )
( oooo oooo aaaa abbb )

: 1iobit ( a b op -- )
  ] >r
  [ $ 0007 l ] and ] r> ] or ] >r
  [ $ 001f l ] and [ $ 3 l ] lshift ] r> ] or ] i, ] ;

: cbi, [ $ 9800 l ] 1iobit ] ;
: sbi, [ $ 9a00 l ] 1iobit ] ;
: sbic, [ $ 9900 l ] 1iobit ] ;
: sbis, [ $ 9b00 l ] 1iobit ] ;

( direct )
( k r op )
( oooo oood dddd oooo )
( kkkk kkkk kkkk kkkk )

: direct ( k r op -- )
  ] >r
  [ $ 001f l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] i, ] ;

: sts, [ $ 9200 l ] direct ] ;
: lds, ] swap [ $ 9000 l ] direct ] ;

( two words )
( d r op )
( oooo oooo dddd rrrr )

: 2words ( d r op -- )
  ] >r
  [ $ 001e l ] and [ $ 1 l ] rshift ] r> ] or ] >r
  [ $ 001e l ] and [ $ 3 l ] lshift ] r> ] or ] i, ] ;

: movw, [ $ 0100 l ] 2words ] ;

( indirect with displacement )
( d q op )
( ooqo qqod dddd oqqq )

: displacement ( d q op -- )
  ] >r
  ] dup [ $ 0020 l ] and [ $ 8 l ] lshift ] r> ] or ] >r
  ] dup [ $ 0018 l ] and [ $ 7 l ] lshift ] r> ] or ] >r
  [ $ 0007 l ] and ] r> ] or ] >r
  [ $ 001f l ] and [ $ 4 l ] lshift ] r> ] or ] i, ] ;

: lddy, [ $ 8008 l ] displacement ] ;
: lddz, [ $ 8000 l ] displacement ] ;
: stdy, ] swap [ $ 8208 l ] displacement ] ;
: stdz, ] swap [ $ 8200 l ] displacement ] ;

