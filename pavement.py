# -*- coding: utf-8 -*-
import glob
import os
import sys

from paver.easy import *  # noqa
try:
    import paver.doctools  # noqa
except ImportError:
    pass
sys.path.append('.')


options(
    project=Bunch(
        name='tddmon',
        package_name='tddmon',
    ),
    sphinx=Bunch(
        builddir="_build",
        apidir=None,
    ),
)


@task
def cleanup():
    """ Removes generated files. """
    sh('rm -rf build', ignore_error=True)
    sh('rm -rf dist', ignore_error=True)
    sh('rm -rf */*.egg-info', ignore_error=True)
    sh('rm -rf htmlcov', ignore_error=True)
    sh('rm -rf docs/_build', ignore_error=True)
    sh('rm .coverage.*', ignore_error=True)
    sh("find . -name '*.pyc' -delete", ignore_error=True)
    sh("find . -name '__pycache__' -delete", ignore_error=True)


@task
def kwalitee(options):
    """ Check for kwalitee. """
    sh('flake8 src')
    sh('pep257 src', ignore_error=True)


@task
def sdist():
    """ Generate source distribution. """
    sh('python setup.py sdist -q')


@task
def bdist_wheel():
    """ Generate binary distribution. """
    sh('python setup.py bdist_wheel --universal -q')


@task
@needs('sdist', 'bdist_wheel')
def build():
    """ Build packages. """
    pass


@task
@needs('build')
def install_all(options):
    for dist_file in glob.glob('dist/*'):
        for pip_bin in glob.glob('.tox/*/bin/pip'):
            try:
                sh('%s install %s' % (pip_bin, dist_file))
                python_bin = pip_bin.replace('/pip', '/python')
                sh('%s -c "import %s"' % (python_bin, options.name))
            finally:
                sh('%s uninstall %s' % (pip_bin, dist_file), ignore_error=True)


@task
def coverage_all(options):
    sh('coverage erase')
    try:
        sh('tox')
    finally:
        sh('coverage combine')
        sh("coverage html --include='src/%s*'" % options.name)
        sh("coverage report --include='src/%s*' --fail-under=100" % options.name)


@task
@needs('cleanup', 'kwalitee', 'coverage_all', 'install_all', 'html')
def pre_release(options):
    """ Check project before release. """
    pass


@task
@cmdopts([
    ("path=", "p", "Docs path"),
])
@needs('cleanup', 'html')
def publish_docs(options):
    """ Uploads docs to server. """
    path = options.get('path', None)
    if path is None:
        path = os.environ.get('DOCS_PATH', '')
    sh('''sed -i '' 's/href="\(http:\/\/sphinx-doc.org\)/rel="nofollow" href="\\1"/' docs/_build/html/*.html''')
    sh('rsync -av docs/_build/html/ %s/%s/' % (path, options.package_name))


@task
def sign_dist(options):
    for distfile in glob.glob('dist/*'):
        if distfile.endswith('.tar.gz') or distfile.endswith('.whl'):
            sh('gpg --detach-sign -a %s' % distfile)


@task
def twine_upload(options):
    sh('twine upload dist/*')


@task
@needs('cleanup', 'build', 'html', 'sign_dist', 'twine_upload', 'publish_docs')
def release(options):
    """ Generate packages and upload to PyPI. """
    pass


@task
def tddmon(options):
    sh("tddmon -l test_run.log '-m unittest discover src'")
