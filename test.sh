#!/usr/bin/env bash

PYTHONPATH="$(pwd)/src:$(pwd)/resources/src" \
    py.test --cov-config=./.coveragerc \
            --cov-report=term-missing \
            --cov-branch \
            --cov=./src/ \
            --cov=./resources/src/ \
            --showlocals \
            --capture=fd \
            -vv \
            tests/ \
            $@
[[ $? != 0 ]] && echo "Tests failed!" >&2 && exit 1

if [[ -n "${COVERALLS_REPO_TOKEN}" ]]; then
    coveralls
    [[ $? != 0 ]] && echo "Coverage reporting failed!" >&2 && exit 1
fi

exit 0
