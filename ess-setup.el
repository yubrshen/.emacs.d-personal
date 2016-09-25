;;; Package --- Summargy
;; Setup for ESS (Emacs Speaks Statistics)

;;; Commentary:
;; based on http://ess.r-project.org/Manual/ess.html#Step-by-step-instructions
;;; Code:

;; The following is for use with non-cygwin:
;; (add-to-list 'load-path "d:/yushen/emacs/3rd-parties/ESS/lisp")

;; The following is needed when running emacs built from cygwin,
;; to overcome the problem of that ess failing to load, complaining
;; not able to find path, and missing w32-short-file-name
;; Use cygwin-emacs for sake of displaying graphics

;; (add-to-list 'load-path "/cygdrive/d/yushen/emacs/3rd-parties/ESS/lisp")
;; (setq ess-program-files "c:/PROGRA~2")
;; (setq ess-program-files-64 "c:/PROGRA~1")
;; (load "ess-site")

;; give up using cygwin-emacs, as it cause problem also planuml loading (search ";" nil nil) failed. 
;; (provide 'ess-setup)
;;; ess-setup.el ends here
