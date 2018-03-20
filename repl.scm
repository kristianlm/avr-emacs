(use posix srfi-18 srfi-13)

(define debug (begin print void))
(define tty (file-open (car (command-line-arguments)) open/rdwr))
;;(##sys#file-nonblocking! tty)

(define ttyin (open-input-file* tty))

;; slurp all data available and wait for newline
(define (flush-input block?)
  (let loop ()
    (if (or block? (char-ready? ttyin))

        (let* ((got (file-read tty 1))
               (read (cadr got)) ;; number of bytes
               (byte (car got))
               (_ (if (= 0 read) (exit))))
          (cond ((eof-object? byte))
                ((equal? "\n" byte) (loop))
                ((equal? "\r" byte) (display "\n") (flush-output)) ;; exits loop
                (else (display byte) (flush-output) (loop))))
        (begin (debug "strange, no data here")))))

(debug "tty: " tty)
(let loop ()
  (debug "waiting for tty or stdin")
  ;; aggressive tty data slurping
  (let ((readyfd (car (file-select (list tty 0) '()))))
    (debug "ready on " readyfd)
    (cond ((= readyfd tty)
           (debug ">> handling tty")
           (flush-input #f)
           (debug ">> handling tty done"))
          ((= readyfd 0)
           (debug "> handing stdin")
           (let ((line (read-line)))
             (unless (string-prefix? "\\ " line)
               (file-write tty line)))
           (file-write tty "\r")
           (debug "> waiting for nl")
           (flush-input #t)
           (debug "> block done"))))
  (loop))
