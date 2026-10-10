{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    seahorse
    libsecret
  ];
  # Provides the Secret Service on D-Bus. 1Password stores its account 2FA
  # token here; without a provider every unlock re-prompts for 2FA and fails
  # to remember the token ("unable to save your two-factor token").
  services.gnome.gnome-keyring.enable = true;
  # Unlock the keyring with the login password at SDDM sign-in.
  security.pam.services.sddm.enableGnomeKeyring = true;
}
