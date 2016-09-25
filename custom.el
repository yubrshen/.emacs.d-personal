(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(before-save-hook (quote (ispell-pdict-save)))
 '(org-confirm-babel-evaluate nil)
 '(org-image-actual-width (quote (700)))
 '(package-selected-packages
   (quote
    (which-key helm-core helm helm-descbinds helm-projectile org-download toc-org org-plus-contrib org anaconda-mode popup magit-popup s avy beacon cider clojure-mode company dash evil imenu-anywhere projectile smart-mode-line smartparens evil-surround bbdb chinese-fonts-setup use-package moz zop-to-char websocket web-mode volatile-highlights typed-clojure-mode sotclojure smex smartrep smart-comment slime scss-mode scala-mode2 rainbow-mode rainbow-delimiters puml-mode ov org-doing operate-on-number noctilux-theme move-text midje-mode mediawiki markdown-mode magit leuven-theme key-chord json-mode js2-mode js-comint ido-ubiquitous helm-company guru-mode groovy-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist geiser flycheck flx-ido expand-region evil-visualstar evil-tutor evil-smartparens evil-org evil-numbers evil-dvorak ess elisp-slime-nav easy-kill discover-my-major diminish diff-hl csv-mode company-anaconda color-theme coffee-mode bubbleberry-theme browse-kill-ring auto-complete anzu ack-and-a-half achievements ace-window ace-jump-buffer 4clojure))))
; 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button))))))

(load-theme 'manoj-dark) ; so far this one works for my red-green colorblindness

;; Needed to fix problem with magit-status working with cygwin's git,
;; not able to find the current directory,
;; according to https://github.com/magit/magit/issues/1318

(defadvice magit-expand-git-file-name
    (before magit-expand-git-file-name-cygwin activate)
  "Handle Cygwin directory names such as /cygdrive/c/*
by changing them to C:/*"
  (when (string-match "^/cygdrive/\\([a-z]\\)/\\(.*\\)" filename)
    (setq filename (concat (match-string 1 filename) ":/"
                           (match-string 2 filename)))))

;; prevent the warning of long line
(setq prelude-whitespace nil)

;; cygwin-mount setup is a must to make ediff works in Windows + Cygwin + emacs
;; it seems that this set cause cider-jack-in no works
;; (load-file "~/emacs/cygwin-init.el")

;; enable evil-smartparens

(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)

;; if evil-smartparens is too much for some modes
;; (add-hook 'clojure-mode-hook #'evil-smartparens-mode)

;; Make edit r-markdown supported by markdown-mode
(add-to-list 'auto-mode-alist '("\\.rmd\\'" . markdown-mode))

;; make a paragraph into a single line:
(defun unfill-paragraph (&optional region)
      "Takes a multi-line paragraph and makes it into a single line of text."
      (interactive (progn (barf-if-buffer-read-only) '(t)))
      (let ((fill-column (point-max))
            (emacs-lisp-docstring-fill-column t))
        (fill-paragraph nil region)))

;; (require 'helm-orgcard)

;; use-package
(require 'use-package)
(setq use-package-always-ensure nil)


;; The following chinese-pyim offers still much worse user experience than that offered by Google Pinyin.
;; So it's not really useful.

;; (require 'chinese-pyim)

;; Pinyin Input Method
;; (use-package chinese-pyim
;;   :config
;;   (setq default-input-method "chinese-pyim")
;;   ;; 使用双拼
;;   (setq pyim-default-pinyin-scheme 'pyim-shuangpin)
;;   (setq-default pyim-english-input-switch-functions
;;                 nil
;;                 ;; '(pyim-probe-dynamic-english
;;                 ;;   pyim-probe-isearch-mode
;;                 ;;   pyim-probe-program-mode
;;                 ;;   pyim-probe-org-structure-template)
;;                 )

;;   (setq-default pyim-punctuation-half-width-functions
;;                 '(pyim-probe-punctuation-line-beginning
;;                   pyim-probe-punctuation-after-punctuation))

;;   ;; 开启拼音搜索功能
;;   (setq pyim-isearch-enable-pinyin-search t)
;;   (setq pyim-use-tooltip 'popup
;;         pyim-page-length 5)
;;   :bind
;;   (("M-j" . pyim-convert-pinyin-at-point)
;;    ("C-;" . pyim-delete-word-from-personal-buffer)))

;; Chinese fonts setup
(use-package chinese-fonts-setup
  :demand t
  :bind (("C--" . cfs-decrease-fontsize)
         ("C-=" . cfs-increase-fontsize)
         ("C-+" . cfs-next-profile)))

;; start emacs as editing serve
(server-start)

;; In .emacs file I make a call to (server-start) and that is causing an error with the message:
;; ""The directory ~/.emacs.d/server is unsafe."
;; "The problem is the ownership of the directory ~/.emacs.d/server when you also have “Administrators” rights on your account.
;; Change the owner of this directory to your login name and the problem is gone.
;; 

;; Click R-mouse on ~/.emacs.d/server and select “Properties” (last item in menu).
;; From Properties select the Tab “Security” and then select the button “Advanced”.
;; Then select the Tab “Owner” and change the owner from Administrators (<your-pc-name>\Administrators)
;; into <your-login-name> (<your-pc-name>\<your-login-name>.
;; Now the server code will accept this directory as secure because you are the owner.
