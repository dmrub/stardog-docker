#!/bin/bash

THIS_DIR="$(dirname "$( readlink -f "${0}" 2>/dev/null || \
  python -c "import os,sys; print(os.path.realpath(sys.argv[1]))" "${0}" )")"

IMAGE=stardog
set -xe
docker build -t $IMAGE -f Dockerfile "$THIS_DIR"
echo "Built $IMAGE image"
