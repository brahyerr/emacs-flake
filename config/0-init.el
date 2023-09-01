:; test
(setq inhibit-startup-message nil
      visible-bell nil)
(setq ring-bell-function 'ignore)
(load-theme 'modus-vivendi t)

(set-face-attribute 'default nil :font "lemonscaled-20")

; (require 'lsp-mode)
(add-hook 'css-mode-hook #'lsp)

