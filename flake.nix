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

        defaultInitFile = true;
        config = pkgs.writeTextFile {
          name = "emacs-config.el";
          text = (builtins.readFile ./config/init.el) 
               + (builtins.readFile ./config/packages.el);
        };
        package = if (system == "x86_64-linux" || system == "aarch64-linux")
                  then pkgs.emacs-pgtk        # Emacs with experimental gtk wayland support
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
            ### Add your external programs here ###
            # fzf
            # ripgrep
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
        packages = [ emacs-wrapped ];
      };
    });
}
