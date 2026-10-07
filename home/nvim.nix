{
  inputs,
  ...
}:

{
  imports = [ inputs.nvim-config.homeModules.default ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
