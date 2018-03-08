( atmega16 )

$40 constant iosize
$400 constant ramsize
$2000 constant flashsize
$200 constant eepromsize
$40 constant pagesize

$20 constant twbr
$21 constant twsr
$22 constant twar
$23 constant twdr
$24 constant adcl
$25 constant adch
$26 constant adcsra
  7 constant aden
  6 constant adsc
  5 constant adate
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
  7 constant rxcie
  6 constant txcie
  5 constant udrie
  4 constant rxen
  3 constant txen
  2 constant ucsz2
  1 constant rxb8
  0 constant txb8
$2b constant ucsr0a
  7 constant rxc
  6 constant txc
  5 constant udre
  4 constant fe
  3 constant dor
  2 constant pe
  1 constant u2x
  0 constant mpcm
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
  7 constant ursel
  6 constant umsel
  5 constant upm1
  4 constant upm0
  3 constant usbs
  2 constant ucsz1
  1 constant ucsz0
  0 constant ucpol
$40 constant ubrr0h
$41 constant wdtcr
  4 constant wdtoe
  3 constant wde
  2 constant wdp2
  1 constant wdp1
  0 constant wdp0
$42 constant assr
  3 constant as2
  2 constant tcn2ub
  1 constant ocr2ub
  0 constant tcr2ub
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
  3 constant foc1a
  2 constant foc1b
  1 constant wgm11
  0 constant wgm10
$50 constant sfior
  7 constant adts2
  6 constant adts1
  5 constant adts0
  3 constant acme
  2 constant pud
  1 constant psr2
  0 constant psr10
$51 constant ocdr
$51 constant osccal
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
  6 constant isc2
  4 constant jtrf
  3 constant wdrf
  2 constant borf
  1 constant extrf
  0 constant porf
$55 constant mcucr
  7 constant sm2
  6 constant se
  5 constant sm1
  4 constant sm0
  3 constant isc11
  2 constant isc10
  1 constant isc01
  0 constant isc00
$56 constant twcr
  7 constant twint
  6 constant twea
  5 constant twsta
  4 constant twsto
  3 constant twwc
  2 constant twen
  0 constant twie
$57 constant spmcsr
  7 constant spmie
  6 constant rwwsb
  4 constant rwwsre
  3 constant blbset
  2 constant pgwrt
  1 constant pgers
  0 constant spmen
$58 constant tifr
  7 constant ocf2a tifr ocf2a 2constant ocf2a-bit
  6 constant tov2  tifr tov2  2constant tov2-bit
  5 constant icf1  tifr icf1  2constant icf1-bit
  4 constant ocf1a tifr ocf1a 2constant ocf1a-bit
  3 constant ocf1b tifr ocf1b 2constant ocf1b-bit
  2 constant tov1  tifr tov1  2constant tov1-bit
  1 constant ocf0a tifr ocf0a 2constant ocf0a-bit
  0 constant tov0  tifr tov0  2constant tov0-bit
$59 constant timsk
  7 constant ocie2a timsk ocie2a 2constant ocie2a-bit
  6 constant toie2  timsk toie2  2constant toie2-bit
  5 constant icie1  timsk icie1  2constant icie1-bit
  4 constant ocie1a timsk ocie1a 2constant ocie1a-bit
  3 constant ocie1b timsk ocie1b 2constant ocie1b-bit
  2 constant toie1  timsk toie1  2constant toie1-bit
  1 constant ocie0a timsk ocie0a 2constant ocie0a-bit
  0 constant toie0  timsk toie0  2constant toie0-bit
$5a constant gifr
  7 constant intf1
  6 constant intf0
  5 constant intf2
$5b constant gicr
  7 constant int1
  6 constant int0
  5 constant int2
  1 constant ivsel
  0 constant ivce
$5c constant ocr0a
$5d constant spl
$5e constant sph
$5f constant sreg

( spi pins )
ddrb 4 2constant ss-ddr
ddrb 7 2constant sck-ddr
ddrb 5 2constant mosi-ddr
ddrb 6 2constant miso-ddr

( interrupt vectors )
$00 constant reset
$02 constant external_interrupt_0
$04 constant external_interrupt_1
$06 constant timer2_compare_a
$08 constant timer2_overflow
$0a constant timer1_capture
$0c constant timer1_compare_a
$0e constant timer1_compare_b
$10 constant timer1_overflow
$12 constant timer0_overflow
$14 constant spi_stc
$16 constant usart0_rxc
$18 constant usart0_udre
$1a constant usart0_txc
$1c constant adc
$1e constant eeprom_ready
$20 constant analog_comparator
$22 constant twi
$24 constant external_interrupt_2
$26 constant timer0_compare_a
$28 constant spm_ready

$2a constant start

