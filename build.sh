#!/usr/bin/env bash
set -e

setup_venv() {
    rm -rf venv/
    python3 -m venv venv | python -m venv venv
    source venv/bin/activate
    pip install --upgrade pip wheel setuptools
    pip install --editable .[TEST]
}

test() {
    pydocstyle homespeaker tests/
    pylint homespeaker/ tests/
    pytest --cov=homespeaker --cov-report html tests/
    coverage report --fail-under=100
}

build() {
    pip install --upgrade twine build
    python -m build
}

upload() {
    python -m twine upload --repository pypi dist/*
}

"$@"