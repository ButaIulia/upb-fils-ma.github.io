#!/bin/bash

for slides in $(basename -a $(find lectures/* -maxdepth 0 -type d)); do
    if [ $slides != "assets" ]; then
        echo "Building slides $slides"
        ln -s ../assets/global-bottom.vue lectures/$slides/global-bottom.vue
        npm run build -- lectures/$slides/slides.md --base /slides/$slides --out ../../../static/slides/$slides
        fail=$?
        rm lectures/$slides/global-bottom.vue
        if [ $fail != 0 ]; then
            echo "Failed to build slides $slides"
            exit $fail
        fi
    fi
done
