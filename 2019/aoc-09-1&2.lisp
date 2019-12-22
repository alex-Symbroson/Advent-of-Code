
(load "aoc-09.lisp"))

; init hash table
(defparameter table (make-hash-table))
(setq i -1)
(loop for v in inp do (setf (gethash (incf i) table) v))

(defmacro cine (x) `(gethash (_cine ,x) table))
(defun _cine (x)
    (if (null (gethash x table))
        (setf (gethash x table) 0))
    x)

(defmacro getval (n) `(cine (_getval ,n)))
(defun _getval (n)
    (case (mod (floor (/ (cine i) (expt 10 (+ n 1)))) 10)
        (0 (cine (+ i n)))
        (1 (+ i n))
        (2 (+ rel-base (cine (+ i n))))
    ))

(setq i 0)
(setq rel-base 0)
(loop while (/= (cine i) 99) do
    (case (mod (cine i) 100)

    ;add
    (1 (setf (getval 3)
            (+ (getval 1)
               (getval 2)))
        (incf i 4))

    ;multiply
    (2 (setf (getval 3)
            (* (getval 1)
               (getval 2)))
        (incf i 4))

    ;read
    (3 (format t "input: ")
        (setf (getval 1) (read))
        (incf i 2))

    ;print
    (4 (print (getval 1))
        (incf i 2))

    ;jump-if-true
    (5 (if (/= 0 (getval 1))
        (setq i (getval 2))
        (incf i 3)))

    ;jump-if-false
    (6 (if (= 0 (getval 1))
            (setq i (getval 2))
            (incf i 3)))

    ;less than
    (7 (if (< (getval 1) (getval 2))
            (setf (getval 3) 1)
            (setf (getval 3) 0))
        (incf i 4))

    ;equals
    (8 (if (= (getval 1) (getval 2))
            (setf (getval 3) 1)
            (setf (getval 3) 0))
        (incf i 4))

    ;ch rel-base
    (9 (incf rel-base (getval 1))
        (incf i 2)))
)
