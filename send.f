#! /usr/bin/gforth

( send source file to serial port )

hex
0d constant nl
80 constant bufsize

0 value ser
0 value src

( older versions of gforth use different argument numbers )
version-string s" 0.6.9-20070604" compare 0< [if]
  : arg 1 + arg ;
[then]

: init ( -- )
  1 arg r/w open-file throw to ser
  2 arg r/o open-file throw to src ;
: fini ( -- ) ser close-file throw src close-file throw ;

: getsrc ( -- u f ) pad bufsize src read-line throw ;
: putsrc ( u -- ) pad swap ser write-line throw nl ser emit-file throw ser flush-file throw ;
: resp ( -- ) begin ser key-file dup nl <> while emit repeat drop ser key-file drop cr ;

: lines begin getsrc while putsrc resp repeat ;

init lines fini bye

