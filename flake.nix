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
    emacs-wrapped = pkgs.emacsWithPackagesFromUsePackage {
      config = ./config/emacs.el;
      package = pkgs.emacs-unstable;
      # Sets config to be used as default init file
      # defaultInitFile = true;
    };
  in
  {
    packages.${system}.default = emacs-wrapped;
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [ emacs-wrapped ];
    };
  };
}
