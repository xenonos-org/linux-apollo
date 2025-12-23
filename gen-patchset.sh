#!/bin/bash

declare -A patches=(
    [linux-hardened]="linux-hardened.patch"
    [grapheneos]="grapheneos.patch"
    [linux-openpax]="linux-openpax.patch"
    [linux-apollo]="linux-apollo.patch"
)

for dir in "${!patches[@]}"; do
    if [[ -d $dir ]]; then
        cat "$dir"/* > "${patches[$dir]}"
    else
        echo "Warning: Directory '$dir' does not exist."
    fi
done

final_patch="linux-apollo-patchset.patch"
cat "${patches[@]}" > "$final_patch"
rm "${patches[@]}"
gpg --sign "$final_patch"
