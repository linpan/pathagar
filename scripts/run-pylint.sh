#!/bin/bash

echo "========= PYTHON VERSION "$(python --version)
for file in $(git ls-files -- '*.py'); do
    echo "==== $file"
    python -m pylint --rcfile=pylintrc --load-plugins pylint_django --score=no --reports=no --disable=R,C $file
    RET=$? # pylint returns bitfield of found issues
    ERR=$(($RET&3)) # Fatal is 1 and Error is 2
    if [[ $ERR -ne 0 ]]; then
        echo "Aborting"
        exit 1
    fi
done

exit 0
