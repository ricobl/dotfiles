# -*- coding: utf-8 -*-

def activate():
    from os import environ
    if 'VIRTUAL_ENV' not in environ:
        return

    import sys
    import site
    from os.path import join

    virtual_env = join(environ.get('VIRTUAL_ENV'),
                    'lib',
                    'python%d.%d' % sys.version_info[:2],
                    'site-packages')

    # Remember original sys.path.
    prev_sys_path = list(sys.path)
    site.addsitedir(virtual_env)

    # Reorder sys.path so new directories at the front.
    new_sys_path = []
    for item in list(sys.path):
        if item not in prev_sys_path:
            new_sys_path.append(item)
            sys.path.remove(item)
    sys.path[1:1] = new_sys_path

    print 'VIRTUAL_ENV ->', virtual_env

activate()
