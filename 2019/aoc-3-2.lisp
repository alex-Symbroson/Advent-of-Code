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

(defun dist (line)
    (abs (if (= (nth 0 line) (nth 2 line))
        (- (nth 3 line) (nth 1 line))
        (- (nth 2 line) (nth 0 line)))))

(defun concat (a b) (reduce #'cons a :initial-value b :from-end t))

(defun path-lens (d1 d2 l1 l2 cross)
    (if cross (+
        (- d1 (dist (concat (subseq l1 2 4) cross)))
        (- d2 (dist (concat (subseq l2 2 4) cross)))) 1e9))

(defun may-cross (hor ver)
    (and (= (nth 0 hor) (nth 2 hor)) (= (nth 1 ver) (nth 3 ver))))

(setf in (get-file "aoc-3.txt"))
(setf p1 (gen-lines (nth 0 in)))
(setf p2 (gen-lines (nth 1 in)))

(setq d1 0)
(print (loop for l1 in p1 do
    (incf d1 (dist l1))
    (setq d2 0)
    minimize (loop for l2 in p2 do
        (incf d2 (dist l2))
        minimize
            (path-lens d1 d2 l1 l2 (if
                (and
    				(or (in-range (nth 0 l1) (nth 0 l2) (nth 2 l2))
    					(in-range (nth 1 l1) (nth 1 l2) (nth 3 l2)))
    				(or (in-range (nth 0 l2) (nth 0 l1) (nth 2 l1))
    					(in-range (nth 1 l2) (nth 1 l1) (nth 3 l1))))
                (if (may-cross l1 l2)
                    (list (nth 0 l1) (nth 1 l2))
    			    (if (may-cross l2 l1)
                        (list (nth 0 l2) (nth 1 l1)))))))))
