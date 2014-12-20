sublime-settings
================

My Sublime Text 3 settings.

## Installation

* Use command below to install Package Control:

```python
import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())
```
* Copy files to `\path\to\Sublime Text 3\Packages`.

## Packages List

* UI:
    * [Predawn](https://sublime.wbond.net/packages/Predawn)

<!--
    * [Monokai Extended](https://sublime.wbond.net/packages/Monokai%20Extended)
    * [Theme - Soda](https://sublime.wbond.net/packages/Theme%20-%20Soda)
-->

* Enhancement:
    * [Vintageous](https://sublime.wbond.net/packages/Vintageous)
    * [Vintage Numbers](https://sublime.wbond.net/packages/Vintage%20Numbers)
    * [ConvertToUTF8](https://sublime.wbond.net/packages/ConvertToUTF8)
    * [Codecs33](https://sublime.wbond.net/packages/Codecs33)
    * [BracketHighlighter](https://sublime.wbond.net/packages/BracketHighlighter)
    * [WordHighlight](https://sublime.wbond.net/packages/WordHighlight)
* Coding Enhancement:
    * [Alignment](https://sublime.wbond.net/packages/Alignment)
    * [All Autocomplete](https://sublime.wbond.net/packages/All%20Autocomplete)
    * [Toggle the View Read-Only](https://sublime.wbond.net/packages/Toggle%20the%20View%20Read-Only)
    * [SublimeTmpl](https://sublime.wbond.net/packages/SublimeTmpl)
    * [SublimeLinter](https://sublime.wbond.net/packages/SublimeLinter)
    * [Sublime​Linter-annotations](https://sublime.wbond.net/packages/SublimeLinter-annotations)
    * [SublimeLinter-chktex](https://sublime.wbond.net/packages/SublimeLinter-chktex)
    * [SublimeLinter-json](https://sublime.wbond.net/packages/SublimeLinter-json)
    * [Syntax Manager](https://sublime.wbond.net/packages/Syntax%20Manager)
    * [FileSystem AutoCompletion](https://sublime.wbond.net/packages/FileSystem%20Autocompletion)
* Tools:
    * [Open URL](https://sublime.wbond.net/packages/Open%20URL)
    * [SideBarEnhancements](https://sublime.wbond.net/packages/SideBarEnhancements)
    * [PackageResourceViewer](https://sublime.wbond.net/packages/PackageResourceViewer)
    * [HexViewer](https://sublime.wbond.net/packages/HexViewer)
    * [SublimeREPL](https://sublime.wbond.net/packages/SublimeREPL)
    * [Cheat Sheets](https://sublime.wbond.net/packages/Cheat%20Sheets)
    * [Preference Helper](https://sublime.wbond.net/packages/Preference%20Helper)
    * [ScopeHunter](https://sublime.wbond.net/packages/ScopeHunter)
    * [DashDoc](https://sublime.wbond.net/packages/DashDoc)
    * [MacTerminal](https://sublime.wbond.net/packages/MacTerminal)
    * [Sublime Bookmarks](https://sublime.wbond.net/packages/Sublime%20Bookmarks)
* Git:
    * [Git](https://sublime.wbond.net/packages/Git)
    * [GitGutter](https://sublime.wbond.net/packages/GitGutter)
    * [Gitignore](https://sublime.wbond.net/packages/Gitignore)
    * [Gist](https://sublime.wbond.net/packages/Gist)
    * [Sublimerge Pro](https://sublime.wbond.net/packages/Sublimerge%20Pro)
* C/C++:
    * [SublimeAStyleFormatter](https://sublime.wbond.net/packages/SublimeAStyleFormatter)
    * [SublimeGDB](https://sublime.wbond.net/packages/SublimeGDB)
    * [DoxyDoc](https://sublime.wbond.net/packages/DoxyDoc)
* Python:
    * [Anaconda](https://sublime.wbond.net/packages/Anaconda)
    * [Python Breakpoints](https://sublime.wbond.net/packages/Python%20Breakpoints)
    * [Djaneiro](https://sublime.wbond.net/packages/Djaneiro)
* Markdown & LaTeX:
    * [SmartMarkdown](https://sublime.wbond.net/packages/SmartMarkdown)
    * [Markdown Preview](https://sublime.wbond.net/packages/Markdown%20Preview)
    * [Markdown Extended](https://sublime.wbond.net/packages/Markdown%20Extended)
    * [MarkdownTOC](https://sublime.wbond.net/packages/MarkdownTOC)
    * [Table Editor](https://sublime.wbond.net/packages/Table%20Editor)
    * [LaTeXing](https://sublime.wbond.net/packages/LaTeXing)
    * [LaTeXTab](https://sublime.wbond.net/packages/LaTeXTab)
    * [WordCount](https://sublime.wbond.net/packages/WordCount)
    * [Evernote](https://sublime.wbond.net/packages/Evernote)
* Other:
    * [Dotfiles Syntax Highlighting](https://sublime.wbond.net/packages/Dotfiles%20Syntax%20Highlighting)
    * [CMakeEditor](https://sublime.wbond.net/packages/CMakeEditor)
    * [Homebrew-formula-syntax](https://sublime.wbond.net/packages/Homebrew-formula-syntax)
    * [INI](https://sublime.wbond.net/packages/INI)
    * [Pretty JSON](https://sublime.wbond.net/packages/Pretty%20JSON)
    * [BeautifyRuby](https://sublime.wbond.net/packages/BeautifyRuby)

## Integrate Sublime Text 3 into OS X

* Run commands below in Terminal:

```bash
sudo ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
```
And add below code into `.bash_profile`:

```bash
export EDITOR='subl -w'
```
* [Integrate with Finder](http://charles.lescampeurs.org/2012/06/18/right-click-open-with-sublime-text-2).
