(load "aoc-25")
(load "intcode")
(load "common")

(defun write-fun (val)
    (if (< val 128) (format t "~c" (code-char val)) (print val)))

(defun read-fun() (char-code (read-char)))

(setq start (loop for v across
"west
take pointer
east
south
take whirled peas
south
south
south
take festive hat
north
north
north
north
north
take coin
north
take astronaut ice cream
north
west
take dark matter
south
take klein bottle
west
take mutex
west
south
"  collect (char-code v)))

(intcode inp start)

; sol: mutex, festive hat, whirled peas, coin
