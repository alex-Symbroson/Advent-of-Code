(require "common.lisp")

(setf moons
    (loop for l in (get-file "aoc-12.txt") do
        (setq l (regexp:regexp-split "<x=\\|, y=\\|, z=\\|>" l))
        collect (concat (loop for i from 1 to 3
            collect (parse-integer (nth i l))) (copy-list '(0 0 0)))))

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

(loop for i from 1 to 1000 do

    (loop for a from 0 to 3 do
        (loop for b from 0 to 3 do
            (when (/= a b)
                (apply-grav (nth a moons) (nth b moons)))))

    (loop for a from 0 to 3 do
        (apply-vel (nth a moons))))

(defun a+ (a b) (+ (abs a) (abs b)))

(print (apply '+
    (loop for m in moons collect (*
        (reduce 'a+ (subseq m 0 3))
        (reduce 'a+ (subseq m 3 6))))))
