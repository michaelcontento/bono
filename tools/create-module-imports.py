#!/usr/bin/env python

from path import path
from jinja2 import Template
import sys

SKIP_DIRS = ["native"]
NON_AUTOLOAD_MODULES = ["ads", "analytics"]
MONKEY = Template("""Strict

Public

{% for filename in filenames -%}
Import {{ module }}.{{ filename }}
{% endfor %}""")


def walkdir(dirpath, proc_func, rec_func):
    def is_valid_dir(dirpath):
        if dirpath.islink():
            return False
        if dirpath.name.startswith(".") or dirpath.name in SKIP_DIRS:
            return False
        return True

    [rec_func(dirpath / x.name) for x in dirpath.dirs() if is_valid_dir(x)]
    proc_func(dirpath)


def create_import_files(dirname):
    def process(dirpath):
        filenames = [x.stripext().name for x in dirpath.files()]
        rendered = MONKEY.render(filenames=filenames, module=dirpath.name)
        (dirpath + ".monkey").write_text(rendered)

    walkdir(path(dirname), process, create_import_files)


def add_reflection_rule():
    def replace_public(instr):
        return instr.replace(
            "Public",
            "Public\n\n#REFLECTION_FILTER+=\"*test|*src.tests*\"")

    filepath = path("src/tests.monkey")
    filepath.write_text(replace_public(filepath.text()))


def remove_non_autoload_modules():
    def is_autoload(importstr):
        for checkstr in NON_AUTOLOAD_MODULES:
            if checkstr in importstr:
                return False
        return True

    filepath = path("src.monkey")
    filepath.write_lines([x for x in filepath.lines() if is_autoload(x)])


def create_symlinks(dirname):
    def process(dirpath):
        levels = len(dirpath.splitall()) - 1
        des = dirpath / "bono"
        if des.exists():
            des.remove()
        path("../" * levels).symlink(dirpath / "bono")

    walkdir(path(dirname), process, create_symlinks)


if __name__ == "__main__":
    create_import_files("src")
    create_import_files("tests")
    create_symlinks("src")
    add_reflection_rule()
    remove_non_autoload_modules()

    path("src.monkey").rename("bono.monkey")
    path("tests.monkey").rename("testimport.monkey")
    path("src/bono").remove()
