
(load "aoc-11")
(load "intcode")

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

(intcode inp)
(print (hash-table-count canvas))
