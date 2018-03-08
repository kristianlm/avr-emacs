:syntax match red /\:\s\+\S\+\_s\+/
:syntax match green /]\s\+\S\+\_s\+/
:syntax match yellow /[[$]\s\+\S\+\_s\+/
:syntax match white /(\s\+[^)\n]*)/
:syntax match cyan /c\s\+\S\+\_s\+/
:syntax match magenta /var\s\+\S\+\_s\+/
:syntax match darkyellow /l\{1,2}\_s\+/
:highlight red ctermfg=red
:highlight green ctermfg=green
:highlight yellow ctermfg=yellow
:highlight white ctermfg=white
:highlight cyan ctermfg=cyan
:highlight magenta ctermfg=magenta
:highlight darkyellow ctermfg=darkyellow
:NoMatchParen

