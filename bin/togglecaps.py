#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from virtkey import virtkey

CAPS = 66

vk = virtkey()
state_toggles = {
    'on': vk.lock_mod,
    'off': vk.unlock_mod,
}

if len(sys.argv) <= 1:
    raise SystemExit

state = sys.argv[1]

if state not in state_toggles.keys():
    raise SystemExit

toggle = state_toggles[state]
toggle(CAPS)

