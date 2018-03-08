( atmega162 )

$e0 constant iosize
$400 constant ramsize
$2000 constant flashsize
$200 constant eepromsize
$40 constant pagesize

( usart )

  ( ucsrc )
  7 constant ursel
  6 constant umsel
  5 constant upm1
  4 constant upm0
  3 constant usbs
  2 constant ucsz1
  1 constant ucsz0
  0 constant ucpol

  ( ucsrb )
  7 constant rxcie
  6 constant txcie
  5 constant udrie
  4 constant rxen
  3 constant txen
  2 constant ucsz2
  1 constant rxb8
  0 constant txb8

  ( ucsra )
  7 constant rxc
  6 constant txc
  5 constant udre
  4 constant fe
  3 constant dor
  2 constant upe
  1 constant u2x
  0 constant mpcm

$20 constant ubrr1l
$21 constant ucsr1b
$22 constant ucsr1a
$23 constant udr1
$24 constant ocdr
$24 constant osccal
$25 constant pine
$26 constant ddre
$27 constant porte
$28 constant acsr
  7 constant acd
  6 constant acbg
  5 constant aco
  4 constant aci
  3 constant acie
  2 constant acic
  1 constant acis1
  0 constant acis0
$29 constant ubrr0l
$2a constant ucsr0b
$2b constant ucsr0a
$2c constant udr0
$2d constant spcr
  7 constant spie
  6 constant spe
  5 constant dord
  4 constant mstr
  3 constant cpol
  2 constant cpha
  1 constant spr1
  0 constant spr0
$2e constant spsr
  7 constant spif
  6 constant wcol
  0 constant spi2x
$2f constant spdr
$30 constant pind
$31 constant ddrd
$32 constant portd
$33 constant pinc
$34 constant ddrc
$35 constant portc
$36 constant pinb
$37 constant ddrb
$38 constant portb
$39 constant pina
$3a constant ddra
$3b constant porta
$3c constant eecr
  3 constant eerie
  2 constant eemwe
  1 constant eewe
  0 constant eere
$3d constant eedr
$3e constant eearl
$3f constant eearh
$40 constant ucsr0c
$40 constant ubrr0h
$41 constant wdtcr
  4 constant wdce
  3 constant wde
  2 constant wdp2
  1 constant wdp1
  0 constant wdp0
$42 constant ocr2a
$43 constant tcnt2
$44 constant icr1l
$45 constant icr1h
$46 constant assr
  3 constant as2
  2 constant tcn2ub
  1 constant ocr2ub
  0 constant tcr2ub
$47 constant tccr2a
  7 constant foc2
  6 constant wgm20
  5 constant com21
  4 constant com20
  3 constant wgm21
  2 constant cs22
  1 constant cs21
  0 constant cs20
$48 constant ocr1bl
$49 constant ocr1bh
$4a constant ocr1al
$4b constant ocr1ah
$4c constant tcnt1l
$4d constant tcnt1h
$4e constant tccr1b
  7 constant icnc1
  6 constant ices1
  4 constant wgm13
  3 constant wgm12
  2 constant cs12
  1 constant cs11
  0 constant cs10
$4f constant tccr1a
  7 constant com1a1
  6 constant com1a0
  5 constant com1b1
  4 constant com1b0
  3 constant foc1a
  2 constant foc1b
  1 constant wgm11
  0 constant wgm10
$50 constant sfior
  7 constant tsm
  6 constant xmbk
  5 constant xmm2
  4 constant xmm1
  3 constant xmm0
  2 constant pud
  1 constant psr2
  0 constant psr310
$51 constant ocr0a
$52 constant tcnt0
$53 constant tccr0a
  7 constant foc0
  6 constant wgm00
  5 constant com01
  4 constant com00
  3 constant wgm01
  2 constant cs02
  1 constant cs01
  0 constant cs00
$54 constant mcucsr
  7 constant jtd
  5 constant sm2
  4 constant jtrf
  3 constant wdrf
  2 constant borf
  1 constant extrf
  0 constant porf
$55 constant mcucr
  7 constant sre
  6 constant srw10
  5 constant se
  4 constant sm1
  3 constant isc11
  2 constant isc10
  1 constant isc01
  0 constant isc00
$56 constant emcucr
  7 constant sm0
  6 constant srl2
  5 constant srl1
  4 constant srl0
  3 constant srw01
  2 constant srw00
  1 constant srw11
  0 constant isc2
$57 constant spmcsr
  7 constant spmie
  6 constant rwwsb
  4 constant rwwsre
  3 constant blbset
  2 constant pgwrt
  1 constant pgers
  0 constant spmen
$58 constant tifr
  7 constant tov1  tifr tov1  2constant tov1-bit
  6 constant ocf1a tifr ocf1a 2constant ocf1a-bit
  5 constant ocf1b tifr ocf1b 2constant ocf1b-bit
  4 constant ocf2a tifr ocf2a 2constant ocf2a-bit
  3 constant icf1  tifr icf1  2constant icf1-bit
  2 constant tov2  tifr tov2  2constant tov2-bit
  1 constant tov0  tifr tov0  2constant tov0-bit
  0 constant ocf0a tifr ocf0a 2constant ocf0a-bit
$59 constant timsk
  7 constant toie1  timsk toie1  2constant toie1-bit
  6 constant ocie1a timsk ocie1a 2constant ocie1a-bit
  5 constant ocie1b timsk ocie1b 2constant ocie1b-bit
  4 constant ocie2a timsk ocie2a 2constant ocie2a-bit
  3 constant icie1  timsk icie1  2constant icie1-bit
  2 constant toie2  timsk toie2  2constant toie2-bit
  1 constant toie0  timsk toie0  2constant toie0-bit
  0 constant ocie0a timsk ocie0a 2constant ocie0a-bit
$5a constant gifr
  7 constant intf1
  6 constant intf0
  5 constant intf2
  4 constant pcif1
  3 constant pcif0
$5b constant gicr
  7 constant int1
  6 constant int0
  5 constant int2
  4 constant pcie1
  3 constant pcie0
  1 constant ivsel
  0 constant ivce
$5c constant ucsrc
$5c constant ubrr1h
$5d constant spl
$5e constant sph
$5f constant sreg
$61 constant clkpr
  7 constant clkpce
  3 constant clkps3
  2 constant clkps2
  1 constant clkps1
  0 constant clkps0
$6b constant pcmsk0
$6c constant pcmsk1
$7c constant etifr
  5 constant icf3  etifr icf3  2constant icf3-bit
  4 constant ocf3a etifr ocf3a 2constant ocf3a-bit
  3 constant ocf3b etifr ocf3b 2constant ocf3b-bit
  2 constant tov3  etifr tov3  2constant tov3-bit
$7d constant etimsk
  5 constant icie3  etimsk icie3  2constant icie3-bit
  4 constant ocie3a etimsk ocie3a 2constant ocie3a-bit
  3 constant ocie3b etimsk ocie3b 2constant ocie3b-bit
  2 constant toie3  etimsk toie3  2constant toie3-bit
$80 constant icr3l
$81 constant icr3h
$84 constant ocr3bl
$85 constant ocr3bh
$86 constant ocr3al
$87 constant ocr3ah
$88 constant tcnt3l
$89 constant tcnt3h
$8a constant tccr3b
  7 constant icnc3
  6 constant ices3
  4 constant wgm33
  3 constant wgm32
  2 constant cs32
  1 constant cs31
  0 constant cs30
$8b constant tccr3a
  7 constant com3a1
  6 constant com3a0
  5 constant com3b1
  4 constant com3b0
  3 constant foc3a
  2 constant foc3b
  1 constant wgm31
  0 constant wgm30

( spi pins )
ddrb 4 2constant ss-ddr
ddrb 7 2constant sck-ddr
ddrb 5 2constant mosi-ddr
ddrb 6 2constant miso-ddr

( interrupt vectors )
$00 constant reset
$02 constant external_interrupt_0
$04 constant external_interrupt_1
$06 constant external_interrupt_2
$08 constant pcint0
$0a constant pcint1
$0c constant timer3_capture
$0e constant timer3_compare_a
$10 constant timer3_compare_b
$12 constant timer3_overflow
$14 constant timer2_compare_a
$16 constant timer2_overflow
$18 constant timer1_capture
$1a constant timer1_compare_a
$1c constant timer1_compare_b
$1e constant timer1_overflow
$20 constant timer0_compare_a
$22 constant timer0_overflow
$24 constant spi_stc
$26 constant usart0_rxc
$28 constant usart1_rxc
$2a constant usart0_udre
$2c constant usart1_udre
$2e constant usart0_txc
$30 constant usart1_txc
$32 constant eeprom_ready
$34 constant analog_comparator
$36 constant spm_ready

$38 constant start

