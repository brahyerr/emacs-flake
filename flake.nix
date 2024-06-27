{
  description = "portable emacs flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };
    
  outputs = {
    self,
    nixpkgs,
    emacs-overlay,
    ...
  }: let
    inherit (nixpkgs) lib;
    withSystem = f:
      lib.fold lib.recursiveUpdate {}
      (map f ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"]);
  in
    withSystem (system: let
      pkgs = import nixpkgs { inherit system; overlays = [ emacs-overlay.overlays.default ]; };
      concatFiles = path:
        (builtins.concatStringsSep "\n"
          (map (p: builtins.readFile p)
            (lib.filesystem.listFilesRecursive path)));
      # dictionary = pkgs.writeTextDir "share/dict/words" (concatFiles ./assets/dict);
      dictionary = "${self}/assets/dict/english-words.txt";
      exwmAssets = "${self}/assets/exwm";
      emacs-unwrapped = pkgs.emacsWithPackagesFromUsePackage {

        # Create the init config file by concatenating the the contents of the files in ./config/
        # This method of reading ./config/ reads the directory in lexicographical order.
        # Basically, if you want the contents of one particular file to load earlier, edit its name.

        defaultInitFile = true;
        # config = pkgs.writeText "emacs-config.el" ("(setq ispell-alternate-dictionary \"${dictionary}/share/dict/words\")" + concatFiles ./config);
        config = pkgs.writeText "emacs-config.el" ("(setq ispell-alternate-dictionary \"${dictionary}\")" + concatFiles ./config);
        package = if (system == "x86_64-linux" || system == "aarch64-linux")
                  then pkgs.emacs-pgtk  # Experimental wayland support
                  else pkgs.emacs29-macport;
        extraEmacsPackages = import ./epkgs.nix;
        alwaysEnsure = true;
      };

      commonPath = with pkgs; [
        fzf
        ripgrep
        emacs-lsp-booster
        # (aspellWithDicts (dicts: with dicts; [ fr en en-computers en-science ]))

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

        ### tex
        # pandoc
        # texlive.combined.scheme-medium
      ];
      
      # Wrap the emacs binary with extra external programs to be available in its PATH
      emacs-wrapped = with pkgs; symlinkJoin {
        name = "emacs";
        buildInputs = [ makeWrapper ];
        paths = [ emacs-unwrapped ];
        postBuild = let 
          path = commonPath;
        in ''
        for file in $out/bin/*; do
          wrapProgram $file \
            --prefix PATH : ${lib.makeBinPath path} \
            --set-default ASPELL_CONF=dict-dir ${aspellWithDicts (dicts: with dicts; [ fr en en-computers en-science ])}/lib/aspell
        done
        '';
      };

      exwmPath = with pkgs; commonPath ++ [
        git nodejs wmctrl xdotool
        # eaf-browser
        aria 
        # eaf-file-manager
        # fd # already included in commonPath
        
        (python3.withPackages (ppkgs: with ppkgs; [
          pandas
          requests
          sexpdata tld
          pyqt6 pyqt6-sip
          pyqt6-webengine epc lxml # for eaf
          qrcode # eaf-file-browser
          pysocks # eaf-browser
          pymupdf # eaf-pdf-viewer
          pypinyin # eaf-file-manager
          psutil # eaf-system-monitor
          retry # eaf-markdown-previewer
          markdown
        ]))
      ];

      emacs-exwm-unwrapped = pkgs.emacsWithPackagesFromUsePackage {
        defaultInitFile = true;
        config = pkgs.writeText "emacs-config.el"
          (''
             (setq ispell-alternate-dictionary "${dictionary}")
           '' + concatFiles ./config +
           ''
             (start-process-shell-command "xmodmap" nil "xmodmap ${exwmAssets}/Xmodmap")
           '');
        package = pkgs.emacs;
        extraEmacsPackages = import ./exwm.nix;
        alwaysEnsure = true;
      };
      
      emacs-exwm-wrapped = with pkgs; symlinkJoin {
        name = "emacs";
        buildInputs = [ makeWrapper ];
        paths = [ emacs-exwm-unwrapped ];
        postBuild = let
          path = exwmPath;
        in ''
        for file in $out/bin/*; do
          wrapProgram $file \
            --prefix PATH : ${lib.makeBinPath path} \
            --set-default ASPELL_CONF=dict-dir ${aspellWithDicts (dicts: with dicts; [ fr en en-computers en-science ])}/lib/aspell
        done
        '';
      };
      
    in {
      formatter.${system} = pkgs.alejandra;
      packages.${system} = {
        default = emacs-wrapped;
        emacs-exwm = emacs-exwm-wrapped;
      };
      devShells.${system} = {
        default = pkgs.mkShell {
          # buildInputs = [ emacs-wrapped ];
          packages = [ emacs-wrapped ];
        };
        emacs-exwm = pkgs.mkShell {
          packages = [ emacs-exwm-wrapped exwmPath ];
        };
      };
    });

}
