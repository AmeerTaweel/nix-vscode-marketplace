import json
from scripts.common import write_file

from pathlib import Path


APPROX_TOTAL = 55000
BLOCK_SIZE = 100
BLOCK_LIMIT = 10
TARGET = "vscode-marketplace"
NAME = "VSCode Marketplace"
ALLOW_NET = "marketplace.visualstudio.com"
APPROX_BLOCKS = int(APPROX_TOTAL / (BLOCK_SIZE * BLOCK_LIMIT))

include = [
    {"ACTION_ID": i + 1, "FIRST_BLOCK": i * BLOCK_LIMIT + 1}
    for i in range(APPROX_BLOCKS)
]
NUMBER_JOBS = len(include) + 1

nvfetch = {
    "ALLOW_NET": [ALLOW_NET],
    "NAME": [NAME],
    "TARGET": [TARGET],
    "BLOCK_SIZE": [BLOCK_SIZE],
    "BLOCK_LIMIT": [BLOCK_LIMIT],
    "include": include,
}

configs_dir = Path(".github") / "workflows" / "configs"
write_file(
    configs_dir / f"nvfetch-{TARGET}.json",
    str(json.dumps(nvfetch, indent=2)),
)

combine = {
    "include": [
        {
            "TARGET": [TARGET],
            "NAME": [NAME],
            "NUMBER_JOBS": [NUMBER_JOBS],
        }
    ]
}

write_file(
    configs_dir / f"combine-{TARGET}.json",
    str(json.dumps(combine, indent=2)),
)
