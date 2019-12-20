(setf int-running t int-ret nil)

(let (i rel-base)

; intcode hash table
(defparameter table (make-hash-table))

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

(defun intcode (inp &optional args noinit)
    (setq int-running t rel-base 0 i -1)
    (when (not noinit) (loop for v in inp do (setf (gethash (incf i) table) v)))

    (setf i 0)
    (loop while (and (/= (cine i) 99) int-running) do
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
        (3 (setf (getval 1) (if args (pop args) (read-fun)))
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
    ) int-ret))
