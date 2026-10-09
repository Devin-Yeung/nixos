{
  services.mako = {
    enable = true;

    settings = {
      default-timeout = 5000;
      # Local notification styling only; do not set global app fonts/themes.
      font = "sans-serif 12";
      background-color = "#141820df";
      text-color = "#eef2f8";
      border-color = "#90b4ff66";
      border-size = 1;
      border-radius = 14;
      padding = "16";
      margin = "12";
      width = 360;
      max-visible = 4;
      anchor = "top-right";
      "urgency=critical" = {
        border-color = "#f38b8b";
        default-timeout = 0;
      };
    };
  };
}
