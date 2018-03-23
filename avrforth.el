;(defvar my-mode-map nil "keymap for `my-mode-mode'")
;(setq my-mode-map (make-sparse-keymap))
;(define-key my-mode-map (kbd "C-c C-a") 'my-mode-cmd1)

(defface avrforth-face-compiled-word
  '((t :foreground "green"))
  "Face for words that get compiled, not run (including ] prefix)"
  :group 'avrforth)

(defvar avrforth-mode-syntax-table nil "Syntax table for `avrforth-mode'.")

(setq avrforth-mode-syntax-table
      (let ( (st (make-syntax-table)))
        (modify-syntax-entry ?\\ "<" st)
        (modify-syntax-entry ?\n ">" st)
        (modify-syntax-entry ?.  "_" st)
        (modify-syntax-entry ?,  "_" st)
        (modify-syntax-entry ?:  "_" st)
        (modify-syntax-entry ?\; "_" st)
        (modify-syntax-entry ?\( "_" st)
        (modify-syntax-entry ?\) "_" st)
        (modify-syntax-entry ?\[ "_" st)
        (modify-syntax-entry ?\] "_" st)
        (modify-syntax-entry ?'  "_" st)
        (modify-syntax-entry ?`  "_" st)
        st))

(setq avrforth-highlights
      '(
        ;; ] prefix
        ("\\<\][[:space:]]+[^[:space:]]+" . 'avrforth-face-compiled-word)
        ;; comment
        ("\\<\([[:space:]]+[^)]+\)" . font-lock-comment-face)
        ;; colon definition
        ("\\([^[:space:]]*:[[:space:]]+[^[:space:]]+\\)" . (1 font-lock-function-name-face))
        ;; l
        ("\\<l\\>" . font-lock-keyword-face)
        ;; [
        ("\\<\\[\\>" . font-lock-keyword-face)
        ;; only 16-bit lowercase hexadecimal!
        ("\\<$[[:space:]]+[0-9a-f]\\{1,4\\}\\>" . font-lock-constant-face)
        ;; any other literals are no good:
        ("\\<$[[:space:]]+[^[:space:]]+" . font-lock-warning-face)))

;; get your forth-mode from gforth.el, distributed in the official
;; gforth releases.
(define-derived-mode avrforth-mode forth-mode "avrforth"
  "major mode for editing avrforth language code.

gforth's syntax highlighting makes it really to read. this mode
will turn your ]-prefixed words into a different font, and it
will color [ and l pairs (not [ and ]) so they match."
  (setq font-lock-defaults '(avrforth-highlights))

  (set-syntax-table avrforth-mode-syntax-table)
  (setq font-lock-multiline nil)
  (setq-local comment-start "\\ ")
  (setq-local comment-end ""))


(setq auto-mode-alist (cons '("\\.avrforth\\'" . avrforth-mode) auto-mode-alist))
