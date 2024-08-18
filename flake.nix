{
  description = "Flake for various development environments.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    rust-overlay,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in {
        devShells = {
          go = pkgs.mkShell {
            buildInputs = with pkgs; [
              go
            ];
          };

          zig = pkgs.mkShell {
            buildInputs = with pkgs; [
              zig
            ];
          };

          pythonPoetry = pkgs.mkShell {
            buildInputs = with pkgs; [
              poetry
            ];
          };

          haskellStack = pkgs.mkShell {
            buildInputs = with pkgs; [
              haskellPackages.stack
            ];
          };

          haskellCabal = pkgs.mkShell {
            buildInputs = with pkgs; [
              haskellPackages.cabal-install
              ghc
            ];
          };

          rustBeta = pkgs.mkShell {
            buildInputs = with pkgs; [
              rust-bin.beta.latest.default
            ];
          };

          rustNightly = pkgs.mkShell {
            buildInputs = with pkgs; [
              rust-bin.nightly.latest.default
            ];
          };

          rustStable = pkgs.mkShell {
            buildInputs = with pkgs; [
              rust-bin.stable.latest.default
            ];
          };

          npmNode = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              nodePackages_latest.npm
              nodePackages_latest.prettier
            ];
          };

          pnpmNode = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              nodePackages_latest.pnpm
              nodePackages_latest.prettier
            ];
          };

          yarnNode = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              nodePackages_latest.yarn
              nodePackages_latest.prettier
            ];
          };

          typst = pkgs.mkShell {
            buildInputs = with pkgs; [
              typst
              typstfmt
              tinymist
            ];
          };

          latexFull = pkgs.mkShell {
            buildInputs = with pkgs; [
              texliveFull
            ];
          };

          latexMinimal = pkgs.mkShell {
            buildInputs = with pkgs; [
              texliveMinimal
            ];
          };
        };
      }
    );
}
