:; test
(setq inhibit-startup-message nil
      visible-bell nil)
(setq ring-bell-function 'ignore)
(load-theme 'wombat t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(set-face-attribute 'default nil :font "lemonscaled" :height 200)
(set-fontset-font t nil (font-spec :size 20 :name "CozetteHiDpi"))

; (require 'lsp-mode)
(add-hook 'css-mode-hook #'lsp)

