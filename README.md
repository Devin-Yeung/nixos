# NixOS configuration

## Bootstrap a fresh installation

A newly generated NixOS installation may not yet enable the `nix-command` and
`flakes` experimental features. Clone this repository, then use a one-command
environment override for the first switch:

```bash
git clone <repository-url> /etc/nixos
cd /etc/nixos
sudo env NIX_CONFIG="experimental-features = nix-command flakes" \
  nixos-rebuild switch --flake .#nixos
```

The activated configuration enables both features in `nixos/nix.nix`, so later
rebuilds no longer need the override:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

