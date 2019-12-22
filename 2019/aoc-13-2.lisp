
(load "aoc-13.lisp")
(load "intcode.lisp")
(setf (nth 0 inp) 2)

(defun ndiff (a b) (if (= a b) 0 (if (< a b) 1 -1)))

(setq cmd nil)
(defun read-fun ()
    (ndiff (nth 2 padd) (nth 2 ball)))

(defun write-fun (val)
    (push val cmd)
    (when (= 3 (list-length cmd))
        (when (= val 3) (setq padd (copy-list cmd)))
        (when (= val 4) (setq ball (copy-list cmd)))
        (if (and (= (nth 2 cmd) -1) (= (nth 1 cmd) 0))
            (format t "~c[0;0HScore: ~d " #\ESC val)
            (format t "~c[~d;~dH~c" #\ESC (1+ (nth 1 cmd)) (1+ (nth 2 cmd)) (aref " $X_o" val)))
        (setq cmd nil)))

(intcode inp)
