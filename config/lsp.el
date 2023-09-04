;; Eglot hooks
(add-hook 'nix-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'css-mode-hook 'eglot-ensure)
(add-hook 'html-mode-hook 'eglot-ensure)

;; lsp-ui
(use-package lsp-ui
  :ensure t)
