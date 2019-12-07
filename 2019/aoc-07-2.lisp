
(setq inp '(3 8 1001 8 10 8 105 1 0 0 21 38 63 72 85 110 191 272 353 434 99999 3 9 102 4 9 9 101 2 9 9 102 3 9 9 4 9 99 3 9 1001 9 4 9 102 2 9 9 1001 9 5 9 1002 9 5 9 101 3 9 9 4 9 99 3 9 1001 9 2 9 4 9 99 3 9 1001 9 3 9 102 2 9 9 4 9 99 3 9 101 2 9 9 102 2 9 9 1001 9 2 9 1002 9 4 9 101 2 9 9 4 9 99 3 9 1002 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 101 2 9 9 4 9 3 9 101 2 9 9 4 9 3 9 101 1 9 9 4 9 3 9 101 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 101 2 9 9 4 9 3 9 101 1 9 9 4 9 3 9 1002 9 2 9 4 9 99 3 9 1001 9 1 9 4 9 3 9 102 2 9 9 4 9 3 9 1001 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 1001 9 2 9 4 9 3 9 101 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 1001 9 2 9 4 9 3 9 1001 9 2 9 4 9 3 9 1001 9 1 9 4 9 99 3 9 1001 9 1 9 4 9 3 9 1001 9 1 9 4 9 3 9 1001 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 101 2 9 9 4 9 3 9 101 2 9 9 4 9 99 3 9 1001 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 101 1 9 9 4 9 3 9 102 2 9 9 4 9 3 9 1001 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 102 2 9 9 4 9 3 9 1001 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 102 2 9 9 4 9 99 3 9 1002 9 2 9 4 9 3 9 101 1 9 9 4 9 3 9 101 2 9 9 4 9 3 9 101 1 9 9 4 9 3 9 101 2 9 9 4 9 3 9 102 2 9 9 4 9 3 9 101 2 9 9 4 9 3 9 1002 9 2 9 4 9 3 9 1002 9 2 9 4 9 3 9 101 2 9 9 4 9 99
))

(defmacro getval (n)
    `(if (= 0 (mod (floor (/ (getclm) (expt 10 (+ ,n 1)))) 10))
        (getelm (getnlm ,n))
        (getnlm ,n)))

(defmacro getamp () `(nth (mod amp 5) amps))
(defmacro getampp (x) `(nth ,x (getamp)))

(defmacro getptr () `(getampp 0))
(defmacro setptr (x) `(setf (getptr) ,x))
(defmacro incptr (x) `(incf (getptr) ,x))

; get element from position x
(defmacro getelm (x) `(nth ,x (getampp 1)))
; get element from current position
(defmacro getclm () `(getelm (getptr)))
; get x'th element from current position
(defmacro getnlm (x) `(getelm (+ ,x (getptr))))

(defmacro getprg () `(getampp 1))
(defmacro firstr () `(= 1 (incf (getampp 2 ))))

(defun run-prog (amp signal)
    (let ((cmd 0) (inpc (getprg)))
        ;(print (list "called" amp "phase" (nth (mod amp 5) phases) "signal" signal))
        (loop while (/= (nth (getptr) inpc) 99) do
            (setq cmd (mod (nth (getptr) inpc) 100))
            ;(print (list cmd inpc))

            ;add
            (when (= 1 cmd)
                (setf (getval 3)
                    (+ (getval 1)
                       (getval 2)))
                (incptr 4))

            ;multiply
            (when (= 2 cmd)
                (setf (getval 3)
                    (* (getval 1)
                       (getval 2)))
                (incptr 4))

            ;read
            (when (= 3 cmd)
                (setf (getval 1) (if (firstr) (nth amp phases) signal))
                ;(print (list "in: " (getval 1)))
                (incptr 2))

            ;print
            (when (= 4 cmd)
                (setq out (getval 1))
                (incptr 2)
                (setq out (run-prog (+ amp 1) out)))

            ;jump-if-true
            (when (= 5 cmd)
                (if (/= 0 (getval 1))
                (setptr (getval 2))
                (incptr 3)))

            ;jump-if-false
            (when (= 6 cmd)
                (if (= 0 (getval 1))
                    (setptr (getval 2))
                    (incptr 3)))

            ;less than
            (when (= 7 cmd)
                (if (< (getval 1) (getval 2))
                    (setf (getval 3) 1)
                    (setf (getval 3) 0))
                (incptr 4))

            ;equals
            (when (= 8 cmd)
                (if (= (getval 1) (getval 2))
                    (setf (getval 3) 1)
                    (setf (getval 3) 0))
                (incptr 4))

            (when (> cmd 8) (print (list "unknown command" cmd)) (exit -1))
) out))

;;; initializing

;(setq inp '(3 52 1001 52 -5 52 3 53 1 52 56 54 1007 54 5 55 1005 55 26 1001 54
;-5 54 1105 1 12 1 53 54 53 1008 54 0 55 1001 55 1 55 2 53 55 53 4
;53 1001 56 -1 56 1005 56 6 99 0 0 0 0 10))

;(setq inp '(3 26 1001 26 -4 26 3 27 1002 27 2 27 1 27 26
;27 4 27 1001 28 -1 28 1005 28 6 99 0 0 5))

(setq amps nil)

(setq u 5 v 9 phases nil)

;;; execution

;>10355224

(print
(loop for a from u to v maximize
(loop for b from u to v maximize (if (= a b) 0
(loop for c from u to v maximize (if (or (= a c) (= b c)) 0
(loop for d from u to v maximize (if (or (= a d) (= b d) (= c d)) 0
(loop for e from u to v maximize (if (or (= a e) (= b e) (= c e) (= d e)) 0
(when t
    (setq phases (list a b c d e))
    (setq amps (list
     (list 0 (copy-list inp) 0)
     (list 0 (copy-list inp) 0)
     (list 0 (copy-list inp) 0)
     (list 0 (copy-list inp) 0)
     (list 0 (copy-list inp) 0)))
    (run-prog 0 0))
))))))))))
