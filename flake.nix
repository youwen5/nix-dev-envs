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
              gopls
            ];
          };

          zig = pkgs.mkShell {
            buildInputs = with pkgs; [
              zig
              zls
            ];
          };

          pythonPoetry = pkgs.mkShell {
            buildInputs = with pkgs; [
              poetry
              pyright
            ];
          };

          haskellStack = pkgs.mkShell {
            buildInputs = with pkgs; [
              haskellPackages.stack
              haskell-language-server
            ];
          };

          haskellCabal = pkgs.mkShell {
            buildInputs = with pkgs; [
              haskellPackages.cabal-install
              ghc
              haskell-language-server
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
              typescript-language-server
            ];
          };

          pnpmNode = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              nodePackages_latest.pnpm
              nodePackages_latest.prettier
              typescript-language-server
            ];
          };

          yarnNode = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              nodePackages_latest.yarn
              nodePackages_latest.prettier
              typescript-language-server
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
              texlab
            ];
          };

          latexMinimal = pkgs.mkShell {
            buildInputs = with pkgs; [
              texliveMinimal
              texlab
            ];
          };
        };
      }
    );
}
