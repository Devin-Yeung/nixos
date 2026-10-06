{
  imports = [
    ./agents
    ./zsh
    ./starship.nix
    ./ghostty.nix
  ];

  home.username = "ycg";
  home.homeDirectory = "/home/ycg";

  # Do not change after the first activation without reviewing the
  # Home Manager release notes.
  home.stateVersion = "26.05";
}
