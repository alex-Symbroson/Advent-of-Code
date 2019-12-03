(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun splitstr (sep str)
	(setf tmp NIL)
	(loop do
		(if tmp (setf str (subseq str (+ p 1))) (setf tmp t))
		(setf p (position sep str))
		collect (subseq str 0 p)
	while (find sep str)))

(defun gen-lines (dirs)
	(setq x1 0 y1 0 x2 0 y2 0)
	(loop for dir in (splitstr #\, dirs) do
		(setf d (parse-integer (subseq dir 1)))
		(setq x1 x2 y1 y2)
		(if (string= "R" (subseq dir 0 1)) (incf x2 d))
		(if (string= "L" (subseq dir 0 1)) (decf x2 d))
		(if (string= "D" (subseq dir 0 1)) (incf y2 d))
		(if (string= "U" (subseq dir 0 1)) (decf y2 d))
		collect (list x1 y1 x2 y2)))

(defun in-range (x a b)
    (or (and (> x a) (< x b))
	    (and (> x b) (< x a))))

(defun mdist (v)
    (if v (+ (abs (nth 0 v)) (abs (nth 1 v))) 1e9))

(defun may-cross (hor ver)
    (and (= (nth 0 hor) (nth 2 hor)) (= (nth 1 ver) (nth 3 ver))))


(setf in (get-file "aoc-3.txt"))
(setf p1 (gen-lines (nth 0 in)))
(setf p2 (gen-lines (nth 1 in)))

(print (loop for l1 in p1 minimize
    (loop for l2 in p2 minimize
        (mdist (if
            (and
				(or (in-range (nth 0 l1) (nth 0 l2) (nth 2 l2))
					(in-range (nth 1 l1) (nth 1 l2) (nth 3 l2)))
				(or (in-range (nth 0 l2) (nth 0 l1) (nth 2 l1))
					(in-range (nth 1 l2) (nth 1 l1) (nth 3 l1))))
            (if (may-cross l1 l2)
                (list (nth 0 l1) (nth 1 l2))
			    (if (may-cross l2 l1)
                    (list (nth 0 l2) (nth 1 l1)))))))))
