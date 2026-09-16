{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.gnome;
in

with lib;
{

  imports = [
    ./dconf.nix
  ];

  options.gnome.enable = mkEnableOption "gnome";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Utility apps
      gnome-tweaks
      refine
      gnome-extension-manager

      # Themes the app titlebars
      qadwaitadecorations
      qadwaitadecorations-qt6
      # Themes the apps
      qgnomeplatform
      qgnomeplatform-qt6

      # Extentions
      gnomeExtensions.just-perfection
    ];

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };
  };
}
