;; (add-to-list 'load-path (expand-file-name "./" (file-name-directory load-file-name)))
;; (load "init.el")

(use-package meow :ensure t)
(use-package magit :ensure t)
(use-package command-log-mode :ensure t)
(use-package linum-relative :ensure t)

;;; Languages

;; Nix
(use-package nix-mode
  :ensure t  
  :mode "\\.nix\\'")

;; Python
(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode))

;; Formatting
; (setq-default indent-tabs-mode nil)
; (setq-default tab-width 2)
; (defvaralias 'c-basic-offset 'tab-width)
; (defvaralias 'cperl-indent-level 'tab-width)
; (setq-default sh-basic-offset 2)
; (setq-default js-indent-level 2)
; (setq-default css-indent-offset 2)
; (setq-default web-mode-markup-indent-offset 2)
; (setq-default web-mode-css-indent-offset 2)
; (setq-default web-mode-code-indent-offset 2)
; (setq-default typescript-indent-level 2)

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))
(global-set-key "\C-s" 'swiper)

; (use-package all-the-icons
;  :if (display-graphic-p))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-ir-black t)

  ;; Enable flashing mode-line on errors
  ; (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ; (doom-themes-neotree-config)
  ;; or for treemacs users
  ; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
