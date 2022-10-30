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
							mkdir -p "$dir"
              init_json="$dir/init.json"
              init_nix="$dir/init.nix"
							printf '{"mempty" : {}\n}' > $init_json
							printf '{mempty = {};\n}' > $init_nix
							poetry run python scripts/nvfetch.py \
								--out "''${OUT:-.}" --name "$NAME" --first-block "$FIRST_BLOCK" \
								--block-size "$BLOCK_SIZE" --block-limit "$BLOCK_LIMIT" \
								--json-init "''${JSON_INIT:-$init_json}" --nix-init "''${NIX_INIT:-$init_nix}" \
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
											export OUT=tmp/out
                      export THREADS=40
											export JSON_INIT=generated/vscode-marketplace/generated.json
											export NIX_INIT=generated/vscode-marketplace/generated.nix
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
