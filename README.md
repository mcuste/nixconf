# nixos

NixOS and Home Manager configurations

## Setting up nix package manager

First install `just`, i.e. in Fedora:

```bash
sudo dnf install just
```

Then clone the `justfile` to the current working directory.

```bash
curl -o ./justfile https://raw.githubusercontent.com/mcuste/nixconf/refs/heads/main/justfile
```

Afterward, check the `home-manager` profiles on `flake.nix`, and then setup nix

```bash
just setup-nix mcst@fedora
```

Then cleanup the `just` and `justfile` since we will be using `nix` installed just system-wide, and the
`justfile` will be cloned along with `nixconf` repo to `~/nixconf/justfile`.

## Setting up configurations

I manage the dotfiles (`~/.config/`) using `stow` instead of `home-manager` (except for bash, fish, and git).

To setup the configurations, run:

```bash
$ just stow
```

## Setting up Godot external editor

To set up `VSCode` as the external editor for `Godot`, you need to install `godot-tools` extension.

Then make sure the `LSP: Server Port` configuration of `godot-tools` is the same as
`Project Settings > Editor > Network > Language Server` in `Godot`.

Then on `Project > Settings > Editor > External Editor` configuration of `Godot`, set the
`Exec Path` to the path of `code` executable (`~/.nix-profile/bin/code` on nixpkgs installed VSCode).
And then also set the `Exec Flags` to `{project} --goto {file}:{line}:{col}`.
