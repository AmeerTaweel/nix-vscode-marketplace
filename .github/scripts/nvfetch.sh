#!/bin/bash

# name of target marketplace
name=$NAME

# How many extensions to fetch before writing the file
block_size=$BLOCK_SIZE

# Total number of blocks to fetch
limit=${LIMIT:-5}

file=nvfetch/$name.toml

mkdir -p tmp
tmp=tmp/$name.toml

generated_dir=generated/$name

mkdir -p $generated_dir

full_generated=$generated_dir/full

full_json=$full_generated.json
touch $full_json

full_nix=$full_generated.nix
touch $full_nix

echo $full_nix

generated_json=$generated_dir/generated.json
generated_nix=$generated_dir/generated.nix

full_json_tmp=$full_json.tmp
full_nix_tmp=$full_nix.tmp


nix profile install nixpkgs#gawk nixpkgs#nvfetcher

let "count = $(cat $file | awk '/\[/{++a}END{print a}') / 2 / $block_size + 1"

echo "block size: $BLOCK_SIZE"
echo "#extensions: $count"

for i in $(seq 0 1 $count);
do
    let "block = i * $block_size * 2"

    if (( $i > $limit )); then break; fi

    let "next_block = (i + 1) * $block_size * 2"
    printf "\n\n[ block: %s  ]\n\n" $i
    cat nvfetch/$name.toml | awk -v start=$block -v end=$next_block '/\[/ {++a} {if (a > start && a <= end) {print}}' > $tmp

    # https://github.com/berberman/nvfetcher#cli
    nvfetcher -j 0 -o $generated_dir -c $tmp -t
    
    if [ $i == 0 ]; then 
        mv $generated_json $full_json;
        mv $generated_nix $full_nix;
    else
        head -n -1 $full_json > $full_json_tmp
        printf ",\n" >> $full_json_tmp
        tail +2 $generated_json >> $full_json_tmp
        mv $full_json_tmp $full_json
       
        head -n -1 $full_nix > $full_nix_tmp
        printf "\n" >> $full_nix_tmp
        tail -n +4 $generated_nix >> $full_nix_tmp
        mv $full_nix_tmp $full_nix
    fi
done

mv $full_json $generated_json
mv $full_nix $generated_nix