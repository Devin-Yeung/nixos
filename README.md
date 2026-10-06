# NixOS configuration

## Bootstrap a fresh installation

A newly generated NixOS installation may not yet enable the `nix-command` and `flakes` experimental features. 
Clone this repository, then use a one-command environment override for the first switch:

```bash
NIX_CONFIG="experimental-features = nix-command flakes" \
  nix run 'nixpkgs#nh' -- os switch . --accept-flake-config
```

The activated configuration enables both features, so later rebuilds no longer need the override:

```bash
nh os switch
```

