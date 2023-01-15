**Moved to [nix-community/nix-vscode-extensions](https://github.com/nix-community/nix-vscode-extensions).**

# Nix VSCode Marketplace

At the time of writing this, searching `nixpkgs` yields around **200** VS Code extensions.
However, the VS Code marketplace contains more than **40,000** extensions!

This flake provides the Nix expressions for the majority of available extensions from [Open VSX](https://open-vsx.org/) and [VSCode Marketplace](https://marketplace.visualstudio.com/vscode).

A GitHub action updates the extensions daily.

## How To Use

Try a [template](https://github.com/deemp/flakes#codium-generic):

```console
nix flake new vscodium-project -t github:deemp/nix-vscode-extensions#vscodium-with-extensions
cd vscodium-project
git init && git add .
nix develop
```

## Contribute

1. (Optional) Start `VSCodium` with necessary extensions

   ```console
   nix develop nix-dev/
   write-settings-json
   codium .
   ```

1. Select `TARGET` in `flake.nix`, e.g., `open-vsx`. Comment out another target like so: `# export TARGET=vscode-marketplace`.

1. Export variables

    ```console
    nix develop
    ```

1. Run scripts in this environment

    ```console
    nix run .#scripts.generateConfigs
    ```

Improvement on any part of this project is welcome. These are possible areas of
improvement that I have in mind:

- License information is only included with OpenVSX extensions. This is because
I could not obtain license information from the official VSCode Marketplace API.
The official API is not documented at all, so I'm not sure if I can get license
information out of it or not.
- The Nix expressions that converts the output of Nvfetcher to package
definitions is not the most pretty Nix expressions ever.
- The GitHub action is not great either. I'm sure it can be way better, but I'm
not particularly good with actions (this is my first one ever).
