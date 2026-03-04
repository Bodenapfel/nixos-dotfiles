{ ... }:

{
  home.username = "dk";
  home.homeDirectory = "/home/dk";

  imports = [
    ./modules/default.nix
  ];

  colorScheme = {
    slug = "nixbtw";
    name = "NixBtw";
    author = "dk";
    palette = {
      base00 = "202535"; # dark background
      base01 = "2d3348"; # lighter background
      base02 = "404862"; # selection
      base03 = "595959"; # inactive / comments
      base04 = "969696"; # grey
      base05 = "ffffff"; # foreground
      base06 = "e8eef8"; # light foreground
      base07 = "99c1f2"; # lightest (waybar workspace active)
      base08 = "cc3434"; # red
      base09 = "cc8822"; # orange
      base0a = "e8c547"; # yellow
      base0b = "508750"; # green
      base0c = "7ebae4"; # light blue (primary accent)
      base0d = "5277c3"; # blue (secondary accent)
      base0e = "9977c0"; # purple
      base0f = "7199de"; # extra blue (waybar dark-blue)
    };
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
