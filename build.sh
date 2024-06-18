#!/bin/bash
set -euox pipefail

docker build --tag foo:bar . 
