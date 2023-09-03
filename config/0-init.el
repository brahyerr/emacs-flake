(setq visible-bell t
      inhibit-splash-screen t
      ring-bell-function 'ignore
      select-enable-primary t
      x-select-request-type 'text/plain\;charset=utf-8)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Background opacity
(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; Relative line number
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'absolute)
(defvar my-linum-current-line-number 0)

;; Fonts
;; (set-face-attribute 'default nil :font "lemonscaled" :height 200)
(set-fontset-font t nil (font-spec :size 20 :name "CozetteHiDpi"))
(add-to-list 'default-frame-alist '(font . "lemonscaled-20"))
(set-fontset-font "fontset-startup" 'unicode (font-spec :name "lemonscaled") nil)
(set-fontset-font "fontset-startup" 'unicode (font-spec :name "CozetteHiDpi") nil 'append)
(set-face-attribute 'default nil :height 200)

; (require 'lsp-mode)
(add-hook 'css-mode-hook #'lsp)
