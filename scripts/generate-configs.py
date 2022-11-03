import json
from scripts.common import write_file
import argparse
from pathlib import Path

my_parser = argparse.ArgumentParser(prog="generate-config", description="Generate GH Actions configs")

my_parser.add_argument(
    "--target",
    metavar="STRING",
    type=str,
    help="Target marketplace",
    default="vscode-marketplace",
)

my_parser.add_argument(
    "--marketplace",
    metavar="STRING",
    type=str,
    help="Pretty name of target marketplace",
    default="VSCode Marketplace",
)

my_parser.add_argument(
    "--approx-extensions",
    metavar="INT",
    type=int,
    help="Approximate number of extensions on the target",
    required=True
)


args = my_parser.parse_args()

APPROX_EXTENSIONS = args.approx_extensions
TARGET = args.target
MARKETPLACE = args.marketplace
BLOCK_SIZE = 100
BLOCK_LIMIT = 25
APPROX_BLOCKS = int((APPROX_EXTENSIONS + (BLOCK_SIZE * BLOCK_LIMIT)) / (BLOCK_SIZE * BLOCK_LIMIT))

include = [
    {
        "ACTION_ID": i + 1,
        "FIRST_BLOCK": i * BLOCK_LIMIT + 1,
        "MARKETPLACE": MARKETPLACE,
        "TARGET": TARGET,
        "BLOCK_SIZE": BLOCK_SIZE,
        "BLOCK_LIMIT": BLOCK_LIMIT,
    }
    for i in range(APPROX_BLOCKS)
]
NUMBER_JOBS = len(include) + 1

nvfetch = {
    "include": include,
}

configs_dir = Path(".github") / "workflows" / "configs" / TARGET
write_file(
    configs_dir / "nvfetch.json",
    str(json.dumps(nvfetch, indent=2)),
)

combine = {
    "include": [
        {
            "TARGET": TARGET,
            "MARKETPLACE": MARKETPLACE,
            "NUMBER_JOBS": NUMBER_JOBS,
        }
    ]
}

write_file(
    configs_dir / "combine.json",
    str(json.dumps(combine, indent=2)),
)
