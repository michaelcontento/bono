#!/usr/bin/env python

from path import path
from jinja2 import Template

MONKEY = Template("""Strict

#REFLECTION_FILTER+="*test|*src.tests*"

Public

{% for module in modules -%}
Import {{ module }}
{% endfor %}""")


def modulize(filepath):
    return "bono." + filepath.stripext().replace("/", ".")


def autoload_module(module):
    for name in ("src.payment", "src.ads", "src.analytics"):
        if module.startswith("bono." + name):
            return False
    return True


def create_imports_for_dir(dirname):
    modules = [modulize(x) for x in path(dirname).walkfiles("*.monkey")]
    return MONKEY.render(modules=sorted(filter(autoload_module, modules)))


if __name__ == "__main__":
    path("bono.monkey").write_text(create_imports_for_dir("src"))
    path("testimport.monkey").write_text(create_imports_for_dir("tests"))
