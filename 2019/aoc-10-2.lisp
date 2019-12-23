(require "common")

(setq y 0 obsts nil pos '(22 28))
(loop for l in (get-file "aoc-10.txt") do
    (setq x 0)
    (loop for c across l do
        (when (and (string= c "#") (or (/= x (nth 0 pos)) (/= y (nth 1 pos))))
            (push (list x y
                (mod (+ (/ (* PI 3) 2) (atan-pt-l pos (list x y)))
                     (* PI 2))) obsts))
        (incf x))
    (incf y))

(defun round-to (number precision)
    (let ((div (expt 10.0 precision)))
    (/ (round (* number div)) div)))

(defun abs< (a b) (if (<= x 0)))

(sort obsts (function (lambda (a b) (< (nth 2 a) (nth 2 b)))))

(defmacro getang (x) `(nth 2 (nth ,x obsts)))

(setq ang 0 jmp 0 la 0 n 0)
(loop while (or (< n 200) (<= (list-length obsts) 2)) do
    (when (= (incf n) 200)
        (print (nth jmp obsts)))

    (setq la (getang jmp))
    (delete (nth jmp obsts) obsts)
    (when (= jmp (list-length obsts)) (setq jmp 0))

    (loop while (= la (getang (+ jmp))) do
        (setq la (getang jmp))
        (when (= (incf jmp) (list-length obsts)) (setq jmp 0))))
