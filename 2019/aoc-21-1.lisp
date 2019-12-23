(load "aoc-21")
(load "intcode")

(setq prog (coerce
"NOT A J
NOT B T
OR T J
NOT C T
OR T J
AND D J
WALK
" 'list))

(defun write-fun (val)
    (if (< val 128)
        (format t "~C" (code-char val))
        (format t "~d" val)))

(defun read-fun ()
    (char-code (pop prog)))

(intcode inp)
