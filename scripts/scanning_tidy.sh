#!/bin/bash

# Delete image files older than the specified number of days and delete
# scanning directories whose names being with a defined company prefix.

# -- Internal variables -------------------------------------------------------

scan_dir="/data1/apps/scud"

file_max_age_days=7

dir_prefixes=(
    "0"
    "S"
    "N"
    "BR"
    "OC"
    "FC"
    "LP"
)

# -- General ------------------------------------------------------------------

delete_outdated_files () {
    find "${scan_dir}" -type f \( -name '*.TIF' -o -name '*.BSJ' \) -mtime +"${file_max_age_days}" -delete
    find "${scan_dir}" -type l -mtime +"${file_max_age_days}" -delete
}

delete_scannning_directories () {
    for prefix in "${dir_prefixes[@]}"; do
        find "${scan_dir}" -maxdepth 1 -type d -name "${prefix}"* -empty -delete
    done
}

# -- Entrypoint ---------------------------------------------------------------

main () {
    delete_outdated_files
    delete_scannning_directories
}

main "${@}"
