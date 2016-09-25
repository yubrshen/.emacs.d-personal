;; In order to properly handle text with Chinese, the following setup is needed:

(setq org-latex-pdf-process    '("xelatex -interaction nonstopmode %f"
                                 "xelatex -interaction nonstopmode %f"))

(setq org-latex-default-packages-alist '(
                                        ;("AUTO" "inputenc" t)
 ("T1" "fontenc" t)
                                        ; ("" "fixltx2e" nil)
 ("" "graphicx" t)
 ("" "grffile" t)
 ("" "longtable" nil)
 ("" "wrapfig" nil)
 ("" "rotating" nil)
 ("normalem" "ulem" t)
 ("" "amsmath" t)
 ("" "textcomp" t)
 ("" "amssymb" t)
 ("" "capt-of" nil)
 ("" "hyperref" nil))
)
;; ("AUTO" "inputenc" t) and ("" "fixltx2e" nil) are no longer needed for xlatex
;; Package inputenc Warning: inputenc package ignored with utf8 based engines.
;; Package fixltx2e Warning: fixltx2e is not required with releases after 2015


;; Org-mode PDF Export in Chinese
;; Simple solution
;; Add the following to dotspacemacs/user-config() block of .spacemacs file:

;; (setq org-latex-pdf-process    '("xelatex -interaction nonstopmode %f"
;;                               "xelatex -interaction nonstopmode %f"))
;; When your org file has Chinese characters, just put

;; #+LATEX_HEADER: \usepackage{xeCJK}
;; #+LATEX_HEADER: \setCJKmainfont{SimSun}
;; at the head of your .org file.

;; Note
;; Other methods on the internet require lots of tweaks like style customization of code blocks, which are not needed here.

;; Refer to http://www.xuebuyuan.com/2136832.html

;; 文／defnil（简书作者）
;; 原文链接：http://www.jianshu.com/p/5b19438fc41a
;; 著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
