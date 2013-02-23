#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, subprocess, os

params = sys.argv[1:]
is_mac = 'darwin' in sys.platform.lower()
vim = is_mac and 'mvim' or 'gvim'

def run(*args):
    return subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

def capture(*args):
    output, error = run(*args).communicate()
    return output.strip()

def is_running():
    servername = get_servername()
    return servername in capture(vim, '--serverlist')

def get_servername():
    curdir = os.path.abspath(os.path.curdir)
    servername = '/'.join(curdir.split('/')[-2:])
    return servername

def open_vim(*args):
    run(vim, '--servername', get_servername(), *args)

def parse_command(command):
    return ':' + command.lstrip('+') + '<CR>'

def split_params(*params):
    files = []
    commands = []
    vim_params = []

    for p in params:
        if p.startswith('-'):
            commands.append(p)
            continue
        if p.startswith('+'):
            commands += ['--remote-send', parse_command(p)]
            continue
        files.append(p)

    return files, commands

def open_files(*args):
    files, commands = split_params(*args)
    if files:
        open_vim('--remote-tab-silent', *files)
    if commands:
        open_vim(*commands)

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

