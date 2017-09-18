#!/bin/bash

THIS_DIR="$(dirname "$( readlink -f "${0}" 2>/dev/null || \
  python -c "import os,sys; print(os.path.realpath(sys.argv[1]))" "${0}" )")"

set -e

docker run \
       --rm -ti --name stardog --net=host stardog "$@"
