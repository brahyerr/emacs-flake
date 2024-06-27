;; native keybinds
(keymap-global-set "M-}" 'next-buffer)
(keymap-global-set "M-{" 'previous-buffer)
(keymap-global-set "M-]" 'forward-paragraph)
(keymap-global-set "M-[" 'backward-paragraph)
(keymap-global-set "C-." 'next-window-any-frame)
(keymap-global-set "C-," 'previous-window-any-frame)
(keymap-global-set "C-'" 'window-swap-states)
(keymap-global-set "M-n" 'forward-word)
(keymap-global-set "M-p" 'backward-word)

;; override local keybinds
(add-hook 'compilation-mode-hook
	  (lambda ()
	    (keymap-local-set "M-}" 'next-buffer)
	    (keymap-local-set "M-{" 'previous-buffer)))

;; Dired keymaps
(define-key dired-mode-map (kbd "J") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "K") (lambda () (interactive) (find-alternate-file "..")))
(define-key dired-mode-map (kbd "C-u") 'dired-up-directory)

;; command-log keybinds
;; (keymap-global-set "C-c o" 'local/toggle-command-log-mode-and-buffer)

;; Which key does what?
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Hydra keybinds
(use-package hydra)

(defhydra hydra-resize (global-map "C-SPC")
    "Resize windows."
    ("h" shrink-window-horizontally "shrink-h")
    ("j" shrink-window "shrink-v")
    ("k" enlarge-window "enlarge-v")
    ("l" enlarge-window-horizontally "enlarge-h")
    ("q" nil "quit" :exit t))

;;;;;; Meow function/keybindings ;;;;;;

;; For the following function, regexp-search-ring cannot be nil. If it is, then
;; set it to a new list with element "a"
(if (equal nil regexp-search-ring)
    (setq regexp-search-ring (cons "a" regexp-search-ring)))
  
(defun meow-visit-plus ()
  (interactive)
  (if (region-active-p) (meow-cancel-selection))
  (consult-line)
  ;; (setq regexp-search-ring (cons (car consult--line-history) regexp-search-ring)))
  (setcar regexp-search-ring (car consult--line-history)))

(use-package meow)
(defun meow-beginning-of-line ()
  "Shortcut to go to the beginning of a line."
  (interactive)
  (meow-beginning-of-thing '?l))

(defun meow-end-of-line ()
  "Shortcut to go to the end of a line."
  (interactive)
  (meow-end-of-thing '?l))

;; This function had some help from Brontosaurus
;; Consider using use-region-p instead if there are issues with this function

(setq vim-append-p nil)
(defun meow-append-plus (unused-arg)
  "Modify meow-append to behave more like vim's append."
  (interactive "P")
  (if (region-active-p)
      (meow-append)
    (progn
      (forward-char)
      (meow-append)
      (setq vim-append-p t))))

(defun meow-insert-exit-plus ()
  "Modify meow-insert-exit to move back one character after exitting
   when insert mode is started by pressing the append key."
  (interactive)
  (corfu-quit)
    (if (equal t vim-append-p)
	(progn
	 (backward-char)
	 (meow-insert-exit)
	 (setq vim-append-p nil))
      (meow-insert-exit)))

;; Replace a keymap defined in meow-insert-state-keymap
(define-key meow-insert-state-keymap [escape] #'meow-insert-exit-plus)

;; meow keymap
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet)
   ; isearch
   '("s" . "C-s")
   ; find-file
   '("f" . "C-x C-f")
   ; Window and buffer management
   '("w" . kill-buffer)
   '("d" . next-window-any-frame)
   '("e" . previous-window-any-frame)
   '("q" . delete-window)
   '("Q" . kill-buffer-and-window))
  (meow-motion-overwrite-define-key
   '(":" . "M-x"))
  (meow-normal-define-key
   ;; '("(" . scroll-down-command)
   ;; '(")" . scroll-up-command)
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("_" . meow-beginning-of-line)
   '("$" . meow-end-of-line)
   '("a" . meow-append-plus)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit-plus)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '(":" . "M-x")
   '("<escape>" . ignore)))
;; (require 'meow)
(meow-setup)
(meow-global-mode 1)
(add-hook 'term-mode-hook 'meow--disable)
