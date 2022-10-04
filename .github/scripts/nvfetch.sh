#!/bin/bash

# Input environment

# name of target marketplace
name=$NAME

# How many extensions to fetch before writing the file
block_size=$BLOCK_SIZE

# Total number of blocks to fetch
limit=${LIMIT:-5}


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

log_tmp=tmp/$dir_generated/log


# install programs
nix profile install nixpkgs#gawk nixpkgs#nvfetcher nixpkgs#tree

# calculate
let "ext_count = $(cat $toml_file | awk '/\[/{++a}END{print a}') / 2 / $block_size + 1"

echo "total #extensions: $ext_count"
echo "block size: $block_size"

let "blocks_n = (ext_count + block_size) / $block_size"
echo "total #blocks: $blocks_n"

echo "block limit: $limit"

let "ext_load = $block_size * $limit > $ext_count ? $ext_count : $block_size * $limit"
echo "#extensions to load: $ext_load"

awk_print_block_toml='
    /\[/ {a++}
    {if (a > 2 * start && a <= 2 * end) {print}}'


for i in $(seq 1 1 $limit);
do
    # there are 2N opening square brackets (for awk matching)
    let "block = (i - 1) * $block_size"

    # if (( $i > $limit )); then break; fi

    let "next_block = i * $block_size"
    
    let "block_idx = $i"
    printf "\n\n[ block: %s; extensions %s...%s ]\n\n" $block_idx $block $next_block
    
    tree $HOME
    # echo "extensions: $block...$next_block"
    
    # we can't read json blocks as json isn't aligned with toml
    # so, we simply copy the lookup json
    cat $json_generated > $json_generated_block
        
    cat $toml_file | awk -v start=$block -v end=$next_block "$awk_print_block_toml" > $toml_block

    # https://github.com/berberman/nvfetcher#cli
    nvfetcher -j 0 -o $dir_tmp_generated -c $toml_block -t > $log_tmp
    
    head -n -1 $json_acc | sed -z '$ s/\n$//' > $json_acc_tmp
    printf ",\n" >> $json_acc_tmp
    tail -n +2 $json_generated_block >> $json_acc_tmp
    cat $json_acc_tmp > $json_acc

    head -n -1 $nix_acc > $nix_acc_tmp
    tail -n +4 $nix_generated_block >> $nix_acc_tmp
    cat $nix_acc_tmp > $nix_acc
done

cat $json_acc | awk '/mempty/ { printf "{\n"; next} {print}' > $json_generated
cat $nix_acc | awk '/mempty/ { printf "{\n"; next} {print}' > $nix_generated