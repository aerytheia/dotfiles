{ self, inputs, ... }: {
  flake.nixosModules.browser = { pkgs, ... }: {
    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;

      preferences = {
        # file picker
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        # UGLY !!!
        "browser.urlbar.scotchBonnet.enableOverride" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;

        # server side decorations
        "browser.tabs.inTitlebar" = 0;
        "browser.nova.enabled" = false;


        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [ ];
            unified-extensions-area = [
              "ublock0_raymondhill_net-browser-action"
            ];
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "customizableui-special-spring1"
              "vertical-spacer"
              "urlbar-container"
              "customizableui-special-spring2"
              "downloads-button"
              "fxa-toolbar-menu-button"
              "reset-pbm-toolbar-button"
              "unified-extensions-button"
            ];
            toolbar-menubar = [
              "menubar-items"
            ];
            TabsToolbar = [
              "tabbrowser-tabs"
              "new-tab-button"
              "customizableui-special-spring3"
              "smartwindow-group-tabs-button"
              "ai-window-toggle"
            ];
            vertical-tabs = [ ];
            PersonalToolbar = [
              "personal-bookmarks"
            ];
          };
          seen = [
            "reset-pbm-toolbar-button"
            "developer-button"
            "screenshot-button"
            "ublock0_raymondhill_net-browser-action"
          ];
          dirtyAreaCache = [
            "nav-bar"
            "TabsToolbar"
            "vertical-tabs"
            "toolbar-menubar"
            "PersonalToolbar"
            "unified-extensions-area"
          ];
          currentVersion = 26;
          newElementCount = 5;
        };
      };

      policies = {
        NoDefaultBookmarks = true;

        SearchEngines = {
          Add = [
            {
              Name = "Google";
              URLTemplate = "https://www.google.com/search?q={searchTerms}";
              IconURL = "https://www.google.com/favicon.ico";
            }
          ];

          Default = "Google";

          Remove = [
            "DuckDuckGo No-AI"
            "Mojeek"
            "Startpage"
            "Wikipedia (en)"
            "Bookmarks"
            "Tabs"
            "History"
            "Actions"
          ];

          "PreventInstalls" = true;
        };
      };
    };

    environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
  };
}
