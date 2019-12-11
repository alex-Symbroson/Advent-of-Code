
(setq inp '(3 8 1005 8 338 1106 0 11 0 0 0 104 1 104 0 3 8 1002 8 -1 10 1001 10 1 10 4 10 108 1 8 10 4 10 102 1 8 28 1 108 6 10 1 3 7 10 3 8 1002 8 -1 10 1001 10 1 10 4 10 108 1 8 10 4 10 1001 8 0 58 2 5 19 10 1 1008 7 10 2 105 6 10 1 1007 7 10 3 8 1002 8 -1 10 1001 10 1 10 4 10 1008 8 0 10 4 10 101 0 8 97 1006 0 76 1 106 14 10 2 9 9 10 1006 0 74 3 8 102 -1 8 10 101 1 10 10 4 10 108 1 8 10 4 10 1002 8 1 132 1006 0 0 2 1104 15 10 3 8 1002 8 -1 10 1001 10 1 10 4 10 1008 8 0 10 4 10 1001 8 0 162 1 1005 13 10 3 8 1002 8 -1 10 101 1 10 10 4 10 108 1 8 10 4 10 101 0 8 187 1 1 15 10 2 3 9 10 1006 0 54 3 8 102 -1 8 10 101 1 10 10 4 10 108 0 8 10 4 10 102 1 8 220 1 104 5 10 3 8 102 -1 8 10 101 1 10 10 4 10 1008 8 0 10 4 10 102 1 8 247 1 5 1 10 1 1109 2 10 3 8 1002 8 -1 10 101 1 10 10 4 10 1008 8 0 10 4 10 1001 8 0 277 1006 0 18 3 8 1002 8 -1 10 101 1 10 10 4 10 108 1 8 10 4 10 101 0 8 301 2 105 14 10 1 5 1 10 2 1009 6 10 1 3 0 10 101 1 9 9 1007 9 1054 10 1005 10 15 99 109 660 104 0 104 1 21101 0 47677546524 1 21101 0 355 0 1105 1 459 21102 936995299356 1 1 21101 0 366 0 1106 0 459 3 10 104 0 104 1 3 10 104 0 104 0 3 10 104 0 104 1 3 10 104 0 104 1 3 10 104 0 104 0 3 10 104 0 104 1 21101 0 206312807515 1 21102 1 413 0 1105 1 459 21101 206253871296 0 1 21102 424 1 0 1106 0 459 3 10 104 0 104 0 3 10 104 0 104 0 21102 1 709580554600 1 21102 1 447 0 1105 1 459 21101 0 868401967464 1 21101 458 0 0 1106 0 459 99 109 2 22102 1 -1 1 21102 1 40 2 21101 0 490 3 21102 480 1 0 1106 0 523 109 -2 2105 1 0 0 1 0 0 1 109 2 3 10 204 -1 1001 485 486 501 4 0 1001 485 1 485 108 4 485 10 1006 10 517 1101 0 0 485 109 -2 2105 1 0 0 109 4 2101 0 -1 522 1207 -3 0 10 1006 10 540 21102 0 1 -3 21201 -3 0 1 21202 -2 1 2 21101 0 1 3 21101 0 559 0 1105 1 564 109 -4 2106 0 0 109 5 1207 -3 1 10 1006 10 587 2207 -4 -2 10 1006 10 587 21202 -4 1 -4 1105 1 655 21201 -4 0 1 21201 -3 -1 2 21202 -2 2 3 21102 606 1 0 1105 1 564 22102 1 1 -4 21102 1 1 -1 2207 -4 -2 10 1006 10 625 21102 1 0 -1 22202 -2 -1 -2 2107 0 -3 10 1006 10 647 22101 0 -1 1 21101 0 647 0 106 0 522 21202 -2 -1 -2 22201 -4 -2 -4 109 -5 2106 0 0
))

; intcode hash table
(defparameter table (make-hash-table))
(setq i -1)
(loop for v in inp do (setf (gethash (incf i) table) v))

(defmacro cine (x &optional ht dflt) `(gethash (_cine ,x ,ht ,dflt) (if ,ht ,ht table)))
(defun _cine (x &optional ht dflt)
    (when (null (gethash x (if ht ht table)))
        (setf (gethash x (if ht ht table)) (if dflt dflt 0)))
    x)

(defmacro getval (n) `(cine (_getval ,n)))
(defun _getval (n)
    (case (mod (floor (/ (cine i) (expt 10 (+ n 1)))) 10)
        (0 (cine (+ i n)))
        (1 (+ i n))
        (2 (+ rel-base (cine (+ i n))))
    ))


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

(setq i 0 rel-base 0)
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
    (3 (setf (getval 1) (read-fun))
        (incf i 2))

    ;print
    (4 (write-fun (getval 1))
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

(print (hash-table-count canvas))
