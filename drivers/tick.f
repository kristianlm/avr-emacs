( system tick )

02 var ticks

s" ticks" link, ( -- x )
  dup,
  cli,
  tosl ticks fetch
  tosh ticks 1 + fetch
  sei,
  ret,

idpx

s" ticks+" link, ( -- )
  zl ticks fetch
  zh ticks 1 + fetch
  zz 1 adiw,
  ticks zl store
  ticks 1 + zh store
  ret,

idpx

