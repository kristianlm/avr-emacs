( pll )

[ifdef] pllcsr

cpu_frequency #8000000 = [if]
  pllp1 2^ pllp0 2^ or constant pll_prescaler
[then]

cpu_frequency #16000000 = [if]
  device s" at90usb647" compare 0= [if]
    pllp2 2^ pllp1 2^ or constant pll_prescaler
  [then]
  device s" at90usb1287" compare 0= [if]
    pllp2 2^ pllp0 2^ or constant pll_prescaler
  [then]
[then]

( wait for pll lock )
label pll_wait
  begin,
    pllcsr plock skip-bit-clear
      ret,
    pause_ call
  again,

( enable pll )
s" pll" link, ( -- )
  pllcsr pll_prescaler plle 2^ or load
  pll_wait jump

( disable pll )
s" /pll" link, ( -- )
  pllcsr zero store
  ret,

[then]

