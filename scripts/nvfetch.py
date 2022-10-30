import argparse
import sys
from pathlib import Path
import subprocess
import shutil
from textwrap import dedent

my_parser = argparse.ArgumentParser(prog="run-nvfetcher", description="Run nvfetcher")

my_parser.add_argument(
    "--name",
    metavar="STRING",
    type=str,
    help="Name of target marketplace",
    default="vscode-marketplace",
)

my_parser.add_argument(
    "--block-size",
    metavar="NUMBER",
    type=int,
    help="How many extensions (size of a block) to fetch before writing the file",
    default=3,
)

my_parser.add_argument(
    "--block-limit",
    metavar="NUMBER",
    type=int,
    help="How many blocks to fetch in total",
    default=2,
)

my_parser.add_argument(
    "--first-block",
    metavar="NUMBER",
    type=int,
    help="Number of the first block",
    default=1,
)

my_parser.add_argument(
    "--out-dir",
    metavar="PATH",
    type=str,
    help="Where to write the generated files",
    default="tmp/out",
)

my_parser.add_argument(
    "--threads",
    metavar="NUMBER",
    type=int,
    help="Where to write the generated files",
    default=40,
)

my_parser.add_argument(
    "--json-init",
    metavar="PATH",
    type=str,
    help="A .json file for generated.json initialization",
    default=None,
)

my_parser.add_argument(
    "--nix-init",
    metavar="PATH",
    type=str,
    help="A .nix file for generated.nix initialization",
    default=None,
)

args = my_parser.parse_args()

name = args.name
block_size = args.block_size
block_limit = args.block_limit
# 0-base
first_block = args.first_block - 1
out = args.out_dir
threads = args.threads
json_init = args.json_init
nix_init = args.nix_init

if json_init !=None and not Path(json_init).exists():
    print(
        f"Error: file {json_init} was selected for initialization, but it doesn't exist"
    )
    sys.exit()

if nix_init != None and not Path(nix_init).exists():
    print(
        f"Error: file {nix_init} was selected for initialization, but it doesn't exist"
    )
    sys.exit()

def write_file(f, txt):
    with f.open("w", encoding=ENCODING) as g:
        g.write(txt)


def clean_file(f):
    write_file(f, "")


if __name__ == "__main__":
    # prepare paths

    ENCODING = "utf-8"
    nvfetch = Path("nvfetch")
    generated = Path("generated")
    toml_file = nvfetch / f"{name}.toml"
    dir_generated = generated / name
    generated_json = dir_generated / "generated.json"
    generated_nix = dir_generated / "generated.nix"

    tmp = Path("tmp")
    block_json_generated = tmp / generated_json
    block_nix_generated = tmp / generated_nix

    block_toml = tmp / f"{name}.toml"

    tmp_generated = tmp / dir_generated
    tmp_generated.mkdir(parents=True, exist_ok=True)

    # Initialize generated files
    acc_json = tmp_generated / "acc.json"
    if json_init != None:
        shutil.copy(json_init, acc_json)
    else:
        write_file(acc_json, '{"mempty" : {}\n}')

    acc_nix = tmp_generated / "acc.nix"
    if nix_init != None:
        shutil.copy(nix_init, acc_nix)
    else:
        write_file(acc_nix, '{mempty = {};\n}')

    # Temporary files location
    p = tmp / dir_generated
    p.mkdir(parents=True, exist_ok=True)

    # accumulators
    acc_tmp_json = tmp_generated / "acc.tmp.json"
    acc_tmp_nix = tmp_generated / "acc.tmp.nix"

    tmp_log = tmp / "log"
    tmp_log.mkdir(parents=True, exist_ok=True)

    # install missing software
    if shutil.which("nvfetcher") is None:
        process = subprocess.run(
            """nix profile install nixpkgs#gawk nixpkgs#nvfetcher nixpkgs#tree""",
            shell=True,
            check=True,
        )

    # stats

    extension_count: int = 0
    with toml_file.open("r", encoding=ENCODING) as tf:
        txt = tf.read()
        extension_count = int((txt.count("[")) / 2)

    number_blocks = int((extension_count + block_size) / block_size)

    last_block = (
        first_block - 1 + block_limit
        if block_size * (first_block + block_limit) <= extension_count
        else number_blocks - 1
    )

    extensions_to_load = min(
        (last_block - first_block + 1) * block_size,
        extension_count - (first_block * block_size),
    )

    def get_extensions_range(start, end):
        """1-base"""
        return start * block_size + 1, min((end + 1) * block_size, extension_count)

    def extensions_range_str(first_block_, last_block_):
        start, end = get_extensions_range(first_block_, last_block_)
        return f"extensions: {start} ... {end}"

    block_start_label = "┌----------┐"
    block_end_label = "└----------┘"
    print(block_start_label)
    print(f"total extensions: {extension_count}")
    print(f"block size: {block_size}")
    print(f"total #blocks: {number_blocks}")
    print(f"block limit: {block_limit}")
    print(f"first block: {first_block + 1}")
    print(f"last block: {last_block + 1}")

    if last_block < first_block:
        print("\nError: the first block should come before the last block")
        sys.exit()

    print(f"#extensions to load: {extensions_to_load}")
    print(extensions_range_str(first_block, last_block))
    print(block_end_label)

    for i in range(first_block, last_block + 1):
        print(block_start_label)
        print(f"block: {i + 1}")
        print(extensions_range_str(i, i))
        shutil.copy(generated_json, block_json_generated)
        start, end = get_extensions_range(i, i)

        start = (start - 1) * 2 + 1
        end = end * 2

        clean_file(block_toml)
        with toml_file.open("r", encoding=ENCODING) as tf, block_toml.open(
            "a", encoding=ENCODING
        ) as bt:
            bracket_counter = 0
            for j in tf:
                if j[0] == "[":
                    bracket_counter += 1
                if start <= bracket_counter <= end:
                    bt.write(j)

        block_log = tmp_log / f"block{i}.txt"
        subprocess.run(
            # f'printf "nvfetched\n"; touch {block_log}',
            f"nvfetcher -j {threads} -o {tmp_generated} -c {block_toml} -t > {block_log}",
            shell=True,
            check=True,
        )

        with block_log.open("r", encoding=ENCODING) as bl:
            fetch_url_count = 0
            check_count = 0
            for j in bl:
                if j.find("FetchUrl") != -1:
                    fetch_url_count += 1
                if j.find("Check") != -1:
                    check_count += 1

            print(f"fetched: {fetch_url_count}")
            print(f"checked: {check_count}")

        clean_file(acc_tmp_json)
        with acc_json.open("r", encoding=ENCODING) as aj, acc_tmp_json.open(
            "a", encoding=ENCODING
        ) as atj, block_json_generated.open("r", encoding=ENCODING) as bjg:
            atj.writelines(aj.readlines()[:-1])
            atj.write(",\n")
            atj.writelines(bjg.readlines()[1:])

        shutil.copy(acc_tmp_json, acc_json)

        clean_file(acc_tmp_nix)
        with acc_nix.open("r", encoding=ENCODING) as an, acc_tmp_nix.open(
            "a", encoding=ENCODING
        ) as atn, block_nix_generated.open("r", encoding=ENCODING) as bng:
            atn.writelines(an.readlines()[:-1])
            atn.writelines("\n")
            atn.writelines(bng.readlines()[3:])

        shutil.copy(acc_tmp_nix, acc_nix)

        print(block_end_label)
        # break

    def set_head(f, head_length, txt):
        g = Path(f"{f}.copy")
        with f.open("r", encoding=ENCODING) as f_:
            with g.open("w", encoding=ENCODING) as g_:
                for _ in range(head_length):
                    _ = f_.readline()
                tail = f_.read()
                g_.write(txt)
                g_.write(tail)

        shutil.copy(g, f)
        g.unlink()

    if json_init == None:
        set_head(acc_json, 2, "{\n")
    if nix_init == None:
        set_head(
            acc_nix,
            2,
            dedent(
                """\
            # This file was generated by nvfetcher, please do not modify it manually.
            { fetchgit, fetchurl, fetchFromGitHub }:
            {
            """
            ),
        )

    outdir = Path(out)
    out_generated_json = outdir / generated_json
    out_generated_json.parents[0].mkdir(parents=True, exist_ok=True)
    out_generated_nix = outdir / generated_nix
    out_generated_nix.parents[0].mkdir(parents=True, exist_ok=True)
    shutil.copy(acc_json, out_generated_json)
    shutil.copy(acc_nix, out_generated_nix)