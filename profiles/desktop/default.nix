{
  imports = [ ./nixos ];

  # Keep the user-facing desktop configuration coupled to the system desktop
  # services, so hosts opt into both with this single profile import.
  home-manager.users.ycg.imports = [ ./home ];
}
