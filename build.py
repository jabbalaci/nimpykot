#!/usr/bin/env python3

"""
pynt's build file
https://github.com/rags/pynt

Usage:

$ pynt
"""

import os
import shlex
import shutil
import sys
from pathlib import Path
from subprocess import PIPE, Popen

from pynt import task

def get_platform():
    text = sys.platform
    if text.startswith("linux"):
        return "linux"
    if text.startswith("win"):
        return "windows"
    # else
    raise RuntimeError("unknown platform")

platform = get_platform()


def remove_file(fname):
    if not os.path.exists(fname):
        print(f"{fname} doesn't exist")
        return
    #
    print(f"┌ start: remove {fname}")
    try:
        os.remove(fname)
    except:
        print("exception happened")
    print(f"└ end: remove {fname}")


def remove_directory(dname):
    if not os.path.exists(dname):
        print(f"{pretty(dname, True)} doesn't exist")
        return
    #
    print(f"┌ start: remove {pretty(dname)}")
    try:
        shutil.rmtree(dname)
    except:
        print("exception happened")
    print(f"└ end: remove {pretty(dname)}")


def call_external_command(cmd, verbose=True):
    if verbose:
        print(f"┌ start: calling external command '{cmd}'")
    os.system(cmd)
    if verbose:
        print(f"└ end: calling external command '{cmd}'")


def call_popen_with_env(cmd, env):
    print(f"┌ start: calling Popen with '{cmd}' in a custom environment")
    p = Popen(shlex.split(cmd), env=env)
    p.communicate()
    print(f"└ end: calling Popen with '{cmd}' in a custom environment")


def copytree(src, dst, symlinks=False, ignore=None):
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.isdir(s):
            shutil.copytree(s, d, symlinks, ignore)
        else:
            shutil.copy2(s, d)


def pretty(name, force=False):
    """
    If name is a directory, then add a trailing slash to it.
    """
    if name.endswith("/"):
        return name    # nothing to do
    # else
    if force:
        return f"{name}/"
    # else
    if not os.path.isdir(name):
        return name    # not a dir. => don't modify it
    # else
    return f"{name}/"


def copy_dir(src, dest):
    print(f"┌ start: copy {pretty(src)} -> {pretty(dest)}")
    shutil.copytree(src, dest)
    print(f"└ end: copy {pretty(src)} -> {pretty(dest)}")


def copy_file(src, dest):
    p = Path(dest)
    if not p.exists():
        p.mkdir(parents=True)
    print(f"┌ start: copy {src} -> {pretty(dest)}")
    shutil.copy(src, dest)
    print(f"└ end: copy {src} -> {pretty(dest)}")


def rename_file(src, dest):
    print(f"┌ start: rename {src} -> {dest}")
    shutil.move(src, dest)
    print(f"└ end: rename {src} -> {dest}")


def enter():
    print()
    try:
        input("Press ENTER to continue...")
    except KeyboardInterrupt:
        exit(1)


def commit_and_push():
    call_external_command("git status")
    enter()
    call_external_command("git add .")
    call_external_command("git status")
    enter()
    print()
    text = input("Commit text: ").strip()
    call_external_command(f"git commit -m '{text}'")
    enter()
    call_external_command("git push")
    call_external_command("git status")


###########
## Tasks ##
###########

@task()
def clean():
    """
    remove the compiled EXEs
    """
    remove_file("src/pykot")
    remove_file("tests/test_pykot")


@task()
def tests():
    """
    run tests
    """
    verbosity_level = 1    # 0, 1, 2, 3, default: 1
    cmd = f"nim c -r --verbosity:{verbosity_level} tests/test_pykot.nim"
    call_external_command(cmd)
    clean()


@task()
def doc():
    """
    generate doc
    """
    cmd = "nim doc src/pykot.nim"
    call_external_command(cmd)
    remove_file("docs/pykot.html")
    rename_file("src/pykot.html", "docs/")


@task()
def push():
    """
    commit and push your changes to GitHub
    """
    commit_and_push()
