;; package
;; this one fix the problem of \222 not displayed as '
;; C-x RET r windows-1252 RET (revert-buffer-with-coding-system)
;; Actually, the following may not fix the problem.
;; copied from emacs wiki
(standard-display-ascii ?\205 "...")
(standard-display-ascii ?\221 [?\'])
(standard-display-ascii ?\222 [?\'])
(standard-display-ascii ?\223 [?\"])
(standard-display-ascii ?\224 [?\"])
(standard-display-ascii ?\225 [?\*])
(standard-display-ascii ?\226 "---")
(standard-display-ascii ?\227 "--")

;; copied from http://emacs.1067599.n5.nabble.com/How-to-get-rid-of-Microsoft-dumb-quotes-e-g-222-for-apostrophe-td67484.html
(standard-display-ascii ?\200 (vector (decode-char 'ucs #x253c)))
(standard-display-ascii ?\201 (vector (decode-char 'ucs #x251c)))
(standard-display-ascii ?\202 (vector (decode-char 'ucs #x252c)))
(standard-display-ascii ?\203 (vector (decode-char 'ucs #x250c)))
(standard-display-ascii ?\204 (vector (decode-char 'ucs #x2524)))
(standard-display-ascii ?\205 (vector (decode-char 'ucs #x2502)))
(standard-display-ascii ?\206 (vector (decode-char 'ucs #x2510)))
(standard-display-ascii ?\210 (vector (decode-char 'ucs #x2534)))
(standard-display-ascii ?\211 (vector (decode-char 'ucs #x2514)))
(standard-display-ascii ?\212 (vector (decode-char 'ucs #x2500)))
(standard-display-ascii ?\214 (vector (decode-char 'ucs #x2518)))
(standard-display-ascii ?\220 [? ])
(standard-display-ascii ?\221 [?\` ])
(standard-display-ascii ?\222 [?\'])
(standard-display-ascii ?\223 [?\"])
(standard-display-ascii ?\224 [?\"])
(standard-display-ascii ?\225 "* ")
(standard-display-ascii ?\226 "--")
(standard-display-ascii ?\227 " -- ")
