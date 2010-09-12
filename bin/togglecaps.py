#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from virtkey import virtkey

CAPS = 66

state_toggles = {
    'on': 'lock_mod',
    'off': 'unlock_mod',
}

if len(sys.argv) <= 1:
    raise SystemExit

state = sys.argv[1]
if state not in state_toggles.keys():
    raise SystemExit

vk = virtkey()
toggle = getattr(vk, state_toggles[state])
toggle(CAPS)

