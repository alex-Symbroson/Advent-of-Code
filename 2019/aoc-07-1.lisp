
(setq inp '(3 8 1001 8 10 8 105 1 0 0 21 38 63 72 85 110 191 272 353 434 99999 3 9 102 4 9 9 101 2 9 9 102 3 9 9 4 9 99 3 9 1001 9 4 9 102 2 9 9 1001 9 5 9 1002 9 5 9 101 3 9 9 4 9 99 3 9 1001 9 2 9 4 9 99 3 9 1001 9 3 9 102 2 9 9 4 9 99 3 9 101 2 9 9 102 2 9 9 1001 9 2 9 1002 9 4 9 101 2 9 9 4 9 99 3 9 1002 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 101 2 9 9 4 9 3 9 101 2 9 9 4 9 3 9 101 1 9 9 4 9 3 9 101 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 101 2 9 9 4 9 3 9 101 1 9 9 4 9 3 9 1002 9 2 9 4 9 99 3 9 1001 9 1 9 4 9 3 9 102 2 9 9 4 9 3 9 1001 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 1001 9 2 9 4 9 3 9 101 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 1001 9 2 9 4 9 3 9 1001 9 2 9 4 9 3 9 1001 9 1 9 4 9 99 3 9 1001 9 1 9 4 9 3 9 1001 9 1 9 4 9 3 9 1001 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 101 2 9 9 4 9 3 9 101 2 9 9 4 9 99 3 9 1001 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 101 1 9 9 4 9 3 9 102 2 9 9 4 9 3 9 1001 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 1001 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 102 2 9 9 4 9 99 3 9 1002 9 2 9 4 9 3 9 101 1 9 9 4 9 3 9 101 2 9 9 4 9 3 9 101 1 9 9 4 9 3 9 101 2 9 9 4 9 3 9 102 2 9 9 4 9 3 9 101 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 101 2 9 9 4 9 99
))

(setq inp '(3 15 3 16 1002 16 10 16 1 16 15 15 4 15 99 0 0))

(defmacro nthin(i) `(nth (nth ,i inp) inp))

(defmacro getval (n)
    `(if (= 0 (mod (floor (/ (nth i inp) (expt 10 (+ ,n 1)))) 10))
        (nthin (+ i ,n))
        (nth (+ i ,n) inp)))

(defun run-prog (mode input n)
    (setq i 0 res nil instr (list mode input))

    (loop while (/= (nth i inp) 99) do
        (setq cmd (mod (nth i inp) 100))

        ;add
        (when (= 1 cmd)
            (setf (getval 3)
                (+ (getval 1)
                   (getval 2)))
            (incf i 4))

        ;multiply
        (when (= 2 cmd)
            (setf (getval 3)
                (* (getval 1)
                   (getval 2)))
            (incf i 4))

        ;read
        (when (= 3 cmd)
            (setf (getval 1) (pop instr))
            ;(print (list "in: " (getval 1)))
            (incf i 2))

        ;print
        (when (= 4 cmd)
            (setq res (getval 1))
            ;(print res)
            (incf i 2))

        ;jump-if-true
        (when (= 5 cmd)
            (if (/= 0 (getval 1))
            (setq i (getval 2))
            (incf i 3)))

        ;jump-if-false
        (when (= 6 cmd)
            (if (= 0 (getval 1))
                (setq i (getval 2))
                (incf i 3)))

        ;less than
        (when (= 7 cmd)
            (if (< (getval 1) (getval 2))
                (setf (getval 3) 1)
                (setf (getval 3) 0))
            (incf i 4))

        ;equals
        (when (= 8 cmd)
            (if (= (getval 1) (getval 2))
                (setf (getval 3) 1)
                (setf (getval 3) 0))
            (incf i 4))
) res)

(print
(loop for a from 0 to 4 maximize
(loop for b from 0 to 4 maximize (if (= a b) 0
(loop for c from 0 to 4 maximize (if (or (= a c) (= b c)) 0
(loop for d from 0 to 4 maximize (if (or (= a d) (= b d) (= c d)) 0
(loop for e from 0 to 4 maximize (if (or (= a e) (= b e) (= c e) (= d e)) 0
(when t
    (setq res (run-prog a 0 0))
    (setq res (run-prog b res 1))
    (setq res (run-prog c res 2))
    (setq res (run-prog d res 3))
    (setq res (run-prog e res 4))
)))))))))))
