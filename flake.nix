{
  description = "raesan-base";
  inputs = {
    nixpkgs.url =
      "github:nixos/nixpkgs/ebe2788eafd539477f83775ef93c3c7e244421d3";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust_1_84_0-pkgs.url =
      "github:nixos/nixpkgs/d98abf5cf5914e5e4e9d57205e3af55ca90ffc1d";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        rust-pkgs = inputs.rust_1_84_0-pkgs.legacyPackages.${system};
      in {
        formatter = pkgs.nixfmt-classic;
        devShell = pkgs.mkShell {
          packages = [
		  	pkgs.go-task

            pkgs.rust-bin.stable."1.84.0".default
            rust-pkgs.diesel-cli
            rust-pkgs.sqlite
          ];
        };
      });
}
