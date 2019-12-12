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

(defun atan-pt (a b)
    (rationalize (atan
        (- (nth 1 a) (nth 1 b))
        (- (nth 0 a) (nth 0 b)))))

(defun atan-pt-l (a b)
    (atan
        (- (nth 1 a) (nth 1 b))
        (- (nth 0 a) (nth 0 b))))

(defun gdist (line)
    (abs (if (= (nth 0 line) (nth 2 line))
        (- (nth 3 line) (nth 1 line))
        (- (nth 2 line) (nth 0 line)))))

(defun ndiff (a b) (if (= a b) 0 (if (< a b) 1 -1)))

(defun mdist (v)
    (if v (+ (abs (nth 0 v)) (abs (nth 1 v))) 1e9))

(defun concat (a b) (reduce #'cons a :initial-value b :from-end t))
