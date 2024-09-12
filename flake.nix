{
  description = "Flake for various development environments.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      fenix,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        rustPkgs = fenix.packages.${system};
      in
      {
        formatter = pkgs.nixfmt-rfc-style;

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
            buildInputs = [
              rustPkgs.beta.completeToolchain
            ];
          };

          rustNightly = pkgs.mkShell {
            buildInputs = [
              rustPkgs.complete.toolchain
            ];
          };

          rustStable = pkgs.mkShell {
            buildInputs = [
              rustPkgs.stable.completeToolchain
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
