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
      # Basically, if you want the contents of one particualr file to load earlier, edit its name.

      defaultInitFile = true;
      config = with pkgs; writeText "emacs-config.el" 
        (builtins.concatStringsSep "\n" 
          (map (path: builtins.readFile path) 
            (lib.filesystem.listFilesRecursive ./config)));
      package = pkgs.emacs-pgtk;  # Experimental wayland support
      extraEmacsPackages = epkgs: [
        epkgs.ripgrep
        epkgs.fzf
        epkgs.lsp-mode
        epkgs.lsp-ui
        epkgs.corfu
        epkgs.ement # matrix client
      ];
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
            fd

            # nix
            nil

            # python
            pyright

            # HTML/CSS/JSON/ESLint
            vscode-langservers-extracted
            
            # yaml
            yaml-language-server

            # debugging
            valgrind
            gdb
            cgdb
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
      buildInputs = [ emacs-wrapped ];
    };
  };
}
