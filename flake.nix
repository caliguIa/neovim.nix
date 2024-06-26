{
  description = "Neovim derivation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
    corn-nvim = {
      url = "github:RaafatTurki/corn.nvim";
      flake = false;
    };
    url-open = {
      url = "github:sontungexpt/url-open";
      flake = false;
    };
    tsc-nvim = {
      url = "github:dmmulroy/tsc.nvim";
      flake = false;
    };
    ts-comments-nvim = {
      url = "github:folke/ts-comments.nvim";
      flake = false;
    };
    ts-error-translator = {
      url = "github:dmmulroy/ts-error-translator.nvim";
      flake = false;
    };
    grug-far = {
      url = "github:MagicDuck/grug-far.nvim";
      flake = false;
    };
    blame-nvim = {
      url = "github:FabijanZulj/blame.nvim";
      flake = false;
    };
    workspace-diagnostics = {
      url = "github:artemave/workspace-diagnostics.nvim";
      flake = false;
    };
    fugit2 = {
      url = "github:SuperBo/fugit2.nvim";
      flake = false;
    };
    lazydev = {
      url = "github:folke/lazydev.nvim";
      flake = false;
    };
    melange = {
      url = "github:savq/melange-nvim";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      flake-utils,
      gen-luarc,
      ...
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      # This is where the Neovim derivation is built.
      neovim-overlay = import ./nix/neovim-overlay.nix { inherit inputs; };
    in
    flake-utils.lib.eachSystem supportedSystems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
          overlays = [
            # Import the overlay, so that the final Neovim derivation(s) can be accessed via pkgs.<nvim-pkg>
            neovim-overlay
            # This adds a function can be used to generate a .luarc.json
            # containing the Neovim API all plugins in the workspace directory.
            # The generated file can be symlinked in the devShell's shellHook.
            gen-luarc.overlays.default
          ];
        };
        shell = pkgs.mkShell {
          name = "nvim-devShell";
          buildInputs = with pkgs; [
            # Tools for Lua and Nix development, useful for editing files in this repo
            lua-language-server
            nil
            stylua
            luajitPackages.luacheck
          ];
          shellHook = ''
            # symlink the .luarc.json generated in the overlay
            ln -fs ${pkgs.nvim-luarc-json} .luarc.json
          '';
        };
      in
      {
        packages = rec {
          default = nvim;
          nvim = pkgs.nvim-pkg;
        };
        devShells = {
          default = shell;
        };
      }
    )
    // {
      # You can add this overlay to your NixOS configuration
      overlays.default = neovim-overlay;
    };
}
