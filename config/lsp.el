;; Languages

(use-package yuck-mode)

;; Nix
;; (use-package nix-mode
;;   :ensure t  
;;   :mode "\\.nix\\'")
;; 
;; ;; Python
;; (use-package python
;;   :ensure t
;;   :mode ("\\.py\\'" . python-mode))
;; 
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
(setq eglot-sync-connect 1)
(use-package eglot-java)
;;   :hook
;;   (java-mode . eglot-java-mode))

;; Use java-language-server instead of jdtls
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(java-mode . ("java-language-server"))))

(advice-add 'eglot-completion-at-point :around #'cape-wrap-buster) ;; make corfu work better with eglot
(use-package flycheck)

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

;; (defun resize-help-window ()
;;   (interactive)
;;   (enlarge-window ( - 15 (window-body-height))))
;; (add-hook 'flymake-diagnostic-functions 'resize-help-window)

;;;; Java LSP config ;;;;

;; (use-package lsp-mode
;;   :custom
;;   (lsp-completion-provider :none) ;; we use Corfu!
;;   :init
;;   (defun my/lsp-mode-setup-completion ()
;;     (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
;;           '(flex))) ;; Configure flex
;;   :config
;;   (setq lsp-completion-enable-additional-text-edit nil
;; 	lsp-headerline-breadcrumb-enable nil)
;;   :hook
;;   ((lsp-mode . lsp-enable-which-key-integration)
;;    (lsp-completion-mode . my/lsp-mode-setup-completion)))
;; (use-package lsp-ui)
;; (use-package lsp-java
;;   :config
;;   (add-hook 'java-mode-hook 'lsp))
;; (use-package dap-mode
;;   :after
;;   lsp-mode
;;   :config
;;   (dap-auto-configure-mode))
;; (use-package dap-java
;;   :ensure nil)
;; ;; (use-package lsp-treemacs)

;; ;; lsp-mode has a stupid aggressive indent that deletes code
;; (setq lsp-enable-indentation nil
;;       lsp-enable-on-type-formatting nil)

;; ;; Set java indent
;; (add-hook 'java-mode-hook
;;           (lambda ()
;;             (setq tab-width 8)))
;; (setq lsp-java-autobuild-enabled nil)

;; ;; Fix compile escape codes
;; (add-hook 'compilation-filter-hook
;; 	  (lambda () (ansi-color-apply-on-region (point-min) (point-max))))

;; Add java-language-server from PATH
;; (lsp-register-client
;;  (make-lsp-client
;;   :new-connection (lsp-stdio-connection "java-language-server")
;;   :activation-fn (lsp-activate-on "java")
;;   ;; :major-modes '(java-mode)
;;   :server-id 'java-language-server))
