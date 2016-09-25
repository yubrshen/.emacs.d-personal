(add-to-list 'exec-path "D:/programs/Aspell/bin/")
(setq ispell-program-name "aspell")
(setq ispell-personal-dictionary "~/.ispell")
(require 'ispell)

(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-<f8>") 'flyspell-mode)
