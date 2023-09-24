(use-package pdf-tools
  :init
  (pdf-tools-install))

(dolist (mode '(doc-view-minor-mode-hook
		pdf-view-mode-hook
		pdf-tools-enabled-hook))
  (add-hook mode #'disable-line-numbers-mode))
