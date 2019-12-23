(load "aoc-23")
(load "intcode")
(load "common")

(setq blcks 0 cmd nil gi -1 gqueue (make-hash-table))

(defun write-fun (val)
    (push val (gethash gi gqueue))
    (when (= 3 (list-length (gethash gi gqueue)))
        (setf cmd (reverse (gethash gi gqueue)))
        (when (in-range (car cmd) -1 50)
            (setf queue (reverse (cadddr (nth (car cmd) comp))))
            (push (cadr cmd) queue)
            (push (caddr cmd) queue)
            (setf (cadddr (nth (car cmd) comp)) (reverse queue)))
        (when (= (car cmd) 255) (print (caddr cmd)) (exit))
        (setf (gethash gi gqueue) nil)))

(defun read-fun () -1)

(setq comp nil)
(loop for i from 0 to 49 do
    (let ((cmp (intcode inp (list i) nil nil t)))
        (setf (gethash i gqueue) nil)
        (setf (caddr cmp) (copy-hash-table (caddr cmp)))
        (push cmp comp)))

(setq running 50 gi -1 comp (reverse comp))
(loop while (> running 0) do
    (loop for i from 0 to 49 do
        (when (not (equal (nth 4 (nth i comp)) -99))
            (setq gi i)
            (setf (nth i comp)
            (intcode nil (cadddr (nth i comp)) t (nth i comp) t))
        )))
