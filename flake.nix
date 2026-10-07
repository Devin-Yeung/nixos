{
  description = "NixOS configuration";

  nixConfig = {
    # Disallow Import From Derivation (IFD) so evaluation stays pure.
    allow-import-from-derivation = false;
    extra-substituters = [
      "https://cache.numtide.com"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2605.*.tar.gz";

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.2605.*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };

    # Keep nixvim on its own pinned nixpkgs: the shared config in nvim-config
    # tracks nixvim's unstable branch and uses options not in stable releases.
    nixvim = {
      url = "github:nix-community/nixvim";
    };

    # Not a flake: a plain Nixvim module tree consumed via `flake = false`.
    nvim-config = {
      url = "github:Devin-Yeung/nvim.nix";
      flake = false;
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations.curry = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/curry
        ];
      };
    };
}
