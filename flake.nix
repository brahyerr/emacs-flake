{
  description = "portable emacs flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
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
      emacs-unwrapped = pkgs.emacsWithPackagesFromUsePackage {

        # Create the init config file by concatenating the the contents of the files in ./config/
        # This method of reading ./config/ reads the directory in lexicographical order.
        # Basically, if you want the contents of one particular file to load earlier, edit its name.

        defaultInitFile = true;
        config = pkgs.writeText "emacs-config.el" 
          (builtins.concatStringsSep "\n" 
            (map (path: builtins.readFile path) 
              (pkgs.lib.filesystem.listFilesRecursive ./config)));
        package = if (system == "x86_64-linux" || system == "aarch64-linux")
                  then pkgs.emacs-pgtk  # Experimental wayland support
                  else pkgs.emacs29-macport;
        extraEmacsPackages = import ./epkgs.nix;
        alwaysEnsure = true;
      };
      
      # Wrap the emacs binary with extra external programs to be available in its PATH
      emacs-wrapped = with pkgs; symlinkJoin {
        name = "emacs";
        buildInputs = [ makeWrapper ];
        paths = [ emacs-unwrapped ];
        postBuild = let 
          path = [
            fzf
            ripgrep
            
            ### language servers
            # ccls
            clang-tools
            nil
            pyright
            # jdtls does not seem to work with lsp-mode or eglot, and exits on startup with exit code 13
            # jdt-language-server
            # java-language-server
            vscode-langservers-extracted   # HTML/CSS/JSON/ESLint
            yaml-language-server

            ### tex
            # pandoc
            # texlive.combined.scheme-medium
          ];
        in ''
        wrapProgram $out/bin/emacs \
          --prefix PATH : ${lib.makeBinPath path}
        '';
      };
    in {
      formatter.${system} = pkgs.alejandra;
      packages.${system}.default = emacs-wrapped;
      devShells.${system}.default = pkgs.mkShell {
        # buildInputs = [ emacs-wrapped ];
        packages = [ emacs-wrapped ];
      };
    });

}
