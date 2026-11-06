{ pkgs, ... }:

{

  # pair with users.user.<name>.shell
  programs.zsh.enable = true;

  # members of the wheel group can use sudo without a password
  security.sudo.wheelNeedsPassword = false;

  users.users.ycg = {
    isNormalUser = true;
    description = "ycg";
    # login shell
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8XHdKdevzEPL4Ndcb4uDfZwNhZVOqSE4Z1tKXZ6Ral"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjDdAsrLreBnd52Vxr1VQjpwnRljRVcxTOOyE3ah6uT"
    ];
  };
}
