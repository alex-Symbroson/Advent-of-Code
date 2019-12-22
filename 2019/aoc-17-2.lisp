(load "intcode.lisp")
(load "aoc-17.lisp")

;(defun read-fun () (format t "input: ") (char-code (read-char)))

(defun write-fun (val)
    (if (code-char val) (format t "~C" (code-char val)) (format t "~d" val)))

(setf (nth 0 inp) 2)

(intcode inp (loop for c across "B,A,B,C,A,C,A,B,C,A
R,6,R,8,R,8,L,6,R,8
L,10,L,6,R,10
L,10,R,8,R,8,L,10
n
" collect (char-code c)))
