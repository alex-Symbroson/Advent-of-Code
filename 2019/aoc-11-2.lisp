
(load "aoc-11.lisp")
(load "intcode.lisp")

; init drawing hash table
(defparameter canvas (make-hash-table :test 'equal))
(setq x 0 y 0 dir 0 wrc 0)
(defun read-fun ()
    ;(print (list x y))(format t "< ~d " (cine (list x y) canvas))
    (cine (list x y) canvas))

(defun write-fun (val)
    ;(format t "> ~d " val)
    (if (= 1 (mod (incf wrc) 2))
        (setf (cine (list x y) canvas) val)
        (when t
            (if (= val 1) (incf dir) (incf dir 3))
            ;(format t "mv ~d " (mod dir 4))
            (case (mod dir 4)
                (0 (decf y))
                (1 (incf x))
                (2 (incf y))
                (3 (decf x))))))

; part 2
(setf (cine '(0 0) canvas) 1)
(intcode inp)

(format t "~c[2J$" #\ESC)
(loop for k being each hash-key of canvas do
     (when (= (cine k canvas) 1)
        (format t "~c[~d;~dH$" #\ESC (+ 3 (nth 1 k)) (nth 0 k))))
(format t "~c[0;0H$" #\ESC)
