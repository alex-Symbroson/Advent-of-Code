(require "common.lisp")

(setq y 0 obsts nil)
(loop for l in (get-file "aoc-10.txt") do
    (setq x 0)
    (loop for c across l do
        (when (string= c "#")
            (push (list x y) obsts))
        (incf x))
    (incf y))

(setq maxl 0 maxp nil)
(loop for o1 in obsts do
    (setq dirs nil)
    (loop for o2 in obsts do
        (when (not (equal o2 o1))
            (pushnew (atan-pt o1 o2) dirs)))
    (when (> (list-length dirs) maxl)
        (setq maxl (list-length dirs) maxp o1)))

(print (list maxp maxl))
