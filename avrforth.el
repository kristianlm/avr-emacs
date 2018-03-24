;(defvar my-mode-map nil "keymap for `my-mode-mode'")
;(setq my-mode-map (make-sparse-keymap))
;(define-key my-mode-map (kbd "C-c C-a") 'my-mode-cmd1)

(defface avrforth-face-compiled-word
  '((t :foreground "green"))
  "Face for words that get compiled, not run (including ] prefix)"
  :group 'avrforth)

(defvar avrforth-mode-syntax-table nil "Syntax table for `avrforth-mode'.")

(setq avrforth-mode-syntax-table
      (let ( (st (make-syntax-table text-mode-syntax-table)))
        ;;(modify-syntax-entry ?\\ "<" st)
        ;;(modify-syntax-entry ?\n ">" st)
        (modify-syntax-entry ?.  "_" st)
        (modify-syntax-entry ?,  "_" st)
        (modify-syntax-entry ?:  "_" st)
        (modify-syntax-entry ?\; "_" st)
        (modify-syntax-entry ?!  "_" st)
        (modify-syntax-entry ?@  "_" st)
        (modify-syntax-entry ?#  "_" st)
        (modify-syntax-entry ??  "_" st)
        (modify-syntax-entry ?~  "_" st)
        (modify-syntax-entry ?\( "_" st)
        (modify-syntax-entry ?\) "_" st)
        (modify-syntax-entry ?\[ "_" st)
        (modify-syntax-entry ?\] "_" st)
        (modify-syntax-entry ?'  "_" st)
        (modify-syntax-entry ?`  "_" st)
        st))

(setq avrforth-highlights
      '( ;; comment
        ("\\_<\([[:space:]][^)]\\{1,63\\}\)" . font-lock-comment-face)
        ;; we have a 64 byte buffer, longer comments cause crashes:
        ("\\_<\([[:space:]][^)]+\)" . font-lock-warning-face)
        ;; ] prefix
        ("\\_<\][[:space:]]+[^[:space:]]+\\_>" . 'avrforth-face-compiled-word)

        ;; colon definition
        ;;("\\_<[^[:space:]]*:[[:space:]]+[^[:space:]]+\\>_" . font-lock-function-name-face)
        ("\\_<[^[:space:]]*:[[:space:]]+[^[:space:]]+\\_>" . font-lock-function-name-face)

        ("\\_<[^[:space:]]*\"[[:space:]]\\([^\"]*\\)\"" 1 font-lock-string-face )
        ;; l
        ("\\_<l\\_>" . font-lock-keyword-face)
        ;; [
        ("\\_<\\[\\_>" . font-lock-keyword-face)
        ;; only 16-bit lowercase hexadecimal!
        ("\\_<$[[:space:]]+[0-9a-f]\\{1,4\\}\\_>" . font-lock-constant-face)
        ;; any other literals are no good:
        ("\\_<$[[:space:]]+[^[:space:]]+" . font-lock-warning-face)

        t))

;;(require 'forth-mode)

;; get your forth-mode from gforth.el, distributed in the official
;; gforth releases.
(define-derived-mode avrforth-mode forth-mode "avrforth"
  "major mode for editing avrforth language code.

gforth's syntax highlighting makes it really to read. this mode
will turn your ]-prefixed words into a different font, and it
will color [ and l pairs (not [ and ]) so they match."

  (setq font-lock-defaults '(avrforth-highlights))

  (set-syntax-table avrforth-mode-syntax-table)
  (setq font-lock-multiline t)
  (setq-local comment-start "\\ ")
  (setq-local comment-end ""))


;;(setq auto-mode-alist (cons '("\\.avrforth\\'" . avrforth-mode) auto-mode-alist))

