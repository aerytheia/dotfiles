{ self, inputs, ... }: {
  flake.nixosModules.browser = { pkgs, ... }: 
  let
    librewolf = pkgs.librewolf.override {
      extraPrefs = ''
        lockPref("widget.use-xdg-desktop-portal.file-picker", 1);

        lockPref("browser.urlbar.scotchBonnet.enableOverride", false);
        lockPref("browser.urlbar.shortcuts.bookmarks", false);
        lockPref("browser.urlbar.shortcuts.history", false);
        lockPref("browser.urlbar.shortcuts.tabs", false);
        lockPref("toolbars.bookmarks.visibility", "never");

        lockPref("browser.tabs.inTitlebar", 0);
        lockPref("browser.nova.enabled", false);

        lockPref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
        lockPref("media.videocontrols.picture-in-picture.audio-toggle.enabled", false);

        lockPref("privacy.resistFingerprinting", false);
        lockPref("privacy.fingerprintingProtection", true);
        lockPref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC");

        pref("browser.uiCustomization.state", {
          "placements": {
            "widget-overflow-fixed-list": [],
            "unified-extensions-area": [],
            "nav-bar": [
              "back-button",
              "forward-button",
              "stop-reload-button",
              "customizableui-special-spring1",
              "vertical-spacer",
              "urlbar-container",
              "customizableui-special-spring2",
              "downloads-button",
              "fxa-toolbar-menu-button",
              "reset-pbm-toolbar-button",
              "unified-extensions-button",
              "ublock0_raymondhill_net-browser-action"
            ],
            "toolbar-menubar": [
              "menubar-items"
            ],
            "TabsToolbar": [
              "tabbrowser-tabs",
              "new-tab-button",
              "customizableui-special-spring3",
              "smartwindow-group-tabs-button",
              "ai-window-toggle"
            ],
            "vertical-tabs": [],
            "PersonalToolbar": [
              "personal-bookmarks"
            ]
          },
          "seen": [
            "reset-pbm-toolbar-button",
            "developer-button",
            "screenshot-button",
            "ublock0_raymondhill_net-browser-action"
          ],
          "dirtyAreaCache": [
            "nav-bar",
            "TabsToolbar",
            "vertical-tabs",
            "toolbar-menubar",
            "PersonalToolbar"
          ],
          "currentVersion": 28,
          "newElementCount": 4
        });
      '';
      
      extraPolicies = {
        NoDefaultBookmarks = true;

        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };

        SearchEngines = {
          Add = [
            {
              Name = "DuckDuckGo";
              URLTemplate = "https://noai.duckduckgo.com/?q={searchTerms}";
              IconURL = "https://noai.duckduckgo.com/favicon.ico";
              SuggestURLTemplate = "https://noai.duckduckgo.com/ac/?q={searchTerms}&type=list";
            }
          ];

          Default = "DuckDuckGo";

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
  in {
    environment.systemPackages = [ 
      librewolf 
    ];
  };
}
