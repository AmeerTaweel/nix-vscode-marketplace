import json
from scripts.common import write_file

from pathlib import Path


TOTAL = 55000
BLOCK_SIZE = 100
BLOCK_LIMIT = 10
TARGET = "vscode-marketplace"
CONFIG_TARGET = "vscode"
approx_blocks = int(TOTAL / (BLOCK_SIZE * BLOCK_LIMIT))
include = [
    {"ACTION_ID": i + 1, "FIRST_BLOCK": i * BLOCK_LIMIT + 1}
    for i in range(approx_blocks)
]
NUMBER_JOBS = len(include) + 1

t = {
    "ALLOW_NET": ["marketplace.visualstudio.com"],
    "NAME": ["VSCode Marketplace"],
    "TARGET": [TARGET],
    "BLOCK_SIZE": [BLOCK_SIZE],
    "BLOCK_LIMIT": [BLOCK_LIMIT],
    "NUMBER_JOBS": [NUMBER_JOBS],
    "include": include,
}

write_file(
    Path(".github") / "workflows" / "configs" / f"nvfetch-{TARGET}.json",
    str(json.dumps(t, indent=2)),
)
