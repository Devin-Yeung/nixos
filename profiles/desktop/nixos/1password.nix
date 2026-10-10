{
  # Polkit agent prompts (e.g. 1Password auth) need this on any desktop.
  security.polkit.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "ycg" ];
  };
}
