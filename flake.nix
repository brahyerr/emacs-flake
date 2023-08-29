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
      # Create an init file by concatenating the the contents of the files in config/*.el
      defaultInitFile = true;
      config = pkgs.writeTextFile {
        name = "emacs-config.el";
        text = (builtins.readFile ./config/init.el) 
             + (builtins.readFile ./config/packages.el);
      };
      package = pkgs.emacs-unstable;
      extraEmacsPackages = epkgs: [
        epkgs.ripgrep
        epkgs.fzf
        epkgs.lsp-mode
        epkgs.lsp-ui
      ];
      # package = pkgs.emacs-unstable.overrideAttrs (final: prev: {
      #   nativeBuildInputs = prev.nativeBuildInputs ++ [ pkgs.makeWrapper ];
      #   postInstall = prev.postInstall + ''
      #     wrapProgram $out/bin/emacs \
      #       --suffix PATH : ${with pkgs; lib.makeBinPath [ fzf ripgrep ]}
      #   '';
      # });
      # Sets config to be used as default init file
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
