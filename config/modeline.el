(setq sml/theme 'dark)
(sml/setup)
(use-package mini-modeline
  :after smart-mode-line
  :config
  (mini-modeline-mode t))

;; (use-package mood-line
;;   :config
;;   ;; (mood-line-glyph-alist . mood-line-glyphs-fira-code)
;;   (mood-line-mode t))
;; (with-eval-after-load 'mood-line
;;   (setq mood-line-glyph-alist mood-line-glyphs-fira-code))

;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode 1))
;; (setq doom-modeline-height 10
;;       doom-modeline-unicode-fallback nil
;;       doom-modeline-modal-modern-icon nil
;;       doom-modeline-icon nil
;;       nerd-icons-font-family "CozetteHiDpi")
