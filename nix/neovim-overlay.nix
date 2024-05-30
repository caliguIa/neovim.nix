# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{ inputs }:
final: prev:
with final.pkgs.lib;
let
  pkgs = final;
  pkgsStable = inputs.nixpkgs-stable.legacyPackages.${pkgs.system};

  # Use this to create a plugin from a flake input
  mkNvimPlugin =
    src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }
  all-plugins = with pkgs.vimPlugins; [
    # plugins from nixpkgs go in here.
    # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins

    # treesitter
    nvim-treesitter.withAllGrammars # https://github.com/nvim-treesitter/nvim-treesitter
    nvim-treesitter-context # nvim-treesitter-context | https://github.com/nvim-treesitter/nvim-treesitter-context
    tabout-nvim # https://github.com/abecodes/tabout.nvim/
    nvim-ts-autotag # https://github.com/windwp/nvim-ts-autotag/
    (mkNvimPlugin inputs.ts-comments-nvim "ts-comments-nvim") # https://github.com/folke/ts-comments.nvim

    # snippets
    luasnip # https://github.com/l3mon4d3/luasnip/

    # cmp
    nvim-cmp # https://github.com/hrsh7th/nvim-cmp
    cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip/
    lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/
    cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
    cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
    cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
    cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
    cmp-cmdline # cmp command line suggestions | https://github.com/hrsh7th/cmp-cmdline
    friendly-snippets # https://github.com/rafamadriz/friendly-snippets/
    copilot-cmp # https://github.com/zbirenbaum/copilot-cmp/

    # git
    diffview-nvim # https://github.com/sindrets/diffview.nvim/
    neogit # https://github.com/TimUntersberger/neogit/
    gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim/
    (mkNvimPlugin inputs.blame-nvim "blame-nvim") # https://github.com/FabijanZulj/blame.nvim

    # ui
    lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
    dashboard-nvim # Start screen | https://github.com/nvimdev/dashboard-nvim/
    dressing-nvim # https://github.com/stevearc/dressing.nvim/
    indent-blankline-nvim # https://github.com/lukas-reineke/indent-blankline.nvim/
    barbecue-nvim # https://github.com/utilyre/barbecue.nvim

    # lsp
    nvim-lspconfig # https://github.com/neovim/nvim-lspconfig/
    typescript-tools-nvim # https://github.com/pmizio/typescript-tools.nvim/
    (mkNvimPlugin inputs.corn-nvim "corn-nvim") # https://github.com/RaafatTurki/corn.nvim
    (mkNvimPlugin inputs.tsc-nvim "tsc-nvim") # https://github.com/dmmulroy/tsc.nvim
    (mkNvimPlugin inputs.ts-error-translator "ts-error-translator") # https://github.com/dmmulroy/ts-error-translator.nvim
    (mkNvimPlugin inputs.workspace-diagnostics "workspace-diagnostics") # https://github.com/artemave/workspace-diagnostics.nvim

    # linting and formatting
    conform-nvim # https://github.com/stevearc/conform.nvim/

    # testing
    neotest # https://github.com/nvim-neotest/neotest/
    neotest-jest # https://github.com/nvim-neotest/neotest-jest/
    neotest-phpunit # https://github.com/olimorris/neotest-phpunit/

    # coding
    copilot-lua # https://github.com/zbirenbaum/copilot.lua/
    # CopilotChat-nvim # https://github.com/CopilotC-Nvim/CopilotChat.nvim/

    # navigation/editing 
    flit-nvim # https://github.com/ggandor/flit.nvim/
    leap-nvim # https://github.com/ggandor/leap.nvim/
    fzf-lua # https://github.com/ibhagwan/fzf-lua/
    harpoon2 # https://github.com/ThePrimeagen/harpoon/
    nvim-hlslens # https://github.com/kevinhwang91/nvim-hlslens/
    oil-nvim # https://github.com/stevearc/oil.nvim/
    trouble-nvim # https://github.com/folke/trouble.nvim/
    undotree # https://github.com/mbbill/undotree/
    (mkNvimPlugin inputs.grug-far "grug-far") # https://github.com/MagicDuck/grug-far.nvim

    # utilities
    which-key-nvim # https://github.com/folke/which-key.nvim/
    mini-nvim # https://github.com/echasnovski/mini.nvim/
    persistence-nvim # https://github.com/folke/persistence.nvim/
    bigfile-nvim # https://github.com/LunarVim/bigfile.nvim/
    overseer-nvim # https://github.com/stevearc/overseer.nvim/
    nvim-bqf # https://github.com/kevinhwang91/nvim-bqf/
    (mkNvimPlugin inputs.url-open "url-open") # https://github.com/sontungexpt/url-open

    # colourschemes
    tokyonight-nvim # https://github.com/folke/tokyonight.nvim/

    # dependencies
    plenary-nvim
    nvim-web-devicons
    nvim-navic
    nvim-nio
    FixCursorHold-nvim
    fidget-nvim
    neodev-nvim
  ];

  extraPackages = [
    # lsp
    pkgs.lua-language-server
    pkgs.nil
    pkgs.nixd
    pkgs.statix
    pkgs.ocamlPackages.ocaml-lsp
    pkgs.eslint_d
    pkgs.nodePackages_latest.intelephense
    pkgs.nodePackages.typescript-language-server

    # formatters
    pkgs.stylua
    pkgs.prettierd
    pkgs.ocamlPackages.ocamlformat

    # tools
    pkgs.ripgrep
    pkgs.fd

    pkgsStable.nodePackages_latest.vscode-langservers-extracted
  ];
in
{
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json { plugins = all-plugins; };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}
