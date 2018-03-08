( usb )

[ifdef] uhwcon

( usb modes )

s" usb-host" link, ( -- )
  uhwcon zero store
  ret,

s" usb-device" link, ( -- )
  uhwcon uimod 2^ load
  ret,

s" usb-uid" link, ( -- )
  uhwcon uide 2^ load
  ret,

( enable )
s" usb" link, ( -- )
  temp0 usbcon fetch
  temp0 usbe 2^ otgpade 2^ or ori,
  usbcon temp0 store
  uhwcon uvrege set-bit
  ret,

( disable )
s" /usb" link, ( -- )
  temp0 usbcon fetch
  temp0 usbe 2^ otgpade 2^ or invert andi,
  usbcon temp0 store
  uhwcon uvrege clear-bit
  ret,

( freeze )
s" usb-freeze" link, ( -- )
  usbcon frzclk set-bit
  ret,

( thaw )
s" usb-thaw" link, ( -- )
  usbcon frzclk clear-bit
  ret,

( vbus status )
s" usb-vbus?" link, ( -- f )
  dup,
  tos zero movw,
  usbsta vbus skip-bit-clear
    tos 1 sbiw,
  ret,

[then]

