(setq-default TeX-PDF-mode t)   ; Use PDF mode by default
(setq TeX-source-correlate-mode t) ; Enable source correlation
(setq TeX-source-correlate-method 'synctex) ; Set correlation method
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-view-program-selection '((output-pdf "zathura")))
