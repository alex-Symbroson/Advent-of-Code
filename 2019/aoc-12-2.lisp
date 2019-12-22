
(load "common.lisp")

(setf moons
    (loop for l in (get-file "aoc-12.txt") do
        (setq l (regexp:regexp-split "<x=\\|, y=\\|, z=\\|>" l))
        collect (concat (loop for i from 1 to 3
            collect (parse-integer (nth i l))) (copy-list '(0 0 0)))))

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

