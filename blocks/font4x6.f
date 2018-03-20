( # counting starts at 0x20)

\ $ 0 >oled 0 >oled $ 7b >oled $ 00 >oled
\ $ 1010 1 lshift $ 3400 high imm or h.

\ push start of iallot on stack, and then keep it in fontstart
\ is this usually done with create? how should this be done with avrforth?

ihere $ 60 2* iallot : fontstart l ] ;
: glyphr1 ] imm ] swap [ $ 1 l ] lshift ] or ] ;
: >glyph ] swap ] over ] high ] glyphr1 ] -rot ] low ] glyphr1 ] swap ] ;
: glyphcreate [ $ 0 l [ $ 0 l ] ; ( initialized to blank)
: glyph! ( g0 g1 idx -- ) ] 2* ] fontstart ] + ] swap ] over ] i! ] 1+ ] i! ] ;
: glyph@ ( idx -- g0 g1 ) ] 2* ] fontstart ] + ] dup ] 1+ ] i@ ] swap ] i@ ] ;
: glyph>oled ] dup
    ] high ] >oled
    ] low  ] >oled ] dup
    ] high ] >oled
    ] low  ] >oled ] ;
: c>gi [ $ 20 l ] - [ $ 7f l ] and ] ;

: oled.emit ] c>gi ] glyph@ ] glyph>oled ] ;


glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 00 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 01 glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 02 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0111 >glyph
$ 0010 >glyph
$ 0111 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 03 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0111 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0001 >glyph
$ 0111 >glyph
$ 0010 >glyph
$ 04 glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 05 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0000 >glyph
$ 06 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 07 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 08 glyph!

glyphcreate
$ 0000 >glyph
$ 0100 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 09 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0111 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 0a glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0111 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0b glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0c glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0d glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0110 >glyph
$ 0110 >glyph
$ 0000 >glyph
$ e glyph!

glyphcreate
$ 0000 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 0f glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 10 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0110 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 11 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 12 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0001 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 13 glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0111 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0000 >glyph
$ 14 glyph!

glyphcreate
$ 0000 >glyph
$ 0111 >glyph
$ 0100 >glyph
$ 0110 >glyph
$ 0001 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 15 glyph!

glyphcreate
$ 0000 >glyph
$ 0011 >glyph
$ 0100 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 16 glyph!

glyphcreate
$ 0000 >glyph
$ 0111 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 17 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 18 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0011 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 19 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 1a glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 1b glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0010 >glyph
$ 0001 >glyph
$ 0000 >glyph
$ 1c glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 1d glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0100 >glyph
$ 0010 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 1e glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 1f glyph!

glyphcreate
$ 0000 >glyph
$ 0110 >glyph
$ 1001 >glyph
$ 1011 >glyph
$ 1011 >glyph
$ 1000 >glyph
$ 0110 >glyph
$ 0000 >glyph
$ 20 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0111 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 21 glyph!

glyphcreate
$ 0000 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0000 >glyph
$ 22 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 23 glyph!

glyphcreate
$ 0000 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0000 >glyph
$ 24 glyph!

glyphcreate
$ 0000 >glyph
$ 0111 >glyph
$ 0100 >glyph
$ 0110 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 25 glyph!

glyphcreate
$ 0000 >glyph
$ 0111 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 26 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 27 glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0111 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 28 glyph!

glyphcreate
$ 0000 >glyph
$ 0111 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 29 glyph!

glyphcreate
$ 0000 >glyph
$ 0011 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 2a glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 2b glyph!

glyphcreate
$ 0000 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 2c glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0111 >glyph
$ 0111 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 2d glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0111 >glyph
$ 0111 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 2e glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 2f glyph!

glyphcreate
$ 0000 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 30 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0111 >glyph
$ 0111 >glyph
$ 0011 >glyph
$ 0000 >glyph
$ 31 glyph!

glyphcreate
$ 0000 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 32 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0001 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 33 glyph!

glyphcreate
$ 0000 >glyph
$ 0111 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 34 glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 35 glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 36 glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0111 >glyph
$ 0111 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 37 glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 38 glyph!

glyphcreate
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 39 glyph!

glyphcreate
$ 0000 >glyph
$ 0111 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 3a glyph!

glyphcreate
$ 0000 >glyph
$ 0111 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 3b glyph!

glyphcreate
$ 0000 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0000 >glyph
$ 3c glyph!

glyphcreate
$ 0000 >glyph
$ 0111 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 3d glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0111 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 3e glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 1111 >glyph
$ 0000 >glyph
$ 3f glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0100 >glyph
$ 0110 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 40 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0110 >glyph
$ 0001 >glyph
$ 0011 >glyph
$ 0101 >glyph
$ 0011 >glyph
$ 0000 >glyph
$ 41 glyph!

glyphcreate
$ 0000 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0000 >glyph
$ 42 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0100 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 43 glyph!

glyphcreate
$ 0000 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0011 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 44 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0100 >glyph
$ 0011 >glyph
$ 0000 >glyph
$ 45 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0100 >glyph
$ 0110 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 46 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0011 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 47 glyph!

glyphcreate
$ 0000 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 48 glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 0110 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 49 glyph!

glyphcreate
$ 0000 >glyph
$ 0001 >glyph
$ 0000 >glyph
$ 0011 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 4a glyph!

glyphcreate
$ 0000 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 4b glyph!

glyphcreate
$ 0000 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 4c glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0101 >glyph
$ 0111 >glyph
$ 0111 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 4d glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 4e glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 4f glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0110 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 50 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0011 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0011 >glyph
$ 0001 >glyph
$ 0001 >glyph
$ 51 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0110 >glyph
$ 0101 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 52 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0011 >glyph
$ 0100 >glyph
$ 0010 >glyph
$ 0001 >glyph
$ 0110 >glyph
$ 0000 >glyph
$ 53 glyph!

glyphcreate
$ 0000 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0100 >glyph
$ 0100 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 54 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 55 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 56 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0111 >glyph
$ 0111 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 57 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 58 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0101 >glyph
$ 0101 >glyph
$ 0011 >glyph
$ 0001 >glyph
$ 0101 >glyph
$ 0010 >glyph
$ 59 glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0111 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0111 >glyph
$ 0000 >glyph
$ 5a glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0001 >glyph
$ 0010 >glyph
$ 0110 >glyph
$ 0010 >glyph
$ 0001 >glyph
$ 0000 >glyph
$ 5b glyph!

glyphcreate
$ 0000 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0010 >glyph
$ 0000 >glyph
$ 5c glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 0100 >glyph
$ 0010 >glyph
$ 0011 >glyph
$ 0010 >glyph
$ 0100 >glyph
$ 0000 >glyph
$ 5d glyph!

glyphcreate
$ 0000 >glyph
$ 0000 >glyph
$ 1010 >glyph
$ 0101 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 0000 >glyph
$ 5e glyph!

glyphcreate
$ 0000 >glyph
$ 0110 >glyph
$ 1001 >glyph
$ 0110 >glyph
$ 1100 >glyph
$ 0110 >glyph
$ 1001 >glyph
$ 0110 >glyph
$ 5f glyph!

