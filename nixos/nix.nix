{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.nur.overlays.default ];
  environment.systemPackages = with pkgs; [
    nix-index # locate nix packages with specific files
    nix-init # generate nix packages from url
    nix-update # update nix packages
    nurl # generate nix fetcher call
    nix-tree # useful for analyzing nix closure
    nix-search-cli # search nix packages from binary name
    nix-output-monitor # monitor nix build output
    nixfmt # format nix files
    nixd # nix lsp
    nil # nix lsp
  ];

  programs.nix-ld = {
    enable = true;
    libraries = [ ];
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];

    extra-substituters = [
      "https://cache.numtide.com"
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users = [
      "root"
      "ycg"
    ];
  };

  nixpkgs.config.allowUnfree = true;
}
