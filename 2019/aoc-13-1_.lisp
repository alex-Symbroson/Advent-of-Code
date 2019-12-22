
(load "aoc-13.lisp")

(print (count #\2
    (nth 1 (regexp:regexp-split "[01]\\{40,\\}"
    (format nil "~{~A~}" inp)))))
