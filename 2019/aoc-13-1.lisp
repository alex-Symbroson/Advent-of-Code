
(load "aoc-13")
(load "intcode")

(setq blcks 0 cmd nil)

(defun write-fun (val)
    (push val cmd)
    (when (= 3 (list-length cmd))
        (when (= val 2) (incf blcks))
        (format t "~c[~d;~dH~c" #\ESC (1+ (nth 1 cmd)) (1+ (nth 2 cmd)) (aref " $X_o" val))
        (setq cmd nil)))

(intcode inp)
(print blcks)
