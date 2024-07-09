epkgs: with epkgs; (import ./epkgs.nix epkgs) ++ [
  exwm
  exwm-modeline
  i3bar
  pinentry
  desktop-environment
  gpastel
  filechooser # xdg portal filechooser
]
