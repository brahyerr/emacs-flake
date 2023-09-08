;; Rainbow-delimiters
(use-package rainbow-delimiters)
  ;; Hook prog-mode to rainbow-delimiters-mode
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Colortheme
(use-package timu-caribbean-theme
  :config
  (load-theme 'timu-caribbean t))
(customize-set-variable 'timu-caribbean-scale-org-document-title nil)
(customize-set-variable 'timu-caribbean-scale-org-document-info nil)
(customize-set-variable 'timu-caribbean-scale-org-level-1 nil)
(customize-set-variable 'timu-caribbean-scale-org-level-2 nil)
(customize-set-variable 'timu-caribbean-scale-org-level-3 nil)


;; (use-package color-theme-sanityinc-tomorrow)
;; (color-theme-sanityinc-tomorrow--define-theme bright)
;; (color-theme-sanityinc-tomorrow-bright)
