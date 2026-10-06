# NixOS configuration

## Bootstrap a fresh installation

A newly generated NixOS installation may not yet enable the `nix-command` and `flakes` experimental features. 
Clone this repository, then use a one-command environment override for the first switch:

```bash
# prefer bootstrap with root, since root is the default trusted user to make caches works
NIX_CONFIG="experimental-features = nix-command flakes" \
  sudo nixos-rebuild switch --flake .#nixos --accept-flake-config
```

The activated configuration enables both features, so later rebuilds no longer need the override:

```bash
nh os switch
```

