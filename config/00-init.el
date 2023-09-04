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

;; Initialize personal-keybindings variable for packages to use custom keybindings."

(defvar personal-keybindings
  (list))

;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Background opacity
(set-frame-parameter nil 'alpha-background 88)
(add-to-list 'default-frame-alist '(alpha-background . 88))

;; Relative line number
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'absolute)
(defvar my-linum-current-line-number 0)

;; Save history
(savehist-mode t)

;; Fonts with an attempt to set a fallback font
(set-face-attribute 'default nil :font "lemonscaled" :height 200)
(set-face-attribute 'tooltip nil :font "lemonscaled" :height 200)

(defun set-fonts-for-emacsclient ()
  (add-to-list 'default-frame-alist '(font . "lemonscaled-20"))
  (set-fontset-font t 'unicode (font-spec :size 20 :name "lemonscaled") nil)
  (set-fontset-font t 'unicode (font-spec :name "CozetteHiDpi") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "JetBrainsMono") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "Noto Color Emoji") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "DejaVu Sans Mono") nil 'append)
  (set-frame-font "lemonscaled" nil t)
  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil :font "Terminus" :height 20 :weight 'regular)
  ;; CJK fonts
  (set-fontset-font t 'unicode (font-spec :name "WenQuanYi Bitmap Song") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "WenQuanYi Bitmap Song") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "WenQuanYi Bitmap Song") nil 'append)
  (set-fontset-font t 'han (font-spec :name "WenQuanYi Bitmap Song") nil)
  (set-fontset-font t 'kana (font-spec :name "WenQuanYi Bitmap Song") nil)
  (set-fontset-font t 'hangul (font-spec :name "WenQuanYi Bitmap Song") nil))

(add-hook 'server-after-make-frame-hook 'set-fonts-for-emacsclient)

; (set-fontset-font t nil (font-spec :size 20 :name "lemonscaled"))
; (add-to-list 'default-frame-alist '(font . "lemonscaled-20"))
; (set-fontset-font t 'unicode (font-spec :name "lemonscaled") nil)
; (set-fontset-font t 'unicode (font-spec :name "CozetteHiDpi") nil 'append)
;; CJK fonts
; (set-fontset-font t 'han (font-spec :name "WenQuanYi Bitmap Song") nil)
; (set-fontset-font t 'kana (font-spec :name "WenQuanYi Bitmap Song") nil)
; (set-fontset-font t 'hangul (font-spec :name "WenQuanYi Bitmap Song") nil)

; (require 'lsp-mode)
