{
  description = "portable emacs flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };
    
  outputs = { self, nixpkgs, emacs-overlay, ... }:
  let
    system = "x86_64-linux";
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
      package = pkgs.emacs-pgtk;  # Experimental wayland support
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
          # fd
          # xdg-utils

          ### language servers
          ccls
          nil
          pyright
          java-language-server
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
  in
  {
    packages.${system}.default = emacs-wrapped;
    devShells.${system}.default = pkgs.mkShell {
      # buildInputs = [ emacs-wrapped ];
      packages = [ emacs-wrapped ];
    };
  };
}
