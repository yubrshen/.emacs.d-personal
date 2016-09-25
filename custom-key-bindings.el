;; From https://sites.google.com/site/steveyegge2/effective-emacs
(global-set-key "\C-w" 'backward-kill-word)

;; Enable key-chord
;;(key-chord-mode) ;; failed to load key-chord-mode here

;; Use ,, instead of escape to be faster
;; (key-chord-define evil-normal-state-map ",," 'evil-force-normal-state)
;; (key-chord-define evil-visual-state-map ",," 'evil-change-to-previous-state)
;; (key-chord-define evil-insert-state-map ",," 'evil-normal-state)
;; (key-chord-define evil-replace-state-map ",," 'evil-normal-state)

;;
(global-set-key [f5] 'call-last-kbd-macro)

;; (defun evil-keyboard-quit ()
;;   "Keyboard quit and force normal state."
;;   (interactive)
;;   (and evil-mode (evil-force-normal-state))
;;   (keyboard-quit))

;; (define-key evil-normal-state-map   (kbd "C-g") #'evil-keyboard-quit)
;; (define-key evil-motion-state-map   (kbd "C-g") #'evil-keyboard-quit)
;; (define-key evil-insert-state-map   (kbd "C-g") #'evil-keyboard-quit)
;; (define-key evil-window-map         (kbd "C-g") #'evil-keyboard-quit)
;; (define-key evil-operator-state-map (kbd "C-g") #'evil-keyboard-quit)

;; The following is no longer needed, replaced by evil-org
;; Complete vim key-bindings based on https://www.shortcutfoo.com/app/dojos/vim/cheatsheet

;; (define-key evil-normal-state-map   (kbd "H") #'evil-window-top) ;; maybe, the key binding is shadowed by org-mode bindings.
;; (add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
;; (require 'evil-org)
