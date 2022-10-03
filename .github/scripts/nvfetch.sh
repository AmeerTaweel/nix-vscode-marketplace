name=$NAME
block_size=$BLOCK_SIZE

file=nvfetch/$name.toml

mkdir -p tmp
tmp=tmp/$name.toml

wc=$(nix build --print-out-paths --no-link nixpkgs#uwc)/bin/uwc
nvfetcher=$(nix build --print-out-paths --no-link github:berberman/nvfetcher)/bin/nvfetcher
awk=$(nix build --print-out-paths --no-link nixpkgs#gawk)/bin/awk

let "count = $(cat $file | awk '/\[/{++a}END{print a}') / 2 / $block_size + 1"

echo $BLOCK_SIZE
echo $count

for i in $(seq $count);
do
    let "block = i * $block_size * 2"
    printf "\n\n[ block: %s  ]\n\n" $i
    cat nvfetch/$name.toml | gawk -v num=$block '/\[/ {++a} {if (a <= num) {print}}' > $tmp
    # https://github.com/berberman/nvfetcher#cli
    nvfetcher -j 0 -o generated/$name -c $tmp -t
done