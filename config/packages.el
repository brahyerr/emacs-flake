(use-package command-log-mode :ensure t)
(setq global-command-log-mode nil)
;; (defun local/toggle-command-log-mode-and-buffer ()
;;   (interactive)
;;   (clm/toggle-command-log-buffer)
;;   (global-command-log-mode 'toggle))

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

; (use-package all-the-icons
;  :if (display-graphic-p))

(use-package org-modern
  :ensure t)
(with-eval-after-load 'org (global-org-modern-mode))

(use-package color-theme-sanityinc-tomorrow
  :ensure t)
(color-theme-sanityinc-tomorrow--define-theme bright)
(color-theme-sanityinc-tomorrow-bright)

(use-package rainbow-delimiters
  :ensure t)
  ;; Hook prog-mode to rainbow-delimiters-mode
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
(setq doom-modeline-height 10
      doom-modeline-unicode-fallback nil
      doom-modeline-modal-modern-icon nil
      doom-modeline-icon nil
      nerd-icons-font-family "CozetteHiDpi")

; (use-package doom-themes
;  :ensure nil
;  :config
  ;; Global settings (defaults)
;  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;        doom-themes-enable-italic t) ; if nil, italics is universally disabled
;  (load-theme 'doom-acario-dark nil)

  ;; Enable flashing mode-line on errors
  ; (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ; (doom-themes-neotree-config)
  ;; or for treemacs users
  ; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
;  (doom-themes-org-config))
