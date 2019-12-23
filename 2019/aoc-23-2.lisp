(load "aoc-23")
(load "intcode")
(load "common")

(setq cmd nil gi -1 gqueue (make-hash-table))

(setf (gethash 255 gqueue) '((255 0 0)))
(defun write-fun (val)
    (push val (gethash gi gqueue))
    (decf idle-)
    (when (= 3 (list-length (gethash gi gqueue)))
        (setf cmd (reverse (gethash gi gqueue)))
        (when (in-range (car cmd) -1 50)
            (setf queue (reverse (cadddr (nth (car cmd) comp))))
            (push (cadr cmd) queue)
            (push (caddr cmd) queue)
            (setf (cadddr (nth (car cmd) comp)) (reverse queue)))
        (when (= (car cmd) 255) (push cmd (gethash 255 gqueue)))
        (setf (gethash gi gqueue) nil)))

(defun read-fun () (incf idle+) -1)

(setq comp nil idle+ 0 idle- 0 idle 0)
(loop for i from 0 to 49 do
    (let ((cmp (intcode inp (list i) nil nil t)))
        (setf (gethash i gqueue) nil)
        (setf (caddr cmp) (copy-hash-table (caddr cmp)))
        (push cmp comp)))

(setq running t gi -1 ccmd 0 comp (reverse comp))
(loop while running do
    (if (and (= idle- 0) (> idle+ 0)) (incf idle) (setf idle 0))

    ;worst implementation, takes ages to complete but hey at least it gets its sh*t done
    (when (>= idle 700)
        (setf cmd (car (gethash 255 gqueue)))
        (when (= ccmd (caddr cmd)) (setq running nil))
        (print (setq ccmd (caddr cmd)))
        (setf (nth 3 (car comp)) (subseq cmd 1 3))
        (setq idle 0))

    (setq idle+ 0 idle- 0)
    (loop for i from 0 to 49 do
        (when (not (equal (nth 4 (nth i comp)) -99))
            (setq gi i)
            (setf (nth i comp)
            (intcode nil (cadddr (nth i comp)) t (nth i comp) t))
)   )   )
