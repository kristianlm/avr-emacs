( gpio )

[ifdef] pina  s" pina"  link, pina  const, [then]
[ifdef] ddra  s" ddra"  link, ddra  const, [then]
[ifdef] porta s" porta" link, porta const, [then]

[ifdef] pinb  s" pinb"  link, pinb  const, [then]
[ifdef] ddrb  s" ddrb"  link, ddrb  const, [then]
[ifdef] portb s" portb" link, portb const, [then]

[ifdef] pinc  s" pinc"  link, pinc  const, [then]
[ifdef] ddrc  s" ddrc"  link, ddrc  const, [then]
[ifdef] portc s" portc" link, portc const, [then]

[ifdef] pind  s" pind"  link, pind  const, [then]
[ifdef] ddrd  s" ddrd"  link, ddrd  const, [then]
[ifdef] portd s" portd" link, portd const, [then]

[ifdef] pine  s" pine"  link, pine  const, [then]
[ifdef] ddre  s" ddre"  link, ddre  const, [then]
[ifdef] porte s" porte" link, porte const, [then]

[ifdef] pinf  s" pinf"  link, pinf  const, [then]
[ifdef] ddrf  s" ddrf"  link, ddrf  const, [then]
[ifdef] portf s" portf" link, portf const, [then]

[ifdef] ping  s" ping"  link, ping  const, [then]
[ifdef] ddrg  s" ddrg"  link, ddrg  const, [then]
[ifdef] portg s" portg" link, portg const, [then]

[ifdef] external_interrupt_0
    s" 'ei0" link, there constant &'ei0 02 var,
    &'ei0 external_interrupt_0 ramvector
[then]

[ifdef] external_interrupt_1
    s" 'ei1" link, there constant &'ei1 02 var,
    &'ei1 external_interrupt_1 ramvector
[then]

[ifdef] pin_change_interrupt_0
    s" 'pci0" link, there constant &'pci0 02 var,
    &'pci0 pin_change_interrupt_0 ramvector
[then]

[ifdef] pin_change_interrupt_1
    s" 'pci1" link, there constant &'pci1 02 var,
    &'pci1 pin_change_interrupt_1 ramvector
[then]

[ifdef] pin_change_interrupt_2
    s" 'pci2" link, there constant &'pci2 02 var,
    &'pci2 pin_change_interrupt_2 ramvector
[then]

