;; Startup speed, annoyance suppression
;; (setq gc-cons-threshold 10000000)
(setq gc-cons-threshold 10000000)
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Silence stupid startup message
(setq inhibit-startup-echo-area-message (user-login-name))
(setq inhibit-splash-screen t)

(setq frame-resize-pixelwise t)
(setq visible-bell nil
      ring-bell-function 'ignore
      select-enable-primary t
      x-select-request-type 'text/plain\;charset=utf-8)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
;; (setq-default left-margin-width 2
;; 	      right-margin-width 2)

;; (add-to-list 'mode-line-format '("  "))

;; (setq sentence-end-double-space nil)

;; Command logging
(setq global-command-log-mode nil)
;; (defun local/toggle-command-log-mode-and-buffer ()
;;   (interactive)
;;   (clm/toggle-command-log-buffer)
;;   (global-command-log-mode 'toggle))

;; Don't litter file system with *~ backup files; put them all inside
;; ~/.emacs.d/backup or wherever
(defun bedrock--backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* ((backupRootDir "~/.emacs.d/emacs-backup/")
         (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path
         (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") )))
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath))
(setq make-backup-file-name-function 'bedrock--backup-file-name)

;; Initialize personal-keybindings variable for packages to use custom keybindings."
(defvar personal-keybindings
  (list))

;; Disable line numbers for some modes
(dolist (mode '(dired-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook
		org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Background opacity
(set-frame-parameter nil 'alpha-background 95)
(add-to-list 'default-frame-alist '(alpha-background . 95))

;; Frame margins
(set-frame-parameter nil 'internal-border-width 16)
(add-to-list 'default-frame-alist '(internal-border-width . 16))

;; UI Enhancements
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'visual)
(defvar my-linum-current-line-number 0)

(setq column-number-mode t)                      ; Show column as well

(setq x-underline-at-descent-line nil)           ; Prettier underlines
(setq switch-to-buffer-obey-display-actions t)   ; Make switching buffers more consistent

(setq-default show-trailing-whitespace nil)      ; By default, don't underline trailing spaces
(setq-default indicate-buffer-boundaries 'left)  ; Show buffer top and bottom in the margin
(blink-cursor-mode -1)                                ; Steady cursor
(pixel-scroll-precision-mode 1)                         ; Smooth scrolling

;; Save history
(savehist-mode t)
