(load "aoc-21.lisp")
(load "intcode.lisp")

(setq prog (coerce
"NOT A J
NOT B T
OR T J
NOT C T
OR T J
AND D J
NOT E T
NOT T T
OR H T
AND T J
RUN
" 'list))

(defun write-fun (val)
    (if (< val 128)
        (format t "~C" (code-char val))
        (format t "~d" val)))

(defun read-fun ()
    (char-code (pop prog)))

(intcode inp)
