{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  cfg = config.batteries;
in

with lib;
{
  options.batteries.enable = mkEnableOption "Batteries";

  config = mkIf cfg.enable {

    # batteries
    # CPU performance scaling
    services.thermald.enable = true;
    services.power-profiles-daemon.enable = true;

    # direnv
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };

    # Power management
    powerManagement = {
      enable = true;
      powertop.enable = true;
    };

    # Bluetooth tools
    hardware.bluetooth.enable = true;

    # Zsh
    programs.starship.enable = true;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "z"
        ];
      };

      shellAliases = {
        ll = "ls -l";
        edit = "sudo -e";
        update = "sudo nixos-rebuild switch";
        allow = "direnv allow";
        reload = "direnv reload";
        open = "xdg-open";
      };
    };

    # VERY NEEDED FONTS
    fonts.packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      inputs.apple-fonts.packages.${pkgs.system}.sf-pro
      inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd
    ];
  };
}
