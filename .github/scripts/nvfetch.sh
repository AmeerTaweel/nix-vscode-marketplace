#!/bin/bash

# set -euo pipefail

# Input environment

# name of target marketplace
name=$NAME

# How many extensions to fetch before writing the file
block_size=$BLOCK_SIZE

# Total number of blocks to fetch
limit=${LIMIT:-5}

out=${OUT:-"."}

# Prepare files

# Previous artifacts
toml_file=nvfetch/$name.toml

dir_generated=generated/$name
json_generated=$dir_generated/generated.json
nix_generated=$dir_generated/generated.nix

# Temp location
mkdir -p tmp
toml_block=tmp/$name.toml

dir_tmp_generated=tmp/$dir_generated
mkdir -p tmp/$dir_generated

# accumulator
json_acc=$dir_tmp_generated/acc.json
nix_acc=$dir_tmp_generated/acc.nix

json_acc_tmp=$dir_tmp_generated/acc.tmp.json
printf '{"mempty" : {}\n}' > $json_acc

nix_acc_tmp=$dir_tmp_generated/acc.tmp.nix
printf '{mempty = {};\n}' > $nix_acc

json_generated_block=tmp/$json_generated
nix_generated_block=tmp/$nix_generated

log_tmp=tmp/$dir_generated/logs
mkdir -p $log_tmp

# install programs
if [[ -z "$(which nvfetcher)" ]]; then
    echo here
    nix profile install nixpkgs#gawk nixpkgs#nvfetcher nixpkgs#tree
fi

# calculate
let "ext_count = $(cat $toml_file | awk '/\[/{++a}END{print a}') / 2"

echo "total #extensions: $ext_count"
echo "block size: $block_size"

let "blocks_n = (ext_count + block_size) / $block_size"
echo "total #blocks: $blocks_n"

let "block_limit = $block_size * $limit <= $ext_count ? $limit : $blocks_n"

echo "block limit: $block_limit"

let "ext_load = $block_size * $block_limit <= $ext_count ? $block_size * $block_limit : $ext_count"
echo "#extensions to load: $ext_load"

awk_print_block_toml='
    /\[/ {a++}
    {if (a > 2 * start && a <= 2 * end) {print}}'

for i in $(seq 1 1 $block_limit);
do
    # there are 2N opening square brackets (for awk matching)
    let "block = (i - 1) * $block_size"

    # if (( $i > $limit )); then break; fi

    let "next_block = i * $block_size"
    
    let "block_idx = $i"
    printf "\n\n[ block: %s; extensions %s...%s ]\n\n" $block_idx $(let "p = block + 1"; printf "$p") $next_block
    
    # tree $HOME
    # echo "extensions: $block...$next_block"
    
    # we can't read json blocks as json isn't aligned with toml
    # so, we simply copy the lookup json
    cat $json_generated > $json_generated_block
        
    cat $toml_file | awk -v start=$block -v end=$next_block "$awk_print_block_toml" > $toml_block

    # https://github.com/berberman/nvfetcher#cli
    block_log="$log_tmp/block$block_idx.txt"
    nvfetcher -j 0 -o $dir_tmp_generated -c $toml_block -t > $block_log
    
    cat $block_log | awk 'BEGIN{a=0; b=0}/FetchUrl/{ a++ }/Check/{b++}END{printf "fetched: %s\nchecked: %s\n", a, b}'

    head -n -1 $json_acc | sed -z '$ s/\n$//' > $json_acc_tmp
    printf ",\n" >> $json_acc_tmp
    tail -n +2 $json_generated_block >> $json_acc_tmp
    cat $json_acc_tmp > $json_acc

    head -n -1 $nix_acc > $nix_acc_tmp
    tail -n +4 $nix_generated_block >> $nix_acc_tmp
    cat $nix_acc_tmp > $nix_acc
done

mkdir -p $out
cat $json_acc | awk '/mempty/ { printf "{\n"; next} {print}' > $out/$json_generated
cat $nix_acc | awk '/mempty/ { printf "# This file was generated by nvfetcher, please do not modify it manually.\n{ fetchgit, fetchurl, fetchFromGitHub }:\n{\n"; next} {print}' > $out/$nix_generated