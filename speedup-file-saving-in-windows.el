;; try to improve slow performance on windows.
(setq w32-get-true-file-attributes nil)
;; It works for mine with emacs 24/prelude
;; otherwise, clicking in the butter, which triggers file save, would takes several seconds
;; Just the above seems not helpful. Opening and saving file is still very slow.
;; So try the following:
;; This can speed up Projectile in Windows significantly.
;; The disadvantage of this method is that it's not well supported on Windows systems.
;; (setq  projectile-indexing-method 'alien)
;; The above still does not work. It made the switch to buffer even slower. 

;; as mouse movement will trigger prelude-auto-save-command
;; (defun prelude-auto-save-command ()
;;   "Save the current buffer if `prelude-auto-save' is not nil."
;;   (when (and prelude-auto-save
;;              buffer-file-name
;;              (buffer-modified-p (current-buffer))
;;              (file-writable-p buffer-file-name))
;;     (save-buffer)))

;; setting prelude-auto-save nil will avoid file saving when clicking the mouse.

(setq prelude-auto-save t)              ; but saving often actually is a good habit, otherwise, I might lose too much when undoing.
;; so the real solution is to have fast file save in emacs. I just need it to be fast enough, not flashing fast. 
;; Maybe save often might be an option. 

;; The following copied from web to improve on garbage collection:

(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

