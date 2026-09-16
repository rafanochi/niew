{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.steam;
in

with lib;
{
  options.steam.enable = mkEnableOption "steam";

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
    };

    programs.steam.extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    programs.gamemode.enable = true;

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
  };
}
