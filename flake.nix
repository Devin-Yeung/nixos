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
    nixpkgs-nightly.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.2605.*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };

    # Includes the Nixvim, Nixpkgs, and Neovim overlay revisions it was tested with.
    nvim-config.url = "github:Devin-Yeung/nvim.nix";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      pkgsNightly = import inputs.nixpkgs-nightly {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.curry = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs pkgsNightly; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/curry
        ];
      };
    };
}
