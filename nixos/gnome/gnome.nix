{ config, pkgs, lib, ... }:

let
  # 1) Boot a GNOME *Wayland* session once, set Displays to 280 Hz,
  #    then copy your ~/.config/monitors.xml contents into this string.
  gdmMonitorsXml = pkgs.writeText "monitors.xml" ''
    <monitors version="2">
      <configuration>
        <layoutmode>physical</layoutmode>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>1</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>DP-3</connector>
              <vendor>DEL</vendor>
              <product>DELL AW2723DF</product>
              <serial>GR7NNP3</serial>
            </monitorspec>
            <mode>
              <width>2560</width>
              <height>1440</height>
              <rate>279.958</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
    </monitors>
  '';
in
{
  #### Display manager + sessions
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  # You said you're installing GNOME (optional, but included)
  services.desktopManager.gnome.enable = true;

  # If you only want GNOME Shell (not the full app suite), uncomment:
  # services.gnome.core-apps.enable = false;
  # services.gnome.core-developer-tools.enable = false;
  # services.gnome.games.enable = false;

  #### Cursor theme (Breeze Light) for GDM + users (GNOME apps under Hyprland too)
  programs.dconf.enable = true;

  programs.dconf.profiles.gdm.databases = [{
    settings."org/gnome/desktop/interface" = {
      cursor-theme = "Breeze_Light";
      cursor-size  = lib.gvariant.mkInt32 24;
    };
    settings."org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = "-0.7";
    };
  }];

  programs.dconf.profiles.user.databases = [{
    settings."org/gnome/desktop/interface" = {
      cursor-theme = "Breeze_Light";
      cursor-size  = lib.gvariant.mkInt32 24;
    };
  }];

  # Make sure the cursor theme is actually installed system-wide (so GDM can see it)
  environment.systemPackages = with pkgs; [
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.breeze-gtk

    # Useful for generating ~/.config/monitors.xml (Displays panel)
    gnome-control-center

    # Keyring UI
    gnome-keyring
    seahorse
    gcr
    libsecret
  ];

  # Helps some non-GNOME apps pick it up too
  environment.sessionVariables = {
    XCURSOR_THEME = "Breeze_Light";
    XCURSOR_SIZE  = "24";
  };

  #### GNOME Keyring (PAM)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  #### GDM monitors.xml (for refresh rate, primary monitor, layout, etc.)
  # NixOS historically uses /run/gdm/.config; newer GDM/GNOME setups may also use /var/lib/gdm/seat0/config.
  systemd.tmpfiles.rules = [
    # Ensure dirs exist every boot
    "d /run/gdm 0700 gdm gdm - -"
    "d /run/gdm/.config 0700 gdm gdm - -"
    "L+ /run/gdm/.config/monitors.xml - - - - ${gdmMonitorsXml}"

    "d /var/lib/gdm/seat0/config 0700 gdm gdm - -"
    "L+ /var/lib/gdm/seat0/config/monitors.xml - - - - ${gdmMonitorsXml}"
  ];
}
