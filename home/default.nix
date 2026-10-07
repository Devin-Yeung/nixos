{
  imports = [
    ./agents
    ./zsh
    ./fonts.nix
    ./starship.nix
    ./ghostty.nix
    ./nvim.nix
    ./nh.nix
  ];

  home.username = "ycg";
  home.homeDirectory = "/home/ycg";

  # Do not change after the first activation without reviewing the
  # Home Manager release notes.
  home.stateVersion = "26.05";
}
