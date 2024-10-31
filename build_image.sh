#!/usr/bin/env bash

# Fail on a single failed command in a pipeline (if supported)
(set -o | grep -q pipefail) && set -o pipefail

# Fail on error and undefined vars
set -eu

# Globals
TEMP_BUILD_DIR=""
IMAGE_NAME=""
TAG=""
IMAGE_DOCKERFILE=""
TEST_IMAGE_SCRIPT="scripts/test-image.sh"
RUN_JAVA_SCRIPT="scripts/run-java.sh"
TEST_JAVA_APP="scripts/java-test-apps/jenvtest.class"

check_pre_req(){
    if [[ $# -ne 3 ]]; then
        # Check for correct number of arguments
        printhelp
        exit 1
    fi

    # check if Dockerfile exists 
    test -f "$1/Dockerfile" || die "Invalid docker dir '$1': directory doesn't contain Dockerfile."

    # Assign arguments to variables
    DIR="$1"
    IMAGE_NAME="$2"
    TAG="$3"

    TEMP_BUILD_DIR="/tmp/docker-base-image-build/$DIR-build-$(date +%s)"
    IMAGE_DOCKERFILE="$DIR/Dockerfile"

    # Check if the specified directory exists
    if [[ ! -d "$DIR" ]]; then
        echo "Error: Directory $DIR does not exist."
        exit 1
    fi

    # Check if the scripts directory exists
    if [[ ! -d "scripts" ]]; then
        echo "Error: Directory scripts does not exist."
        exit 1
    fi
}

create_tmp_build_dir() {
    echo "Preparing build dir @ $TEMP_BUILD_DIR"
    mkdir -p "$TEMP_BUILD_DIR"
}

cleanup_tmp_build_dir(){
    echo "Removing build dir @ $TEMP_BUILD_DIR"
    rm -rf "$TEMP_BUILD_DIR"
}

pre_build() {
    # create temp build dir
    create_tmp_build_dir

    echo "Copying files to temporary build directory..."
    # copy everything for image sub-dir into temp dir
    cp -r "$IMAGE_DOCKERFILE" "$TEMP_BUILD_DIR/Dockerfile"
    # copy test-image.sh 
    cp -r "$TEST_IMAGE_SCRIPT" "$TEMP_BUILD_DIR/test-image.sh"
    # copy run-java.sh 
    cp -r "$RUN_JAVA_SCRIPT" "$TEMP_BUILD_DIR/run-java.sh"
    # copy java-test-app
    cp -r "$TEST_JAVA_APP" "$TEMP_BUILD_DIR/jenvtest.class"
}

build() {
    # Build Docker image
    docker build -t "$IMAGE_NAME:$TAG" "$TEMP_BUILD_DIR"
    echo "Built Docker image $IMAGE_NAME:$TAG"
}

do_run() {
    # Check prerequisites and parse arguments
    check_pre_req "$@"

    # Do pre-build actions
    pre_build

    # Build the image and tag it
    build

    # Cleanup after yourself :)
    cleanup_tmp_build_dir
}

die() {
    echo "FATAL: $@" 1>&2
    exit 1
}

printhelp() {
    cat << EOF
This script simplifies image building and tagging from image bank.
Scripts need ./scripts subdir.

Usage: ./build_image.sh <image-bank-directory> <build-image-name> <image-tag>

EXAMPLES:

  # Build Docker image described in jre21/ directory
  ./build_image.sh jre21 my_docker_image latest

EOF
}

do_run "$@"