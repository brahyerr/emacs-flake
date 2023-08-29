; test
(setq inhibit-startup-message nil
      visible-bell nil)
(setq ring-bell-function 'ignore)
(load-theme 'modus-vivendi t)

; (require 'lsp-mode)
(add-hook 'css-mode-hook #'lsp)

