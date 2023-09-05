;; Eglot hooks
(use-package eglot
  :hook
  ((nix-mode . eglot-ensure)
   (css-mode . eglot-ensure)
   (html-mode . eglot-ensure)
   (python-mode . eglot-ensure)
   (c-mode . eglot-ensure)
   (c++-mode . eglot-ensure)
   (java-mode . eglot-ensure)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(java-mode . ("java-language-server"))))
  
;; (add-hook 'nix-mode-hook 'eglot-ensure)
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'java-mode-hook 'eglot-ensure
;; (add-hook 'python-mode-hook 'eglot-ensure)
;; (add-hook 'css-mode-hook 'eglot-ensure)
;; (add-hook 'html-mode-hook 'eglot-ensure)

;; (add-to-list 'eglot-server-programs '((nix-mode python-mode) .
;;     ("nil" :initializationOptions
;;       (:hints (:parameterNames t
;;                :rangeVariableTypes t
;;                :functionTypeParameters t
;;                :assignVariableTypes t
;;                :compositeLiteralFields t
;;                :compositeLiteralTypes t
;;                :constantValues t)))))

;; lsp-ui
(use-package lsp-ui
  :ensure t)

(defun resize-help-window ()
  (interactive)
  (enlarge-window ( - 15 (window-body-height))))
(add-hook 'flymake-diagnostic-functions 'resize-help-window)
