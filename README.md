# Nix development environments, for various languages

Those of us on NixOS never install language toolkits system-wide, unlike other distros. This means that when we
work on projects which expect you to bring your own language tools, we don't have things like `node`, `npm`, `cargo`, etc.
readily available in the shell.

Regrettably, many projects are not taking advantage of Nix for reproducible development environments. You should
make a big fuss about this in every open source project you are a part of and constantly evangelize about Nix.
Until Nix is universally adopted, this repository serves as a collection of flakes which provides compilers,
package managers, and basic development tools like LSPs for common languages. Simply clone this to a desired location,
then run:

```bash
nix develop <location-of-repo>#<language>

# example
nix develop ~/.devenvs#rustNightly

# provides rust-analyzer, rustc, cargo, and some others from nightly toolchain
```

## Automatic environment loading

For convenience, you can use [nix-direnv](https://github.com/nix-community/nix-direnv) to
automatically load these environments.

Simply add the following `.envrc` to the project directory:

```bash
# file: .envrc
use flake <path-to-this-repo>#<language>
```

Example:

```bash
use flake ~/.devenvs#go
```

If you don't want to commit these files, make sure to run the following:

```bash
# tell git to ignore these direnv files for this local repository
git update-index --skip-worktree .envrc .direnv
```

## Use without downloading

You can also use this in `nix develop` or with `direnv` without downloading it locally it.
Simply reference the flake remotely like so:

```bash
nix develop "github:youwen5/nix-dev-envs#<environment>"
```

Or in direnv, similarly:

```bash
use flake "github:youwen5/nix-dev-envs#<environment>"
```

> [!WARNING]
> You may not be able to access these environments offline, so you should
> clone the repo if you want to be able to activate them when offline.

## Provided environments:

- Go
- Python (using poetry)
- Haskell (with Cabal)
- Haskell (with Stack)
- Rust (stable, nightly, and beta toolchains)
- Node/TypeScript (pnpm, yarn, and npm variants)
- Typst
- LaTeX (via texlive, with full and minimal variants)
- Zig
