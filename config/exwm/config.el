;;;; exwm keybindings
(keymap-global-set "s-]" 'next-buffer)
(keymap-global-set "s-[" 'previous-buffer)
(keymap-global-set "s-}" 'windmove-swap-states-right)
(keymap-global-set "s-{" 'windmove-swap-states-left)
(keymap-global-set "s-." 'next-window-any-frame)
(keymap-global-set "s-," 'previous-window-any-frame)
(keymap-global-set "s-'" 'window-swap-states)
(keymap-global-set "s-=" 'text-scale-increase)
(keymap-global-set "s--" 'text-scale-decrease)

;;;; the rest

;; Ensure screen updates with xrandr will refresh EXWM frames
(require 'exwm-randr)
(exwm-randr-enable)
;; Set the screen resolution
(start-process-shell-command "xrandr" nil "")
;; Load the system tray before exwm-init
(require 'exwm-systemtray)
(exwm-systemtray-enable)
