# Optional roswell integration
unsafePath:
''
  (load (expand-file-name "${unsafePath}/.roswell/helper.el"))
  (setq inferior-lisp-program "ros -Q run")
''
