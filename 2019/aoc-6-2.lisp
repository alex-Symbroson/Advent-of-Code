
(require "common.lisp")

(setf data (loop for n in (get-file "aoc-06.txt")
    collect (splitstr #\)  n)))

(defparameter table (make-hash-table :test 'equal))

(defmacro getv (x) `(nth 0 (gethash ,x table)))
(defmacro getr (x) `(nth 1 (gethash ,x table)))

(defun cine (x v)
    (if (null (gethash x table))
        (setf (gethash x table) (list 0 v))
        (when (null (getr x))
            (setf (getr x) v))))

(loop for pair in data do
    (cine (nth 0 pair) nil)
    (cine (nth 1 pair) (nth 0 pair)))

(setq sum -1 p (gethash "SAN" table))
(loop while (nth 1 p) do
    (setq p (gethash (nth 1 p) table))
    (setf (nth 0 p) (incf sum)))

(setq sum -1 p (gethash "YOU" table))
(loop while (= 0 (nth 0 p)) do
    (setq p (gethash (nth 1 p) table))
    (incf sum))

(print (+ sum (nth 0 p)))
