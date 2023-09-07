;; Pad and .org doc with whitespace
(defun local/org-mode-visual-fill ()
  (setq visual-fill-column-width 125
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . local/org-mode-visual-fill))

(defun local/org-mode-setup ()
  (org-indent-mode)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . local/org-mode-setup)
  :config
  (setq org-ellipsis " \u25be"
	org-agenda-start-with-log-mode t
	org-log-into-drawer t))

;; Must do this so the agenda knows where to look for my files
(setq org-directory "~/org/")
(setq org-agenda-files '("agenda.org" "fit.org"))

;; When a TODO is set to a done state, record a timestamp
(setq org-log-done 'time)

;; Follow the links
(setq org-return-follows-link t)

;; Make org-mode open links in the same window
(with-eval-after-load 'org
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file))

;; Associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

;; Remap the change priority keys to use the UP or DOWN key
;; (define-key org-mode-map (kbd "C-c <up>") 'org-priority-up)
;; (define-key org-mode-map (kbd "C-c <down>") 'org-priority-down)

;; Shortcuts for storing links, viewing the agenda, and starting a capture
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

;; When you want to change the level of an org item, use SMR
;; (define-key org-mode-map (kbd "C-c C-g C-r") 'org-shiftmetaright)

;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

;; Variable header font sizes
(add-hook 'org-mode-hook (lambda ()
(set-face-attribute 'org-level-1 nil                   :family "CozetteHiDpi" :font "CozetteHiDpi" :height 200)
(set-face-attribute 'org-level-2 nil                   :family "CozetteHiDpi" :font "CozetteHiDpi" :height 200)
(set-face-attribute 'org-level-3 nil                   :family "lemonscaled" :font "lemonscaled" :height 200)
(set-face-attribute 'org-level-4 nil                   :family "lemonscaled" :font "lemonscaled" :height 200)
(set-face-attribute 'org-document-title nil            :family "lemonscaled" :font "lemonscaled" :height 200)
(set-face-attribute 'org-document-info nil             :family "lemonscaled" :font "lemonscaled" :height 200 :italic 1)
(set-face-attribute 'org-document-info-keyword nil     :family "lemonscaled" :font "lemonscaled" :height 200 :italic 1)
(set-face-attribute 'org-headline-done nil             :family "lemonscaled" :font "lemonscaled" :height 200 :italic 1)
(set-face-attribute 'org-done nil                      :family "lemonscaled" :font "lemonscaled" :height 200)
(set-face-attribute 'org-todo nil                      :family "lemonscaled" :font "lemonscaled" :height 200)))

;; (set-face-attribute 'org-level-1 nil                   :family "Mordens" :font "Mordens" :height 520 :foreground "#FDF0ED")
;; (set-face-attribute 'org-level-2 nil                   :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 220 :foreground "#25B2BC")
;; (set-face-attribute 'org-level-3 nil                   :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 160)
;; (set-face-attribute 'org-level-4 nil                   :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 160 :italic nil)
;; (set-face-attribute 'org-document-title nil            :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 160 :italic 1 :foreground "#2E303E")
;; (set-face-attribute 'org-document-info nil             :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 160 :italic 1 :foreground "#2E303E")
;; (set-face-attribute 'org-document-info-keyword nil     :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 160 :italic 1 :foreground "#2E303E")
;; (set-face-attribute 'org-headline-done nil             :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 160 :italic 1 :foreground "#6C6F93" :strike-through "#F43E5C" )
;; (set-face-attribute 'org-checkbox-statistics-todo nil  :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 160 :foreground "#09F7A0")
;; (set-face-attribute '+org-todo-project nil             :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 1.0 :foreground "#B877DB")
;; (set-face-attribute 'org-link nil                      :family "Iosevka Nerd Font" :font "Iosevka Nerd Font" :height 160 :italic 1 :underline "#FDF0ED" :foreground "#09F7A0")
;; (set-face-attribute 'line-number-current-line nil      :foreground "#09F7A0")))

;; Make org docs look pretty with org-modern
;; (use-package org-modern)
(with-eval-after-load 'org
  (setq org-modern-todo-faces
	(quote (("TODO"
		 :background "orange"
                 :foreground "black"))))
  (global-org-modern-mode))

