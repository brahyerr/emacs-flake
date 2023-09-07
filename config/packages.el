(setq use-package-always-ensure t)
;; (use-package command-log-mode :ensure t)
(setq global-command-log-mode nil)
;; (defun local/toggle-command-log-mode-and-buffer ()
;;   (interactive)
;;   (clm/toggle-command-log-buffer)
;;   (global-command-log-mode 'toggle))

; (use-package all-the-icons
;  :if (display-graphic-p))

(use-package color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow--define-theme bright)
(color-theme-sanityinc-tomorrow-bright)

(use-package rainbow-delimiters)
  ;; Hook prog-mode to rainbow-delimiters-mode
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
