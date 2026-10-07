{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      enter_accept = true;
      inline_height = 10;
      history_filter = [
        "ls"
        "pwd"
        "z"
        "zi"
      ];
    };
  };
}
