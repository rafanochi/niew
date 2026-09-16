{ ... }:

{
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true; # prevents overriding
      settings = {
        "org/gnome/desktop/interface" = {
          accent-color = "purple";
        };
        "org/gnome/desktop/input-sources" = {
          xkb-options = [ "ctrl:nocaps" ];
        };
        "org/gnome/desktop/wm/keybindings" = {
          begin-resize = [ "<Super>r" ];
          move-to-workspace-left = [ "<Shift><Alt>h" ];
          move-to-workspace-right = [ "<Shift><Alt>l" ];
          show-desktop = [ "<Super>d" ];
          switch-to-workspace-left = [ "<Control><Alt>h" ];
          switch-to-workspace-right = [ "<Control><Alt>l" ];
        };
      };
    }
  ];
}
