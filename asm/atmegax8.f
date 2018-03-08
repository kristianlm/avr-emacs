( atmegax8 )

$23 constant pinb
$24 constant ddrb
$25 constant portb
$26 constant pinc
$27 constant ddrc
$28 constant portc
$29 constant pind
$2a constant ddrd
$2b constant portd
$35 constant tifr0
  2 constant ocf0b tifr0 ocf0b 2constant ocf0b-bit
  1 constant ocf0a tifr0 ocf0a 2constant ocf0a-bit
  0 constant tov0  tifr0 tov0  2constant tov0-bit
$36 constant tifr1
  5 constant icf1  tifr1 icf1  2constant icf1-bit
  2 constant ocf1b tifr1 ocf1b 2constant ocf1b-bit
  1 constant ocf1a tifr1 ocf1a 2constant ocf1a-bit
  0 constant tov1  tifr1 tov1  2constant tov1-bit
$37 constant tifr2
  2 constant ocf2b tifr2 ocf2b 2constant ocf2b-bit
  1 constant ocf2a tifr2 ocf2a 2constant ocf2a-bit
  0 constant tov2  tifr2 tov2  2constant tov2-bit
$3b constant pcifr
  2 constant pcif2
  1 constant pcif1
  0 constant pcif0
$3c constant eifr
  1 constant intf1
  0 constant intf0
$3d constant eimsk
  1 constant int1
  0 constant int0
$3e constant gpior0
$3f constant eecr
  5 constant eepm1
  4 constant eepm0
  3 constant eerie
  2 constant eempe 2 constant eemwe
  1 constant eepe  1 constant eewe
  0 constant eere
$40 constant eedr
$41 constant eearl
$42 constant eearh
$43 constant gtccr
  7 constant tsm
  1 constant psrasy
  0 constant psrsync
$44 constant tccr0a
  7 constant com0a1
  6 constant com0a0
  5 constant com0b1
  4 constant com0b0
  1 constant wgm01
  0 constant wgm00
$45 constant tccr0b
  7 constant foc0a
  6 constant foc0b
  3 constant wgm02
  2 constant cs02
  1 constant cs01
  0 constant cs00
$46 constant tcnt0
$47 constant ocr0a
$48 constant ocr0b
$4a constant gpior1
$4b constant gpior2
$4c constant spcr
  7 constant spie
  6 constant spe
  5 constant dord
  4 constant mstr
  3 constant cpol
  2 constant cpha
  1 constant spr1
  0 constant spr0
$4d constant spsr
  7 constant spif
  6 constant wcol
  0 constant spi2x
$4e constant spdr
$50 constant acsr
  7 constant acd
  6 constant acbg
  5 constant aco
  4 constant aci
  3 constant acie
  2 constant acic
  1 constant acis1
  0 constant acis0
$53 constant smcr
  3 constant sm2
  2 constant sm1
  1 constant sm0
  0 constant se
$54 constant mcusr
  3 constant wdrf
  2 constant borf
  1 constant extrf
  0 constant porf
$55 constant mcucr
  4 constant pud
  1 constant ivsel
  0 constant ivce
$57 constant spmcsr
  7 constant spmie
  6 constant rwwsb
  4 constant rwwsre
  3 constant blbset
  2 constant pgwrt
  1 constant pgers
  0 constant selfprgen 0 constant spmen
$5d constant spl
$5e constant sph
$5f constant sreg
$60 constant wdtcsr
  7 constant wdif
  6 constant wdie
  5 constant wdp3
  4 constant wdce
  3 constant wde
  2 constant wdp2
  1 constant wdp1
  0 constant wdp0
$61 constant clkpr
  7 constant clkpce
  3 constant clkps3
  2 constant clkps2
  1 constant clkps1
  0 constant clkps0
$64 constant prr
  7 constant prtwi
  6 constant prtim2
  5 constant prtim0
  3 constant prtim1
  2 constant prspi
  1 constant prusart0
  0 constant pradc
$66 constant osccal
$68 constant pcicr
  2 constant pcie2
  1 constant pcie1
  0 constant pcie0
$69 constant eicra
  3 constant isc11
  2 constant isc10
  1 constant isc01
  0 constant isc00
$6b constant pcmsk0
  7 constant pcint7
  6 constant pcint6
  5 constant pcint5
  4 constant pcint4
  3 constant pcint3
  2 constant pcint2
  1 constant pcint1
  0 constant pcint0
$6c constant pcmsk1
  6 constant pcint14
  5 constant pcint13
  4 constant pcint12
  3 constant pcint11
  2 constant pcint10
  1 constant pcint9
  0 constant pcint8
$6d constant pcmsk2
  7 constant pcint23
  6 constant pcint22
  5 constant pcint21
  4 constant pcint20
  3 constant pcint19
  2 constant pcint18
  1 constant pcint17
  0 constant pcint16
$6e constant timsk0
  2 constant ocie0b timsk0 ocie0b 2constant ocie0b-bit
  1 constant ocie0a timsk0 ocie0a 2constant ocie0a-bit
  0 constant toie0  timsk0 toie0  2constant toie0-bit
$6f constant timsk1
  5 constant icie1  timsk1 icie1  2constant icie1-bit
  2 constant ocie1b timsk1 ocie1b 2constant ocie1b-bit
  1 constant ocie1a timsk1 ocie1a 2constant ocie1a-bit
  0 constant toie1  timsk1 toie1  2constant toie1-bit
$70 constant timsk2
  2 constant ocie2b timsk2 ocie2b 2constant ocie2b-bit
  1 constant ocie2a timsk2 ocie2a 2constant ocie2a-bit
  0 constant toie2  timsk2 toie2  2constant toie2-bit
$78 constant adcl
$79 constant adch
$7a constant adcsra
  7 constant aden
  6 constant adsc
  5 constant adate
  4 constant adif
  3 constant adie
  2 constant adps2
  1 constant adps1
  0 constant adps0
$7b constant adcsrb
  6 constant acme
  2 constant adts2
  1 constant adts1
  0 constant adts0
$7c constant admux
  7 constant refs1
  6 constant refs0
  5 constant adlar
  3 constant mux3
  2 constant mux2
  1 constant mux1
  0 constant mux0
$7e constant didr0
  5 constant adc5d
  4 constant adc4d
  3 constant adc3d
  2 constant adc2d
  1 constant adc1d
  0 constant adc0d
$7f constant didr1
  1 constant ain1d
  0 constant ain0d
$80 constant tccr1a
  7 constant com1a1
  6 constant com1a0
  5 constant com1b1
  4 constant com1b0
  1 constant wgm11
  0 constant wgm10
$81 constant tccr1b
  7 constant icnc1
  6 constant ices1
  4 constant wgm13
  3 constant wgm12
  2 constant cs12
  1 constant cs11
  0 constant cs10
$82 constant tccr1c
  7 constant foc1a
  6 constant foc1b
$84 constant tcnt1l
$85 constant tcnt1h
$86 constant icr1l
$87 constant icr1h
$88 constant ocr1al
$89 constant ocr1ah
$8a constant ocr1bl
$8b constant ocr1bh
$b0 constant tccr2a
  7 constant com2a1
  6 constant com2a0
  5 constant com2b1
  4 constant com2b0
  1 constant wgm21
  0 constant wgm20
$b1 constant tccr2b
  7 constant foc2a
  6 constant foc2b
  3 constant wgm22
  2 constant cs22
  1 constant cs21
  0 constant cs20
$b2 constant tcnt2
$b3 constant ocr2a
$b4 constant ocr2b
$b6 constant assr
  6 constant exclk
  5 constant as2
  4 constant tcn2ub
  3 constant ocr2aub
  2 constant ocr2bub
  1 constant tcr2aub
  0 constant tcr2bub
$b8 constant twbr
$b9 constant twsr
  7 constant tws7
  6 constant tws6
  5 constant tws5
  4 constant tws4
  3 constant tws3
  1 constant twps1
  0 constant twps0
$ba constant twar
  7 constant twa6
  6 constant twa5
  5 constant twa4
  4 constant twa3
  3 constant twa2
  2 constant twa1
  1 constant twa0
  0 constant twgce
$bb constant twdr
$bc constant twcr
  7 constant twint
  6 constant twea
  5 constant twsta
  4 constant twsto
  3 constant twwc
  2 constant twen
  0 constant twie
$bd constant twamr
  7 constant twam6
  6 constant twam5
  5 constant twam4
  4 constant twam3
  3 constant twam2
  2 constant twam1
  1 constant twam0
$c0 constant ucsr0a
  7 constant rxc
  6 constant txc
  5 constant udre
  4 constant fe
  3 constant dor
  2 constant upe
  1 constant u2x
  0 constant mpcm
$c1 constant ucsr0b
  7 constant rxcie
  6 constant txcie
  5 constant udrie
  4 constant rxen
  3 constant txen
  2 constant ucsz2
  1 constant rxb8
  0 constant txb8
$c2 constant ucsr0c
  7 constant umsel1
  6 constant umsel0
  5 constant upm1
  4 constant upm0
  3 constant usbs
  2 constant ucsz1 2 constant udord0
  1 constant ucsz0 1 constant ucpha0
  0 constant ucpol
$c4 constant ubrr0l
$c5 constant ubrr0h
$c6 constant udr0

( spi pins )
ddrb 2 2constant ss-ddr
ddrb 5 2constant sck-ddr
ddrb 3 2constant mosi-ddr
ddrb 4 2constant miso-ddr

( interrupt vectors )
$00 vectorsize * constant reset
$01 vectorsize * constant external_interrupt_0
$02 vectorsize * constant external_interrupt_1
$03 vectorsize * constant pin_change_interrupt_0
$04 vectorsize * constant pin_change_interrupt_1
$05 vectorsize * constant pin_change_interrupt_2
$06 vectorsize * constant wdt
$07 vectorsize * constant timer2_compare_a
$08 vectorsize * constant timer2_compare_b
$09 vectorsize * constant timer2_overflow
$0a vectorsize * constant timer1_capture
$0b vectorsize * constant timer1_compare_a
$0c vectorsize * constant timer1_compare_b
$0d vectorsize * constant timer1_overflow
$0e vectorsize * constant timer0_compare_a
$0f vectorsize * constant timer0_compare_b
$10 vectorsize * constant timer0_overflow
$11 vectorsize * constant spi_stc
$12 vectorsize * constant usart0_rxc
$13 vectorsize * constant usart0_udre
$14 vectorsize * constant usart0_txc
$15 vectorsize * constant adc
$16 vectorsize * constant eeprom_ready
$17 vectorsize * constant analog_comparator
$18 vectorsize * constant twi
$19 vectorsize * constant spm_ready

$1a vectorsize * constant start

