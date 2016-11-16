#! /bin/bash
set -eo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rsync -rupoE $dir/ /rootfs/
