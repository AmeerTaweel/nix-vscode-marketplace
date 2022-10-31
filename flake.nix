{
  description = "VSCode and OpenVSX Extensions Collection For Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        loadGenerated = set:
          with builtins; with pkgs; let
            generated = import ./generated/${set}/generated.nix {
              inherit fetchurl fetchFromGitHub;
              fetchgit = fetchGit;
            };

            groupedByPublisher = (groupBy (e: e.publisher) (attrValues generated));
            pkgDefinition = {
              open-vsx = e: with e; with vscode-utils; {
                inherit name;
                value = buildVscodeMarketplaceExtension {
                  vsix = src;
                  mktplcRef = {
                    inherit version;
                    publisher = marketplacePublisher;
                    name = marketplaceName;
                  };
                  meta = with lib; {
                    inherit changelog downloadPage homepage;
                    license = licenses.${license};
                  };
                };
              };
              vscode-marketplace = e: with e; with vscode-utils; {
                inherit name;
                value = buildVscodeMarketplaceExtension {
                  vsix = src;
                  mktplcRef = {
                    inherit version;
                    publisher = marketplacePublisher;
                    name = marketplaceName;
                  };
                };
              };
            };
          in
          mapAttrs (_: val: listToAttrs (map pkgDefinition.${set} val)) groupedByPublisher;

        extensions = {
          vscode = loadGenerated "vscode-marketplace";
          open-vsx = loadGenerated "open-vsx";
        };

        scripts = {
          nvfetch = pkgs.writeShellApplication {
            name = "fetch-extensions";
            runtimeInputs = [ pkgs.poetry ];
						text = ''
							poetry install
							dir="tmp/init"
              init_json="$dir/init.json"
              init_nix="$dir/init.nix"
							poetry run python scripts/nvfetch.py \
								--out "''${OUT_DIR:-.}" --name "$NAME" --first-block "$FIRST_BLOCK" \
								--block-size "$BLOCK_SIZE" --block-limit "$BLOCK_LIMIT" \
								--init-json "''${INIT_JSON:-$init_json}" --init-nix "''${INIT_NIX:-$init_nix}" \
                --threads "''${THREADS:-0}"
						'';
          };
        };

      in
      {
        devShell = pkgs.mkShell {
          shellHook = ''
                			export DENO_DIR="$(pwd)/.deno"
            					export BLOCK_SIZE=3
            					export BLOCK_LIMIT=2
											export FIRST_BLOCK=1
            					export NAME=vscode-marketplace
											export OUT_DIR=tmp/out
                      export THREADS=40
											export INIT_JSON=generated/vscode-marketplace/generated.json
											# export INIT_NIX=generated/vscode-marketplace/generated.nix
            			'';
          nativeBuildInputs = with pkgs; [
            deno
            nvfetcher
            gawk
            poetry
          ];
          buildInputs = [ ];
        };
        packages = extensions // {inherit scripts;};
        overlays.default = final: prev: {
          vscode-marketplace = extensions;
        };
      });
}
