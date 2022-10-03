#!/bin/bash
name=$NAME
block_size=$BLOCK_SIZE

file=nvfetch/$name.toml

mkdir -p tmp
tmp=tmp/$name.toml

# nix build
# export wc=$(nix build --print-out-paths --no-link nixpkgs#uwc)/bin/uwc
# echo $wc
# export nvfetcher=$(nix build --print-out-paths --no-link github:berberman/nvfetcher)/bin/nvfetcher
# echo $nvfetcher
nix profile install nixpkgs#gawk nixpkgs#nvfetcher nixpkgs#wc
nix profile install nixpkgs#nvfetcher
nix profile install nixpkgs

echo $(which awk)

# export awk=$(nix build --print-out-paths --no-link nixpkgs#gawk)/bin/awk
# echo $awk

let "count = $(cat $file | awk '/\[/{++a}END{print a}') / 2 / $block_size + 1"

echo $BLOCK_SIZE
echo $count

for i in $(seq $count);
do
    let "block = i * $block_size * 2"
    printf "\n\n[ block: %s  ]\n\n" $i
    cat nvfetch/$name.toml | awk -v num=$block '/\[/ {++a} {if (a <= num) {print}}' > $tmp
    # https://github.com/berberman/nvfetcher#cli
    nvfetcher -j 0 -o generated/$name -c $tmp -t
done