;242
(load "intcode")
(load "aoc-15")

(setq x 0 y 0 tx x ty y cmds nil lf #\.)
(defun read-fun () (loop
    (setq tx x ty y move-cmd nil)
    (when (not cmds)
            (setq move-cmd (code-char (shell "../getc")))
        (push move-cmd cmds))
    (print-xy lf)

    (setq move-cmd (pop cmds))
    (case move-cmd
        (#\w (decf y) (return 1))
        (#\a (decf x) (return 3))
        (#\s (incf y) (return 2))
        (#\d (incf x) (return 4)))))

(defun print-xy (c) (format t "~c[~d;~dH~c" #\ESC (+ 25 y) (+ 50 x) c)(format t "~c[~d;~dH" #\ESC (+ 25 y) (+ 50 x)))

(defun write-fun (val)
    (print-xy (aref "$.XOMWE" val))
    (if (= val 0) (setq x tx y ty) (setq lf (aref "$.XOMWE" val)))
    (print-xy #\o)
    (fflush stdout))

(format t "~c[2J" #\ESC)

(with-open-file (stream "aoc-15-1.dat")
    (loop for line = (read-line stream nil)
        while line do (format t line) (terpri)))

(intcode inp)
