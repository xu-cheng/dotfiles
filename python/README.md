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
brew install numpy --env=std
brew install scipy --env=std
brew install matplotlib --with-ghostscript --with-pyqt --with-pyside --with-tcl-tk --with-tex
pip install pygments pyzmq requests pandas sympy nose cython ipython
```
