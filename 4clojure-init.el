;; This is for playing 4clojure excercize.

;;(require 'cider) ; cider will be loaded afterwords. This is preload before cider is loaded. 

(defadvice 4clojure-open-question (around 4clojure-open-question-around)
  "Start a cider/nREPL connection if one hasn't already been started when
opening 4clojure questions"
  ad-do-it
  (unless cider-current-clojure-buffer
    (cider-jack-in)))
(defun endless/4clojure-check-and-proceed ()
  "Check the answer and show the next question if it worked."
  (interactive)
  (unless
      (save-excursion
        ;; Find last sexp (the answer).
        (goto-char (point-max))
        (forward-sexp -1)
        ;; Check the answer.
        (cl-letf ((answer
                   (buffer-substring (point) (point-max)))
                  ;; Preserve buffer contents, in case you failed.
                  ((buffer-string)))
          (goto-char (point-min))
          (while (search-forward "__" nil t)
            (replace-match answer))
          (string-match "failed." (4clojure-check-answers))))
    (4clojure-next-question)))

(defadvice 4clojure/start-new-problem
    (after endless/4clojure/start-new-problem-advice () activate)
  ;; Prettify the 4clojure buffer.
  (goto-char (point-min))
  (forward-line 2)
  (forward-char 3)
  (fill-paragraph)
  ;; Position point for the answer
  (goto-char (point-max))
  (insert "\n\n\n")
  (forward-char -1)
  ;; Define our key.
  (local-set-key (kbd "M-j") #'endless/4clojure-check-and-proceed))
