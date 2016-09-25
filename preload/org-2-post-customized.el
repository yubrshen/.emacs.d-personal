;; Use file as well as topic path (Yu):
(setq org-refile-use-outline-path (quote file))

;; I'd (Yu) use helm rather than ido to do the refiling:
;; You'll need to set org-outline-path-complete-in-steps to nil.
;; This makes org-refile generate all possible paths when choosing where to refile to,
;; rather than only the top level.
;; based on http://emacs.stackexchange.com/questions/14535/how-can-i-use-helm-with-org-refile
(setq org-outline-path-complete-in-steps nil)
(setq org-completion-use-ido nil)

;; Missing require to make the set in org-1-customization.org work
(require 'org-habit)
