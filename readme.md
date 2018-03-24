
# examples

## tasks

```forth
( silly busy-waiting task )
: annoying ." annoying" ] cr [ $ ffff l ] for ] pause ] next ] annoying ] ;

( reserve RAM for task)
$ 40 var task.annoying

\ mytask $ 100 $ ff fill
\ mytask $ fff0 and $ 101 dump

' annoying $ 20 $ 20 task.annoying task-init ( now task.annoying should be ready )

task.annoying task-queue ( next pause will now take us to annoying )
( watch it print while prompt is still alive )
task.annoying task-dequeue ( mytask should no longer be called on pause )
```

## `if` (just checks the `z` flag)

    : tst ] 0? ] if ." nonzero " ] ; ] then ." zero " ] ;

## `=if`

    : equal? ] ?? ] drop ] drop ] =if ." yes " ] ; ] then ." no " ] ;

## `+!`

    > 2 var K
    2 var K ok
    > K @ h.
    K @ h. 3433  ok
    > 0 K ! h.
    0 K ! h. 0100  ok
    > K @ h.
    K @ h. 0000  ok
    > 1 K +! h.
    > $ abba 1 K +! h.
    $ abba 1 K +! h. abba  ok
    > K @ h.
    K @ h. 0002  ok
    > $ abba 4 K +! h.
    $ abba 4 K +! h. abba  ok
    > K @ h.
    K @ h. 0006  ok

## `word`

    > : echo" [ $ 22 l ] word ] type ] ;
    : echo" [ $ 22 l ] word ] type ] ; ok
    > $ beef echo" testing 123" h.
    $ beef echo" testing 123" h. testing 123beef  ok

# words

```
on on off idump idump8 idump1 dump dump10
dump1 dlerp i2@ lerp range um/ off on
drshift 1drshift 1rshift t2/ d2/ 2/. dlshift t2*
d2* 2*. ut* t+ +. clear set ll
stdz, stdy, lddz, lddy, displacement movw, 2words lds,
sts, direct sbis, sbic, sbi, cbi, 1iobit jmp,
call, absolute sbrs, sbrc, bst, bld, 1reg5bitbit rjmp,
rcall, relative fmulsu, fmuls, fmul, mulsu, 2reg3bit muls,
2reg4bit out, in, 1reg5bitio sei, set, seh, ses,
sev, sen, sez, sec, bsei, cli, clt, clh,
cls, clv, cln, clz, clc, bclr, sregbit brie,
brts, brhs, brli, brvs, brmi, breq, brlo, brcs,
brbs, brid, brtc, brhc, brge, brvc, brpl, brne,
brsh, brcc, brbc, branch sbiw, adiw, 1word2bitimm ser,
sbr, cbr, subi, sbci, ori, ldi, cpi, andi,
1reg4bitimm swap, st-z, stz+, stz, st-y, sty+, sty,
st-x, stx+, stx, ror, push, pop, neg, lsr,
lpmz+, lpmz, ld-z, ldz+, ldz, ld-y, ldy+, ldy,
ld-x, ldx+, ldx, inc, elpmz+, elpmz, dec, com,
asr, 1reg5bit tsi, rol, lsl, clr, sub, sbc,
or, mul, mov, eor, cpse, cpc, cp, and,
add, adc, 2reg5bit wdr, spm, sleep, reti, ret,
nop, lpm, ijmp, icall, espm, elpm, eijmp, eicall,
break, ibit tbit hbit sbit vbit nbit zbit
cbit temp0 temp1 temp2 temp3 tos tosl tosh
xx xl xh yy yl yh zz zl zh

within wait task-dequeue task-prev task-prev' task-next task-queue task-init
macros words words' b. h. next' u*/ u*/mod
umod u/ u/mod */ */mod mod / /mod
m/mod u* * extend dnegate d1+ dinvert d-
d+ 2over 2swap 2dup 2drop 2! 2@ !-
c!- @- c@- !+ c!+ @+ c@+ intoff
inton int: -, ntz 2^ negate 2/ 2*
1- 1+ con evar var -1 4 2
1 0 high low ( )
[ dup drop int> >int single cold doit
mark empty

( gpio )
portd ddrd pind portc ddrc pinc portb ddrb pinb

( twi )
twistat twirxn twirx twitx twistop twistart twiwait /twi twi

( spi )
spirx spitx spix spidata
spislave spimaster spicol spiorder lsb-first msb-first /spi spi
spiclk spiclk/32 spiclk/8 spiclk/2 spiclk/128 spiclk/64 spiclk/16 spiclk/4
spimode spiflag spiint

ticks+ ticks

( timer 2) t2comb 't2ocb t2ocbflag t2ocbint t2ocb t2coma 't2oca
t2ocaflag t2ocaint t2oca t2wgm t2clk 't2ovf t2ovfflag t2ovfint t2cnt

( timer 1) t1ice t1icf 't1ic t1icflag t1icint t1ic t1comb 't1ocb
t1ocbflag t1ocbint t1ocb t1coma 't1oca t1ocaflag t1ocaint t1oca t1wgm
t1clk 't1ovf t1ovfflag t1ovfint t1cnt

( timer 0) t0comb 't0ocb t0ocbflag t0ocbint t0ocb t0coma 't0oca
t0ocaflag t0ocaint t0oca t0wgm t0clk 't0ovf t0ovfflag t0ovfint t0cnt
ice-rise ice-fall

( comare )
com-set com-clear com-toggle com-normal

wgm-fast-oc wgm-fast-ic wgm-ctc-ic wgm-pwm-oc
wgm-pwm-ic wgm-correct-oc wgm-correct-ic
wgm-fast10 wgm-fast9 wgm-fast8 wgm-pwm10 wgm-pwm9 wgm-pwm8
wgm-ctc-oc wgm-normal

aclk/1024 aclk/256 aclk/128 aclk/64 aclk/32 aclk/8 aclk/1 aclk-none
clk-ext-rise clk-ext-fall clk/1024 clk/256 clk/64 clk/8 clk/1 clk-none

adcdid adcdata adcwait adcstart /adc adc 'adc adcint
adcflag adcclk adcclk/128 adcclk/64 adcclk/32 adcclk/16 adcclk/8 adcclk/4
adcclk/2 adcjust just-left just-right adcmux
adcref ref-int ref-avcc ref-aref

rx0? rx0 tx0? tx0 baud0 /usart0 usart0

ver $ 10* # digit ." "
imm ?lit l c ] : ;
,xt macro forth ' go find @execute execute
accept word x" itype
itype' type space cr
emit key e, i, , ehere ihere here
eallot iallot allot bl it ~mlink ~link ~edp
~idp ~dp ints 'emit 'key interp list source
edp idp dp dict mlink link >in wordbuf
tib const i! pageload spmrww spmwrite spmerase spmbuf
dospm i@ f! f@ jump ?? umax umin
um/mod m* um* +! + -! - r@
r> >r e@ ec@ e! ec! me pause
fill cmove> cmove c@ @ c! ! ones
rshift lshift xor >< or and swap -rot
rot over tuck nip ok
```

### `digit` ( c -- n )

n is ascii value of c

### `#` ( x -- x')


print the uppermose digit of x x' becomes digits shifted one left
    
    > $ 1234 # # # # 1234 ok

### `10*` ( x1 -- x2 )

x2 is x1 shifted left 1 hex digit

### `$` ( -- x)

read upcoming 16bit hex value. you'll need this in front of your
numerical input.

### `ver` ( -- )

## drivers

TODO
 
## startup

### `empty`
### `mark`
doit
cold
single
>int
int>

print version info serial
