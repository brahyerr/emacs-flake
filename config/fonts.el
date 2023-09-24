;; Set fonts for emacs
(set-face-attribute 'default nil :font "lemonscaled" :height 200)
(set-face-attribute 'tooltip nil :font "lemonscaled" :height 200)

(add-to-list 'default-frame-alist '(font . "lemonscaled-20"))
(set-fontset-font t 'unicode (font-spec :name "lemonscaled") nil)
;; (set-fontset-font t 'unicode (font-spec :name "Noto Color Emoji") nil 'append)
(set-fontset-font t 'unicode (font-spec :name "CozetteHiDpi") nil 'append)
(set-fontset-font t 'unicode (font-spec :name "JetBrainsMono") nil 'append)
(set-fontset-font t 'unicode (font-spec :name "DejaVu Sans Mono") nil 'append)
(set-frame-font "lemonscaled" nil t)
;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Terminus" :height 160 :weight 'regular)
;; CJK fonts
(set-fontset-font t 'unicode (font-spec :name "WenQuanYi Bitmap Song") nil 'append)
(set-fontset-font t 'unicode (font-spec :name "WenQuanYi Bitmap Song") nil 'append)
(set-fontset-font t 'unicode (font-spec :name "WenQuanYi Bitmap Song") nil 'append)
(set-fontset-font t 'han (font-spec :name "WenQuanYi Bitmap Song") nil)
(set-fontset-font t 'kana (font-spec :name "WenQuanYi Bitmap Song") nil)
(set-fontset-font t 'hangul (font-spec :name "WenQuanYi Bitmap Song") nil)


(defun set-fonts-for-emacsclient ()
  (add-to-list 'default-frame-alist '(font . "lemonscaled-20"))
  (set-fontset-font t 'unicode (font-spec :name "lemonscaled") nil)
  (set-fontset-font t 'unicode (font-spec :name "Noto Color Emoji") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "CozetteHiDpi") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "JetBrainsMono") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "DejaVu Sans Mono") nil 'append)
  (set-frame-font "lemonscaled" nil t)
  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil :font "Terminus" :height 160 :weight 'regular)
  ;; CJK fonts
  (set-fontset-font t 'unicode (font-spec :name "WenQuanYi Bitmap Song") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "WenQuanYi Bitmap Song") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "WenQuanYi Bitmap Song") nil 'append)
  (set-fontset-font t 'han (font-spec :name "WenQuanYi Bitmap Song") nil)
  (set-fontset-font t 'kana (font-spec :name "WenQuanYi Bitmap Song") nil)
  (set-fontset-font t 'hangul (font-spec :name "WenQuanYi Bitmap Song") nil))

(add-hook 'server-after-make-frame-hook 'set-fonts-for-emacsclient)
