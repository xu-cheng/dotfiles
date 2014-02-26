Python Settings
===============

## Install Basic Python Environment

```bash
brew install python
brew install python3
brew install pyenv-virtualenv
pip install virtualenvwrapper
```

## Install Scientific Python Environment

```bash
brew tap homebrew/python
brew tap homebrew/science
brew install gfortran pyqt pyside ghostscript freetype zmq
pip install nose python-dateutil pyparsing
brew install numpy --with-python3
brew install scipy --with-python3
brew install matplotlib --with-ghostscript --with-pyqt --with-pyside --with-tcl-tk --with-tex
pip install pygments pyzmq requests pandas sympy cython ipython jinja2 tornado
```
