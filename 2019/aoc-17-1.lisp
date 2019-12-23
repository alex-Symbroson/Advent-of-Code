(load "intcode")
(load "aoc-17")

(defun read-fun () (format t "input: ") (read))

(defun write-fun (val)
    (format t "~C" (code-char val)))

(intcode inp)
