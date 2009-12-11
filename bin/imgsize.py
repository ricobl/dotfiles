#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
from PIL import ImageFile as PILImageFile

def die():
    raise SystemExit

def get_image_dimensions(filepath):
    """
    Returns the (width, height) of an image, given an open file or a path.

    Adapted from django.core.files.image.
    """
    p = PILImageFile.Parser()
    file = open(filepath, 'rb')
    try:
        while True:
            data = file.read(1024)
            if not data:
                break
            p.feed(data)
            if p.image:
                return p.image.size
        return None
    finally:
        file.close()

if __name__ == '__main__':
    
    # Check for the right number of arguments
    if len(sys.argv) < 3:
        die()

    args = sys.argv[1:]
    files = [f for f in args if not f.startswith('-')]
    params = [f for f in args if f.startswith('-')]

    for f in files:
        # Check for an existent file
        if not os.path.isfile(f):
            die()

        size = get_image_dimensions(f)

        # Print the dimensions
        if '-f' in params:
            print '%s: ' % f,
        if '-w' in params:
            print size[0],
        if '-h' in params:
            print size[1],

        # Skip one line
        print ''

