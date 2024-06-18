;; Set fonts for emacs
(setq-default line-spacing 2)
(set-face-attribute 'default nil :height 105)
(set-face-attribute 'tooltip nil :height 105)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :height 105)

(defun set-fonts-for-emacsclient ()
  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil :height 105))
(add-hook 'server-after-make-frame-hook 'set-fonts-for-emacsclient)

;;;; Set font settings for org-mode ;;;;
;; Variable header font sizes
(add-hook 'org-mode-hook
	  (lambda ()
	    (set-face-attribute 'org-level-1 nil                   :height 240)
	    (set-face-attribute 'org-level-2 nil                   :height 200)
	    (set-face-attribute 'org-level-3 nil                   :height 160)
	    (set-face-attribute 'org-level-4 nil                   :height 120)
	    (set-face-attribute 'org-level-5 nil                   :height 120)
	    (set-face-attribute 'org-level-6 nil                   :height 120)
	    (set-face-attribute 'org-document-title nil            :height 120)
	    (set-face-attribute 'org-document-info nil             :height 120 :italic 1)
	    (set-face-attribute 'org-document-info-keyword nil     :height 120 :italic 1)
	    (set-face-attribute 'org-headline-done nil             :height 120 :italic 1)
	    (set-face-attribute 'org-done nil                      :height 120)
	    (set-face-attribute 'org-todo nil                      :height 120)))
