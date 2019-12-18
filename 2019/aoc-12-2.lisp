;(load "common.lisp")

(defun ndiff (a b) (if (= a b) 0 (if (< a b) 1 -1)))
(setf moons '((5 -1 5 0 0 0) (0 -14 2 0 0 0) (16 4 0 0 0 0) (18 1 16 0 0 0)))
;(setf moons '((-8 -10 0 0 0 0) (5 5 10 0 0 0) (2 -7 3 0 0 0) (9 -8 -3 0 0 0)))
;(setf moons '((-1 0 2 0 0 0) (2 -10 -7 0 0 0) (4 -8 8 0 0 0) (3 5 -1 0 0 0)))
;    (loop for l in (get-file "aoc-12.txt") do
;        (setq l (regexp:regexp-split "<x=\\|, y=\\|, z=\\|>" l))
;        collect (concat (loop for i from 1 to 3
;            collect (parse-integer (nth i l))) (copy-list '(0 0 0)))))

(defmacro apply-grav (a b)
    `(progn
        (incf (nth 3 ,a) (ndiff (nth 0 ,a) (nth 0 ,b)))
        (incf (nth 4 ,a) (ndiff (nth 1 ,a) (nth 1 ,b)))
        (incf (nth 5 ,a) (ndiff (nth 2 ,a) (nth 2 ,b)))))

(defmacro apply-vel (a)
    `(progn
        (incf (nth 0 ,a) (nth 3 ,a))
        (incf (nth 1 ,a) (nth 4 ,a))
        (incf (nth 2 ,a) (nth 5 ,a))))

(setq repc 0
    rep (loop repeat 4 collect (make-list 3))
    track (loop repeat 4 collect (make-list 3))
    hist nil)

(loop for i from 1 to 1000000 do
    (loop for a from 0 to 3 do
        (loop for b from 0 to 3 do
            (when (/= a b)
                (apply-grav (nth a moons) (nth b moons)))))

    (loop for a from 0 to 3 do
        (apply-vel (nth a moons))
    )

    (loop for j from 0 to 2 do
        (setq _tl (nth j (nth 0 rep)))
        (push (nth j (nth 0 moons)) (nth j (nth 0 rep)))
        (when (> i 11)
            (when (every #'= _tl (last _tl 10))
                (print (list j 0 (- i 11)))))
    )

    (when (= 0 (mod i 1000)) (print (/ i 1000)))
    ;(loop for m in moons do (apply 'format (concat (list t " ~5d ~5d ~5d ~5d ~5d ~5d |") m)))(terpri)
)
;(print rep)
