;;; package --- Summary
;;; Commentary:
;;; Code:
;;; It seems that marmalade may have formal packages than melpa.
;;; For example, midje-mode, marmalade has more formal release.

(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Initialize all the ELPA packages (what is installed using the packages commands)
(package-initialize)

(provide 'add-package-archives)
;;; add-package-archives.el ends here
