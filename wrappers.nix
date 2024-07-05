{ pkgs
, system
, dictionary
, concatFiles
}: let
  emacs-unwrapped = pkgs.emacsWithPackagesFromUsePackage {

    # Create the init config file by concatenating the the contents of the files in ./config/
    # This method of reading ./config/ reads the directory in lexicographical order.
    # Basically, if you want the contents of one particular file to load earlier, edit its name.
    
    defaultInitFile = true;
    extraEmacsPackages = import ./epkgs.nix;
    alwaysEnsure = false;
    config = pkgs.writeText "emacs-config.el" ("(setq ispell-alternate-dictionary \"${dictionary}/share/dict/words\")");
    package = if (system == "x86_64-linux" || system == "aarch64-linux")
              then pkgs.emacs-pgtk  # Experimental wayland support
              else pkgs.emacs29-macport;
  };

  emacs-unwrapped-config = pkgs.emacsWithPackagesFromUsePackage {
    defaultInitFile = true;
    extraEmacsPackages = import ./epkgs.nix;
    alwaysEnsure = false;
    config = pkgs.writeText "emacs-config.el" ("(setq ispell-alternate-dictionary \"${dictionary}/share/dict/words\")" + concatFiles ./config);
    package = if (system == "x86_64-linux" || system == "aarch64-linux")
              then pkgs.emacs-pgtk  # Experimental wayland support
              else pkgs.emacs29-macport;
  };

  emacs-unwrapped-exwm = pkgs.emacsWithPackagesFromUsePackage {
    defaultInitFile = true;
    extraEmacsPackages = import ./epkgs-exwm.nix;
    alwaysEnsure = false;
    config = pkgs.writeText "emacs-config.el" ("(setq ispell-alternate-dictionary \"${dictionary}/share/dict/words\")");
    package = pkgs.emacs-git;
  };

  path = with pkgs; [
    fzf
    ffmpeg
    ispell
    ripgrep
    emacs-lsp-booster
    global
    universal-ctags
    
    ###  dirvish deps
    fd
    imagemagick
    poppler
    ffmpegthumbnailer
    mediainfo
    gnutar
    unzip

    ### language servers
    nil
    vscode-langservers-extracted   # HTML/CSS/JSON/ESLint
    yaml-language-server
  ];
  
in {
  emacs-wrapped = with pkgs; symlinkJoin {
    name = "emacs";
    buildInputs = [ makeWrapper ];
    paths = [ emacs-unwrapped ];
    postBuild = ''
      for file in $out/bin/*; do
        wrapProgram $file \
          --prefix PATH : ${lib.makeBinPath path} \
          --set-default ASPELL_CONF=dict-dir ${aspellWithDicts (dicts: with dicts; [ fr en en-computers en-science ])}/lib/aspell
      done
    '';
  };

  # Wrap the emacs binary with extra external programs to be available in its PATH
  emacs-wrapped-config = with pkgs; symlinkJoin {
    name = "emacs";
    buildInputs = [ makeWrapper ];
    paths = [ emacs-unwrapped-config ];
    postBuild = ''
      for file in $out/bin/*; do
        wrapProgram $file \
          --prefix PATH : ${lib.makeBinPath path} \
          --set-default ASPELL_CONF=dict-dir ${aspellWithDicts (dicts: with dicts; [ fr en en-computers en-science ])}/lib/aspell
      done
    '';
  };
  emacs-wrapped-exwm = with pkgs; symlinkJoin {
    name = "emacs";
    buildInputs = [ makeWrapper ];
    paths = [ emacs-unwrapped-exwm ];
    postBuild = let
      extraPath = [
        scrot brightnessctl playerctl  # for desktop-environment
        networkmanagerapplet  # for system tray
        pinentry-emacs
        lemonbar-xft
      ];
    in ''
      for file in $out/bin/*; do
        wrapProgram $file \
          --prefix PATH : ${lib.makeBinPath (path ++ extraPath)} \
          --set-default ASPELL_CONF=dict-dir ${aspellWithDicts (dicts: with dicts; [ fr en en-computers en-science ])}/lib/aspell
      done
    '';
  };
}
