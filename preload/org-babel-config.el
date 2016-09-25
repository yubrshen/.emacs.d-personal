;;; package --- Summary
;;; Commentary:

;; Set up for literate programming with org-babel for Clojure

(require 'org)
(require 'ob-clojure)

(setq org-babel-clojure-backend 'cider)
                                        ;(require 'cider)

;; Patch ob-clojure to work with nrepl
(declare-function nrepl-send-string-sync "ext:nrepl" (code &optional ns))

;; (defun org-babel-execute:clojure-backup (body params)
;;   "Execute a block of Clojure code with Babel."
;;   ;(require 'nrepl)
;;   (with-temp-buffer
;;     (insert (org-babel-expand-body:clojure body params))
;;     ((lambda (result)
;;        (let ((result-params (cdr (assoc :result-params params))))
;;          (if (or (member "scalar" result-params)
;;                  (member "verbatim" result-params))
;;              result
;;            (condition-case nil (org-babel-script-escape result)
;;              (error result)))))
;;      (plist-get (nrepl-send-string-sync
;;                  (buffer-substring-no-properties (point-min) (point-max))
;;                  (cdr (assoc :package params)))
;;                 :value))))

(defun org-babel-execute:clojure (body params)
  "Execute a block of Clojure code with Babel."
                                        ;(require 'nrepl)
  (with-temp-buffer
    (insert (org-babel-expand-body:clojure body params))
    ((lambda (result)
       (let ((result-params (cdr (assoc :result-params params))))
         (if (or (member "scalar" result-params)
                 (member "verbatim" result-params))
             result
           (condition-case nil (org-babel-script-escape result)
             (error result)))))
     (plist-get (nrepl-sync-request:eval
                 (buffer-substring-no-properties (point-min) (point-max))
                 (cdr (assoc :package params)))
                :value))))

;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (emacs-lisp . t)
   (python . t)
   (clojure . t)
   (js . t)
   (plantuml . t)
   (ditaa . t)
   (shell . t)
   (R . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/bin/plantuml.jar"))

(setq org-ditaa-jar-path
      (expand-file-name "~/bin/ditaa0_9.jar"))

;;; must have plantuml-jar-pat properly set before loading plantuml-mode
(setq plantuml-jar-path org-plantuml-jar-path)

;; (load-file "~/emacs/3rd-parties/plantuml-mode/plantuml-mode.el")

;; setting to execute R code block
(setq org-babel-R-command "D:/programs/R/R-3.1.3/bin/x64/R --slave --no-save")

;; found out that on Internet, Rterm needs to be accessible by the following:
(setq inferior-R-program-name "D:/programs/R/R-3.1.3/bin/x64/Rterm")

(custom-set-variables
 '(org-confirm-babel-evaluate nil))

;; to let display generated figure/plot inline need to have the following:
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)

;; It seems that also the above is also needed to have the figure to be exported in html.

(define-skeleton org-babel-skeleton
  "Header info for a emacs-org file."
  "Title: "
  "#+TITLE:" str " \n"
  "#+AUTHOR: Yu Shen\n"
  "#+email: yubrshen@gmail.com\n"
  "#+LANGUAGE:   en\n"
  "#+INFOJS_OPT: \n"
  "#+OPTIONS:    H:3 num:nil toc:2 \\n:nil @:t ::t |:t ^:{} -:t f:t *:t TeX:t LaTeX:t skip:t d:(HIDE) tags:not-in-toc\n"
  ;; "#+OPTIONS: :nil @:t ::t |:t ^:nil -:t f:t *:t <:t\n"
  "#+TAGS:       Write(w) Update(u) Fix(f) Check(c) noexport(n)\n"
  "#+STARTUP:    align fold nodlcheck hidestars oddeven lognotestate\n"
  "#+SEQ_TODO:   TODO(t) INPROGRESS(i) WAITING(w@) | DONE(d) CANCELED(c@)\n"
  "#+STYLE:      <style type=\"text/css\">#outline-container-introduction{ clear:both; }</style>\n"
  "#+BABEL: :exports both\n"
  "#+PROPERTY: mkdirp yes\n"
  ;; "#+BABEL: :session *R* :cache yes :results output graphics :exports both :tangle yes \n"
  "-----"
  )

(global-set-key [C-S-f4] 'org-babel-skeleton)

;; The #+INFOJS_OPT option will generat a HTML document that is foldable
;; and follows the style of GNU/INFO document.
;; The :session *R* option makes sure all the R code is run in the same session
;; so objects generated in one code block can be accessed from other code blocks.
;; the :cache yes option is used to avoid re-evaluating unchanged code blocks.
;; This can save significant time when you revise a document
;; with a lot of R code frequently.
;; The :results output graphics :exports both option will put both the R code
;; and its text and graphics output in the generated document.
;; The :tangle yes option allows the document to be "tangled"
;; to generate pure code file.
;; The short-cut key for tangling is C-c C-v t,
;; which generates a .R file with all the R code extracted.
;; Note the "–—" string will generate a horizontal line in HTML file.
;; Finally, a hotkey C-S-f4 (while pressing Ctrl and Shift keys, press F4 key)
;; is assigned to invoke this skeleton quickly.

;; Use babel templates to conveniently create code chunks:

(add-to-list 'org-structure-template-alist ; start a new python code block
             '("p" "#+BEGIN_SRC python \n?\n#+END_SRC\n" "<src lang=\"python\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist ; split a python code block
             '("pe" "#+END_SRC\n\n?\n#+BEGIN_SRC python \n" "</src>\n<src lang=\"python\">"))

(add-to-list 'org-structure-template-alist ; start a new Clojure code block
             '("clj" "#+NAME:?\n#+BEGIN_SRC clojure \n\n#+END_SRC\n" "\n<src lang=\"clojure\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist ; split a Clojure code block
             '("cs" "#+END_SRC\n\n\n#+NAME: ?\n#+BEGIN_SRC clojure \n" "</src>\n<src lang=\"clojure\">"))

(add-to-list 'org-structure-template-alist ; start a new R code block
             '("r" "#+NAME:?\n#+BEGIN_SRC R \n\n#+END_SRC\n" "\n<src lang=\"R\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist ; split a R code block
             '("rs" "#+END_SRC\n\n\n#+NAME: ?\n#+BEGIN_SRC R \n" "</src>\n<src lang=\"R\">"))

(add-to-list 'org-structure-template-alist ; start a new Javascript code block
             '("j" "#+NAME:?\n#+BEGIN_SRC javascript \n\n#+END_SRC\n" "\n<src lang=\"javascript\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist ; split a javascript code block
             '("js" "#+END_SRC\n\n\n#+NAME: ?\n#+BEGIN_SRC javascript \n" "</src>\n<src lang=\"javascript\">"))

(add-to-list 'org-structure-template-alist ; start a new emacs-lisp code block
             '("elsp" "#+NAME:?\n#+BEGIN_SRC emacs-lisp \n\n#+END_SRC\n" "\n<src lang=\"emacs-lisp\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist ; split a emacs-lisp code block
             '("elsps" "#+END_SRC\n\n\n#+NAME: ?\n#+BEGIN_SRC emacs-lisp \n" "</src>\n<src lang=\"emacs-lisp\">"))

(add-to-list 'org-structure-template-alist ; start a ditaa block for diagram
             '("ditaa" "#+NAME:?\n#+BEGIN_SRC ditaa \n\n#+END_SRC\n" "\n<src lang=\"ditaa\">\n?\n</src>"))

(add-to-list 'org-structure-template-alist ; start a shell block 
             '("shell" "#+NAME:?\n#+BEGIN_SRC shell \n\n#+END_SRC\n" "\n<src lang=\"shell\">\n?\n</src>"))

;; add the section for shell command

;; Add test case in front of implementation to encourgane TDD approach. 
(define-skeleton tdd-clojure-skeleton
    "Define a skeleton for TDD and literate programming. "
    "function name: "
    "#+NAME:" str "-test" \n
    "#+BEGIN_SRC clojure" \n
    "(facts \"about \`" str "\'\"" \n
    " )" \n
    "#+END_SRC" \n
    "<<" str "-test>>"
    \n
    "#+NAME:" str \n
    "#+BEGIN_SRC clojure" \n
    "(defn " str " []"\n
    " )"  \n
    "#+END_SRC" \n

    \n
    "<<" str ">>" \n

    "\n"
  )
(provide 'org-babel-config)
;;; org-babel-config.el ends here
