( atmega128 )

$e0 constant iosize
$1000 constant ramsize
$10000 constant flashsize
$1000 constant eepromsize
$80 constant pagesize

$20 constant pinf
$21 constant pine
$22 constant ddre
$23 constant porte
$24 constant adcl
$25 constant adch
$26 constant adcsra
  7 constant aden
  6 constant adsc
  5 constant adfr
  4 constant adif
  3 constant adie
  2 constant adps2
  1 constant adps1
  0 constant adps0
$27 constant admux
  7 constant refs1
  6 constant refs0
  5 constant adlar
  4 constant mux4
  3 constant mux3
  2 constant mux2
  1 constant mux1
  0 constant mux0
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
$40 constant sfior
  7 constant tsm
  3 constant acme
  2 constant pud
  1 constant psr0
  0 constant psr321
$41 constant wdtcr
  4 constant wdce
  3 constant wde
  2 constant wdp2
  1 constant wdp1
  0 constant wdp0
$42 constant ocdr
$43 constant ocr2a
$44 constant tcnt2
$45 constant tccr2a
  7 constant foc2
  6 constant wgm20
  5 constant com21
  4 constant com20
  3 constant wgm21
  2 constant cs22
  1 constant cs21
  0 constant cs20
$46 constant icr1l
$47 constant icr1h
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
  3 constant com1c1
  2 constant com1c0
  1 constant wgm11
  0 constant wgm10
$50 constant assr
  3 constant as0
  2 constant tcn0ub
  1 constant ocr0ub
  0 constant tcr0ub
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
  3 constant sm0
  2 constant sm2
  1 constant ivsel
  0 constant ivce
$56 constant tifr
  7 constant ocf2a tifr ocf2a 2constant ocf2a-bit
  6 constant tov2  tifr tov2  2constant tov2-bit
  5 constant icf1  tifr icf1  2constant icf1-bit
  4 constant ocf1a tifr ocf1a 2constant ocf1a-bit
  3 constant ocf1b tifr ocf1b 2constant ocf1b-bit
  2 constant tov1  tifr tov1  2constant tov1-bit
  1 constant ocf0a tifr ocf0a 2constant ocf0a-bit
  0 constant tov0  tifr tov0  2constant tov0-bit
$57 constant timsk
  7 constant ocie2a timsk ocie2a 2constant ocie2a-bit
  6 constant toie2  timsk toie2  2constant toie2-bit
  5 constant icie1  timsk icie1  2constant icie1-bit
  4 constant ocie1a timsk ocie1a 2constant ocie1a-bit
  3 constant ocie1b timsk ocie1b 2constant ocie1b-bit
  2 constant toie1  timsk toie1  2constant toie1-bit
  1 constant ocie0a timsk ocie0a 2constant ocie0a-bit
  0 constant toie0  timsk toie0  2constant toie0-bit
$58 constant eifr
$59 constant eimsk
$5a constant eicrb
  7 constant isc71
  6 constant isc70
  5 constant isc61
  4 constant isc60
  3 constant isc51
  2 constant isc50
  1 constant isc41
  0 constant isc40
$5b constant rampz
$5c constant xdiv
  7 constant xdiven
  6 constant xdiv6
  5 constant xdiv5
  4 constant xdiv4
  3 constant xdiv3
  2 constant xdiv2
  1 constant xdiv1
  0 constant xdiv0
$5d constant spl
$5e constant sph
$5f constant sreg
$61 constant ddrf
$62 constant portf
$63 constant ping
$64 constant ddrg
$65 constant portg
$68 constant spmcsr
  7 constant spmie
  6 constant rwwsb
  4 constant rwwsre
  3 constant blbset
  2 constant pgwrt
  1 constant pgers
  0 constant spmen
$6a constant eicra
  7 constant isc31
  6 constant isc30
  5 constant isc21
  4 constant isc20
  3 constant isc11
  2 constant isc10
  1 constant isc01
  0 constant isc00
$6c constant xmcrb
  7 constant xmbk
  2 constant xmm2
  1 constant xmm1
  0 constant xmm0
$6d constant xmcra
  6 constant srl2
  5 constant srl1
  4 constant srl0
  3 constant srw01
  2 constant srw00
  1 constant srw11
$6f constant osccal
$70 constant twbr
$71 constant twsr
$72 constant twar
$73 constant twdr
$74 constant twcr
  7 constant twint
  6 constant twea
  5 constant twsta
  4 constant twsto
  3 constant twwc
  2 constant twen
  0 constant twie
$78 constant ocr1cl
$79 constant ocr1ch
$7a constant tccr1c
  7 constant foc1a
  6 constant foc1b
  5 constant foc1c
$7c constant etifr
  5 constant icf3  etifr icf3  2constant icf3-bit
  4 constant ocf3a etifr ocf3a 2constant ocf3a-bit
  3 constant ocf3b etifr ocf3b 2constant ocf3b-bit
  2 constant tov3  etifr tov3  2constant tov3-bit
  1 constant ocf3c etifr ocf3c 2constant ocf3c-bit
  0 constant ocf1c etifr ocf1c 2constant ocf1c-bit
$7d constant etimsk
  5 constant icie3  etimsk icie3  2constant icie3-bit
  4 constant ocie3a etimsk ocie3a 2constant ocie3a-bit
  3 constant ocie3b etimsk ocie3b 2constant ocie3b-bit
  2 constant toie3  etimsk toie3  2constant toie3-bit
  1 constant ocie3c etimsk ocie3c 2constant ocie3c-bit
  0 constant ocie1c etimsk ocie1c 2constant ocie1c-bit
$80 constant icr3l
$81 constant icr3h
$82 constant ocr3cl
$83 constant ocr3ch
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
  3 constant com3c1
  2 constant com3c0
  1 constant wgm31
  0 constant wgm30
$8c constant tccr3c
  7 constant foc3a
  6 constant foc3b
  5 constant foc3c

( usart )

  ( ucsrc )
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

$90 constant ubrr0h
$95 constant ucsr0c
$98 constant ubrr1h
$99 constant ubrr1l
$9a constant ucsr1b
$9b constant ucsr1a
$9c constant udr1
$9d constant ucsr1c

( spi pins )
ddrb 0 2constant ss-ddr
ddrb 1 2constant sck-ddr
ddrb 2 2constant mosi-ddr
ddrb 3 2constant miso-ddr

( interrupt vectors )
$00 constant reset
$02 constant external_interrupt_0
$04 constant external_interrupt_1
$06 constant external_interrupt_2
$08 constant external_interrupt_3
$0a constant external_interrupt_4
$0c constant external_interrupt_5
$0e constant external_interrupt_6
$10 constant external_interrupt_7
$12 constant timer2_compare_a
$14 constant timer2_overflow
$16 constant timer1_capture
$18 constant timer1_compare_a
$1a constant timer1_compare_b
$1c constant timer1_overflow
$1e constant timer0_compare_a
$20 constant timer0_overflow
$22 constant spi_stc
$24 constant usart0_rxc
$26 constant usart0_udre
$28 constant usart0_txc
$2a constant adc
$2c constant eeprom_ready
$2e constant analog_comparator
$30 constant timer1_compare_c
$32 constant timer3_capture
$34 constant timer3_compare_a
$36 constant timer3_compare_b
$38 constant timer3_compare_c
$3a constant timer3_overflow
$3c constant usart1_rxc
$3e constant usart1_udre
$40 constant usart1_txc
$42 constant twi
$44 constant spm_ready

$46 constant start

