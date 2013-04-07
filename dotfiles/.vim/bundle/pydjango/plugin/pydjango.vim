if !has('python')
    echo "Error: pydjango requires vim compiled with +python"
    finish
endif

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if os.environ['VIRTUAL_ENV']:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))

    # export DJANGO_SETTINGS_MODULE=project.settings
    os.environ['DJANGO_SETTINGS_MODULE']='settings'
EOF

