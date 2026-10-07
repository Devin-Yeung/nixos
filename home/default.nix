{
  imports = [
    ./agents
    ./zsh
    ./vcs
    ./fonts.nix
    ./starship.nix
    ./ghostty.nix
    ./nvim.nix
    ./nh.nix
    ./atuin.nix
  ];

  home.username = "ycg";
  home.homeDirectory = "/home/ycg";

  # Do not change after the first activation without reviewing the
  # Home Manager release notes.
  home.stateVersion = "26.05";
}
