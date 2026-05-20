#!/bin/bash

confirm() {
    local message="${1:-Are you sure?}"

    printf "%s (y/n): " "$message"
    read -r response

    [[ "$response" =~ ^[Yy]$ ]]
}
