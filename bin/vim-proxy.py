#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, subprocess

params = sys.argv[1:]
is_mac = 'darwin' in sys.platform.lower()
vim = is_mac and 'mvim' or 'gvim'

def run(*args):
    return subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

def capture(*args):
    output, error = run(*args).communicate()
    return output.strip()

def is_running():
    return capture(vim, '--serverlist') != ''

def open_vim(*args):
    run(vim, '--servername', 'VIM', *args)

def split_params(*params):
    params = set(params)
    commands = set([p for p in params if p.startswith('+')])
    files = commands.difference(params)

    return files, commands

def open_files(*args):
    open_vim('--remote-tab-silent', *args)

def activate():
    run('osascript', '-e', """tell application "MacVim" to activate""")

def new_tab():
    open_vim('--remote-send', '<Esc>:tabnew<CR>')
    activate()

if not params:
    if is_running():
        new_tab()
    else:
        open_vim()
else:
    open_files(*params)

