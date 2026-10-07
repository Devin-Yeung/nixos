{
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Batteries-included config from https://github.com/Devin-Yeung/nvim.nix.
    imports = [ "${inputs.nvim-config}/config" ];

    nixpkgs = {
      # Build Neovim from nvim-community's nightly overlay.
      overlays = [ inputs.neovim-nightly-overlay.overlays.default ];

      # Nixvim constructs its own nixpkgs instance, so the host's
      # `nixpkgs.config` does not carry over.
      config.allowUnfree = true;
    };
  };
}
