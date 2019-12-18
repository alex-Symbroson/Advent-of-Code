;(load "common.lisp")

(defun ndiff (a b) (if (= a b) 0 (if (< a b) 1 -1)))
(setf moons '((5 -1 5 0 0 0) (0 -14 2 0 0 0) (16 4 0 0 0 0) (18 1 16 0 0 0)))
;(setf moons '((-8 -10 0 0 0 0) (5 5 10 0 0 0) (2 -7 3 0 0 0) (9 -8 -3 0 0 0)))
;(setf moons '((-1 0 2 0 0 0) (2 -10 -7 0 0 0) (4 -8 8 0 0 0) (3 5 -1 0 0 0)))
;    (loop for l in (get-file "aoc-12.txt") do
;        (setq l (regexp:regexp-split "<x=\\|, y=\\|, z=\\|>" l))
;        collect (concat (loop for i from 1 to 3
;            collect (parse-integer (nth i l))) (copy-list '(0 0 0)))))

(defmacro apply-grav (a b c)
    `(incf (nth (+ 3 ,c) ,a) (ndiff (nth ,c ,a) (nth ,c ,b))))

(defmacro apply-vel (a c)
    `(incf (nth ,c ,a) (nth (+ 3 ,c) ,a)))


(loop for j from 0 to 2 do
    (setq i 0 hist nil)
    (loop while (or (< (incf i) 13) (not (every #'= hist (last hist 10)))) do

        (loop for a from 0 to 3 do
            (loop for b from 0 to 3 do
                (when (/= a b)
                    (apply-grav (nth a moons) (nth b moons) j))))

        (loop for a from 0 to 3 do
            (apply-vel (nth a moons) j))

        (push (nth j (nth 0 moons)) hist)
    )
    (print (- i 11))
)

(exit)
(loop for i from 1 to 1000000 do
    (loop for a from 0 to 3 do
        (loop for b from 0 to 3 do
            (when (/= a b)
                (apply-grav (nth a moons) (nth b moons)))))

    (loop for a from 0 to 3 do
        (apply-vel (nth a moons))
    )

    (loop for j from 0 to 2 do
        (setq _tl (nth j (nth a rep)))
        (push (nth j (nth a moons)) (nth j (nth a rep)))
        (when (> i 11)
            (when (every #'= _tl (last _tl 10))
                (print (list j a (- i 11)))))
    )

    (when (= 0 (mod i 1000)) (print (/ i 1000)))
    ;(loop for m in moons do (apply 'format (concat (list t " ~5d ~5d ~5d ~5d ~5d ~5d |") m)))(terpri)
)
;(print rep)
