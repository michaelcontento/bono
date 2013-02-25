#!/usr/bin/env python

from path import path
from jinja2 import Template
import sys

SKIP_DIRS = ["native"]
SKIP_FILES = ["README"]
NON_AUTOLOAD_MODULES = ["ads", "analytics", "payment"]
NON_AUTOLOAD_FILES = {
    "payment": [
        "paymentproviderandroidgoogle",
        "paymentproviderandroidamazon",
        "paymentproviderandroidsamsung",
        "paymentproviderappleios",
        "paymentproviderautounlock"
    ]
}
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
    def is_valid(module, filename):
        if filename.startswith(".") or filename in SKIP_FILES:
            return False

        try:
            return filename not in NON_AUTOLOAD_FILES[module]
        except:
            return True

    def process(dirpath):
        filenames = [x.stripext().name for x in dirpath.files()]
        filenames = [x for x in filenames if is_valid(dirpath.name, x)]
        module = "bono." + dirpath.replace("/", ".")
        rendered = MONKEY.render(filenames=filenames, module=module)
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


if __name__ == "__main__":
    create_import_files("src")
    create_import_files("tests")
    add_reflection_rule()
    remove_non_autoload_modules()

    path("src.monkey").rename("bono.monkey")
    path("tests.monkey").rename("testimport.monkey")
