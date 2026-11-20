{ pkgs, inputs, config, ... }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};

    isabellePkgs = import inputs.nixpkgs-isabelle {
        system = pkgs.stdenv.hostPlatform.system;
        config.allowUnfree = true;
    };

    browser = pkgs.librewolf.override {
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


    otter-launcher = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
        pname = "otter-launcher";
        version = "v0.8.2";

        src = pkgs.fetchFromGitHub {
            owner = "kuokuo123";
            repo = "otter-launcher";
            tag = finalAttrs.version;
            hash = "sha256-UfBTQMR/vZ3XQJRX5XwIP+nMcB5qLQo0pBR1jvavmqg=";
        };

        cargoHash = "sha256-SlwIGNNUS64efRBAf3xrg7If6mn/ZGgeeBaNwut30Q4=";
    });

in {
    users.users.ethan = {
        shell = pkgs.zsh;

        isNormalUser = true;
        extraGroups = [
            "networkmanager"
            "wheel"
            "video"
            "audio"
        ];
    };

    programs.zsh.enable = true;

    nix.settings.trusted-users = [ "ethan" ];

    # ill figure this out later
    programs.spicetify = {
        enable = true;
    };

    hjem.users.ethan = { config, ... }: {
        directory = "/home/ethan";

        packages = with pkgs; [
            bitwarden-desktop
            hackneyed
            obsidian
            zathura
            gimp
            inkscape
            imagemagick
            # stremio-linux-shell
            vesktop

            browser

            mako
            grim
            slurp
            swayosd
            kanshi
            waybar
            wl-clipboard

            # inputs.matugen.packages.${stdenv.hostPlatform.system}.default        
            
            alacritty
            fuzzel
            fsel
            otter-launcher
            fastfetch
            git
            kdePackages.dolphin
            aria2
            nixd
            nixfmt

            wineWow64Packages.full
            winetricks

            (vscode-with-extensions.override {  
                vscode = vscodium;
                vscodeExtensions = with vscode-extensions; [
                    jnoortheen.nix-ide
                ];
            })

            prismlauncher
            vinegar
            (heroic.override {
                extraPkgs =
                pkgs': with pkgs'; [
                    gamescope
                    gamemode
                ];
            })

            isabellePkgs.isabelle        
        ];

        environment.sessionVariables = {
            SSH_AUTH_SOCK = "/home/ethan/.bitwarden-ssh-agent.sock";
            XCURSOR_THEME = "Hackneyed";
            SWAY_UNSUPPORTED_GPU = "true";
        };
        
        xdg.config.files = {
            "kanshi/config".source = ../home/kanshi/config;
            "sway/config".source = ../home/sway/config;
            "swayosd/config.toml".source = ../home/swayosd/config.toml;
            "swayosd/style.css".source = ../home/swayosd/style.css;
            "mako/config".source = ../home/mako/config;
        };

        files = {
            ".ssh/allowed_signers".source = ../home/ssh/allowed_signers;
            ".gitconfig".source = ../home/gitconfig;
            ".zshenv".source = config.environment.loadEnv;
        };
    };
}