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
      dictionary = pkgs.writeTextDir "share/dict/words" (concatFiles ./assets/dict);
      wrappers = import ./wrappers.nix
        {inherit pkgs; inherit system; inherit dictionary; inherit concatFiles;};
    in {
      formatter.${system} = pkgs.alejandra;
      packages.${system} = {
        default = wrappers.emacs-wrapped;
        exwm = wrappers.emacs-wrapped-exwm;
        config = wrappers.emacs-wrapped-config;
      };
      devShells.${system}.default = pkgs.mkShell {
        # buildInputs = [ emacs-wrapped ];
        packages = [ wrappers.emacs-wrapped ];
      };
    });

}
