#!/usr/bin/env python3

"""
pynt's build file
https://github.com/rags/pynt

pynt is a minimalistic build tool, which is
* easy to learn / easy to use
* build tasks are just Python funtions
* automatically generates a command line interface

Installation:

$ sudo pip3 install pynt

Usage:

$ pynt
"""

import os
import shlex
from glob import glob
import shutil
import sys
from pathlib import Path
from subprocess import PIPE, Popen
import webbrowser

from pynt import task

BROWSER = "firefox"    # used for opening the doc


def get_platform():
    text = sys.platform
    if text.startswith("linux"):
        return "linux"
    if text.startswith("win"):
        return "windows"
    # else
    raise RuntimeError("unknown platform")

platform = get_platform()


def remove_file(fname, verbose=True):
    if not os.path.exists(fname):
        print(f"{fname} doesn't exist")
        return
    #
    if verbose:
        print(f"┌ start: remove {fname}")
    try:
        os.remove(fname)
    except:
        print("exception happened")
    if verbose:
        print(f"└ end: remove {fname}")


def remove_directory(dname):
    """
    Deletes the directory recursively, even if it's not empty!
    """
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


def rename_file(src, dest, overwrite=False):
    print(f"┌ start: rename {src} -> {dest}")
    if overwrite:
        if os.path.isfile(dest):
            os.remove(dest)
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


def rchop(s, sub):
    """
    Remove `sub` from the end of `s`.
    """
    return s[:-len(sub)] if s.endswith(sub) else s


def _traverse(root, li, skip_links):
    """
    A helper function for traverse(). Don't call this directly,
    use it through traverse().
    """
    everything = [os.path.join(root, e) for e in os.listdir(root)]
    if skip_links:
        everything = [e for e in everything if not os.path.islink(e)]
    li += everything
    for d in [e for e in everything if os.path.isdir(e)]:
        _traverse(os.path.abspath(os.path.join(root, d)), li, skip_links)
    #
    return li


def traverse(root, skip_links=True):
    """
    Traverse a directory recursively.

    Return all the items in the directory. Items are in absolute path.
    If skip_links is True, symbolic links are skipped.
    """
    entries = []
    return _traverse(os.path.abspath(root), entries, skip_links)


###########
## Tasks ##
###########

@task()
def _clean_folder(dir_name):
    """
    remove the compiled EXEs
    """
    nim_files = glob(f"{dir_name}/*.nim")
    without_exts = [rchop(f, ".nim") for f in nim_files]
    for fname in without_exts:
        exe = fname + ".exe"
        if os.path.isfile(fname):
            remove_file(fname, verbose=False)
        if os.path.isfile(exe):
            remove_file(exe, verbose=False)    # Windows support


@task()
def tests():
    """
    run tests
    """
    verbosity_level = 1    # 0, 1, 2, 3, default: 1
    # cmd = f"nim c -r --verbosity:{verbosity_level} tests/test_pykot.nim"
    cmd = "nimble test"
    call_external_command(cmd)
    _clean_folder("tests")


@task()
def doc():
    """
    generate doc
    """
    # traverse() returns absolute paths

    if True:
        # delete the docs/ folder
        remove_directory("docs/")

    if True:
        # generate HTML files (docs) for the source files
        # index files (.idx) are also created
        nim_files = [f for f in traverse("src/") if f.endswith(".nim")]
        for f in nim_files:
            p = Path(f)
            stem = p.stem    # /path/to/something.nim -> something (just filename without extension)
            cmd = f"nim doc --index:on -o:docs/htmldocs/{stem}.html {f}"
            call_external_command(cmd)
            #
            cmd = f"nim doc --docSeeSrcUrl:txt {f}"
            call_external_command(cmd)

    if True:
        # build theindex.html
        cmd = "nim buildIndex docs/htmldocs/"
        call_external_command(cmd)

    # if True:
    #     # rename theindex.html to index.html
    #     # for github pages it's better if it's called index.html
    #     rename_file("docs/theindex.html", "docs/index.html")

    if True:
        # move the .html files
        html_files = [f for f in traverse("docs/htmldocs/") if f.endswith(".html")]
        for f in html_files:
            p = Path(f)
            name = p.name
            rename_file(f, f"docs/{name}", overwrite=True)

    if True:
        # delete the docs/htmldocs/ folder
        remove_directory("docs/htmldocs/")

    if True:
        print()
        inp = input("Open theindex.html in your browser [y/N]? ").strip()
        if inp == "y":
            call_external_command(f"{BROWSER} docs/theindex.html")
            # call_external_command(f"{BROWSER} docs/index.html")    # it was renamed


@task()
def push():
    """
    commit and push your changes to GitHub
    """
    commit_and_push()
