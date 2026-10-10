{
  imports = [
    ./agents
    ./zsh
    ./vcs
    ./tmux
    ./starship.nix
    ./nvim.nix
    ./nh.nix
    ./atuin.nix
    ./zoxide.nix
    ./rust.nix
    ./pnpm.nix
  ];

  home.username = "ycg";
  home.homeDirectory = "/home/ycg";

  # Do not change after the first activation without reviewing the
  # Home Manager release notes.
  home.stateVersion = "26.05";
}
