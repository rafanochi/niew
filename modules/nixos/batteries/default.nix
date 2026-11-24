# Here are configs that are not device nor user specific.
# These can be and should be used in all of them

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
    # direnv
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };

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
    fonts.packages = with inputs.apple-fonts.packages.${pkgs.system}; [
      sf-pro
      sf-mono-nerd
      ny-nerd
    ];

    environment.systemPackages = with pkgs; [
      evil-helix
      telegram-desktop
      git
      nixd
      nil
      qutebrowser
    ];
  };
}
