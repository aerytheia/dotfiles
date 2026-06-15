{ self, inputs, ... }: {
  flake.nixosModules.firefox = { ... }: {
    programs.thunderbird = {
      enable = true;

      preferences = {
        
      };

      policies = {
        DisableTelemetry = true;
      };
    };

    programs.firefox = {
      enable = true;

      preferences = {
        # ai junk
        "browser.ai.control.default" = "blocked";
        "browser.ai.control.linkPreviewKeyPoints" = "blocked";
        "browser.ai.control.pdfjsAltText" = "blocked";
        "browser.ai.control.sidebarChatbot" = "blocked";
        "browser.ai.control.smartTabGroups" = "blocked";
        "browser.ai.control.translations" = "blocked";
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.page" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.tabs.groups.smart.userEnabled" = false;
        "browser.translations.enable" = false;
        "extensions.ml.enabled" = false;
        "pdfjs.enableAltText" = false;   


        # tweaks    
        "browser.tabs.firefox-view" = false;
        "browser.urlbar.scotchBonnet.enableOverride" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        
      };

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DontCheckDefaultBrowser = true;
        DisablePocket = true;

        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };

        SearchEngines = {
          Remove = [
            "eBay"
            "Bing"
            "Ecosia"
            "Wikipedia (en)"
            "Perplexity"
            "DuckDuckGo"
            "Bookmarks"
            "Tabs"
            "History"
          ];
        };
      };
    };
  };
}