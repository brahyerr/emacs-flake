;; Startup speed, annoyance suppression
(setq gc-cons-threshold 10000000)
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))

;; Silence stupid startup message
(setq inhibit-startup-echo-area-message (user-login-name))

(setq frame-resize-pixelwise t)
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

;; (setq sentence-end-double-space nil)

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
(dolist (mode '(term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Background opacity
(set-frame-parameter nil 'alpha-background 88)
(add-to-list 'default-frame-alist '(alpha-background . 88))

;; UI Enhancements
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'absolute)
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

;; Set fonts for emacsclient
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