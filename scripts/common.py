from pathlib import Path
import shutil
from textwrap import dedent

BLOCK_DIR = "blocks"
ENCODING = "utf-8"
GENERATED = "generated"


def write_file(f, txt):
    with f.open("w", encoding=ENCODING) as g:
        g.write(txt)


def clean_file(f):
    write_file(f, "")


def set_head(f, head_length, text):
    g = Path(f"{f}.copy")
    with f.open("r", encoding=ENCODING) as f_:
        with g.open("w", encoding=ENCODING) as g_:
            for _ in range(head_length):
                _ = f_.readline()
            tail = f_.read()
            g_.write(text)
            g_.write(tail)

    shutil.copy(g, f)
    g.unlink()


def append_json(acc, block):
    acc_tmp = acc.parents[0] / f"{acc.stem}.tmp.json"
    clean_file(acc_tmp)
    with acc.open("r", encoding=ENCODING) as aj, acc_tmp.open(
        "a", encoding=ENCODING
    ) as atj, block.open("r", encoding=ENCODING) as bjg:
        atj.writelines(aj.readlines()[:-1])
        atj.write(",\n")
        atj.writelines(bjg.readlines()[1:])

    shutil.copy(acc_tmp, acc)


def append_nix(acc, block):
    acc_tmp = acc.parents[0] / f"{acc.stem}.tmp.nix"
    clean_file(acc_tmp)
    with acc.open("r", encoding=ENCODING) as an, acc_tmp.open(
        "a", encoding=ENCODING
    ) as atn, block.open("r", encoding=ENCODING) as bng:
        atn.writelines(an.readlines()[:-1])
        atn.writelines("\n")
        atn.writelines(bng.readlines()[3:])

    shutil.copy(acc_tmp, acc)

nix_head = dedent(
    """\
    # This file was generated by nvfetcher, please do not modify it manually.
    { fetchgit, fetchurl, fetchFromGitHub }:
    {
    """
)