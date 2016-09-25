;; This is the file that specifies packages that I want in addition to those provided by Prelude.

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
;; (package-initialize)

;; My additional packages
;; (setq prelude-packages (append '(
;;                                  ess
;;                                  moz
;;                                  evil-leader
;;                                  evil-smartparens
;;                                  toc-org
;;                                  puml-mode
;;                                  ) prelude-packages))
;; It seems that it's not needed. The package would be added through init.el
;; Install my packages
;; (prelude-install-packages)
