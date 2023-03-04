{ config, pkgs, ... }:

{
  home = {
    username = "wizu";
    homeDirectory = "/home/wizu";

  # Specify packages not explicitly configured below
    packages = with pkgs; [

    # Development
      tree-sitter
      cargo

    # Rust TUI/CLI Tools! I love rust.
      exa
      bat
      broot
      fd
      ripgrep
      bottom

    # GUI
      blackbox-terminal
      # aseprite

    # Language & Lsp
      nodejs # js
      marksman #  markdown lsp
      rnix-lsp # nix lsp
      sumneko-lua-language-server # lua lsp

      nodePackages.typescript # ts
      nodePackages.typescript-language-server # ts lsp
      nodePackages.vscode-langservers-extracted # 
      nodePackages.bash-language-server # bash lsp    

      nodePackages.pnpm
    
      thefuck
      # https://github.com/franciscolourenco/done
      fishPlugins.done
      # use babelfish than foreign-env
      fishPlugins.foreign-env
      # https://github.com/wfxr/forgit
      fishPlugins.forgit
      # Paired symbols in the command line
      fishPlugins.pisces
    ];

    stateVersion = "22.11";
  };  

  programs = {

    zoxide = {
      enable = true;
      enableFishIntegration = true;
   };

    tealdeer = {
      enable = true ;
      settings = {
        display = {
          compact = true;
        };
        updates = {
          auto_update = true;
        };
      };
    };

    git = {
      enable = true;
      userName = "wizunya";
      userEmail = "arifard49@gmail.com";
    };

    git.delta = {
      enable = true;
      options = {
	    features = "side-by-side line-numbers";
      };
    };

    helix = {
      enable = true;
      settings = {
        theme = "onedark";
        editor = {
          bufferline = "multiple";
          true-color = true;
          color-modes = true;
          cursorline = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides = {
            render = true;
            rainbow-option = "bright";
          };
          statusline = {
            left = ["mode" "spacer" "separator" "spacer" "spinner" "position-percentage" "spacer" "total-line-numbers"];
            center = ["file-name" "spacer" "diagnostics"];
            right = ["selections" "position" "file-type" "spacer"];
            separator = "|";
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };
          whitespace.characters = {
            newline = "↴";
            tab = "⇥";
          };
        };
      };
    };

    fish = {
      enable = true;
      shellAbbrs = {
        config = "hx ~/.config/nixpkgs/home.nix";
        update = "home-manager switch";
        l="exa -G --icons -s=type";
        lt="exa --icons -s=type --tree --level=2";
        q="exit";
      };
      interactiveShellInit = ''
        set fish_greeting # Disable greeting

        ${pkgs.thefuck}/bin/thefuck --alias | source
        
        # Fish color
        set -U fish_color_command 6CB6EB --bold
        set -U fish_color_redirection DEB974
        set -U fish_color_operator DEB974
        set -U fish_color_end C071D8 --bold
        set -U fish_color_error EC7279 --bold
        set -U fish_color_param 6CB6EB      
      '';
      plugins = with pkgs.fishPlugins;[
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
          };
        }
        {
          name = "thefuck";
          src = pkgs.fetchFromGitHub
            {
              owner = "oh-my-fish";
              repo = "plugin-thefuck";
              rev = "6c9a926d045dc404a11854a645917b368f78fc4d";
              sha256 = "1n6ibqcgsq1p8lblj334ym2qpdxwiyaahyybvpz93c8c9g4f9ipl";
            };
        }
      ];
    };

      starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        # add_newline = true;
        command_timeout = 1000;
        cmd_duration = {
          format = " [$duration]($style) ";
          style = "bold #EC7279";
          show_notifications = true;
        };
        nix_shell = {
          format = " [$symbol$state]($style) ";
        };
        git_branch = {
          format = "[$symbol$branch]($style) ";
        };
        gcloud = {
          format = "[$symbol$active]($style) ";
        };
      };
    };

    home-manager.enable = true;

  };
}
