(use-package pdf-tools
  :init
  (pdf-tools-install))

(defun my-pdf-view-mode-line-format ()
  (setq mode-line-format
	'("" mode-line-position)))
(add-hook 'pdf-view-mode-hook 'my-pdf-view-mode-line-format)
