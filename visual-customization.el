;;; package --- Ssummary setting up for visual conformt
;;; Commentary:

;; This is for set color theme that is good for color blind people

;;; Code:


;; Change font default

;; (remove-if (lambda (x)
;;              (eq 'font (car x)))
;;            default-frame-alist)
					; remove the existing font setting
(add-to-list 'default-frame-alist '(font . "Courier 14")) ; set the default font

;; the status line change color when in insert mode and when the buffer is dirty (needs saving)
(lexical-let ((default-color (cons (face-background 'mode-line)
                                      (face-foreground 'mode-line))))
     (add-hook 'post-command-hook
       (lambda ()
         (let ((color (cond ((minibufferp) default-color)
                            ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                            ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                            ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                            (t default-color))))
           (set-face-background 'mode-line (car color))
           (set-face-foreground 'mode-line (cdr color))))))

(provide 'visual-customization)
;;; visual-customization ends here
