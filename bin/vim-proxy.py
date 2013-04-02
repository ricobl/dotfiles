#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, subprocess, os

params = sys.argv[1:]

IS_MAC = 'darwin' in sys.platform.lower()
VIM = IS_MAC and 'mvim' or 'gvim'
PWD = os.path.abspath(os.path.curdir)
# Use 2 parent dirs as servername
SERVER_NAME = '/'.join(PWD.split('/')[-2:]).upper()

def run(*args):
    return subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

def capture(*args):
    output, error = run(*args).communicate()
    return output.strip()

def is_running():
    return SERVER_NAME in capture(VIM, '--serverlist')

def open_vim(*args):
    run(VIM, '--servername', SERVER_NAME, *args)

def parse_command(command):
    return ':' + command.lstrip('+') + '<CR>'

def split_params(*params):
    files = []
    commands = []
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
    if IS_MAC:
        run('osascript', '-e', """tell application "MacVim" to activate""")
    else:
        run('xdotool', 'search', '--name', SERVER_NAME, 'windowactivate')

def new_tab():
    open_vim('--remote-send', '<Esc>:tabnew<CR>')

if not params:
    if is_running():
        new_tab()
    else:
        open_vim()
else:
    open_files(*params)
    # if is_running():
    #     activate()
