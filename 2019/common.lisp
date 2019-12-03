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

(defun in-range (x a b)
    (or (and (> x a) (< x b))
	    (and (> x b) (< x a))))

(defun gdist (line)
    (abs (if (= (nth 0 line) (nth 2 line))
        (- (nth 3 line) (nth 1 line))
        (- (nth 2 line) (nth 0 line)))))

(defun mdist (v)
    (if v (+ (abs (nth 0 v)) (abs (nth 1 v))) 1e9))

(defun concat (a b) (reduce #'cons a :initial-value b :from-end t))
