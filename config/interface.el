;; Rainbow-delimiters
(use-package rainbow-delimiters)
  ;; Hook prog-mode to rainbow-delimiters-mode
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Colortheme
(use-package timu-caribbean-theme
  :config
  (load-theme 'timu-caribbean t))

;; (use-package color-theme-sanityinc-tomorrow)
;; (color-theme-sanityinc-tomorrow--define-theme bright)
;; (color-theme-sanityinc-tomorrow-bright)
