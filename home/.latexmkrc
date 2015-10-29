# vim: set filetype=perl:

# Use lualatex
$pdflatex = 'lualatex --shell-escape --synctex=1 %O %S';
# Always create PDFs
$pdf_mode = 1;
# Try 5 times at maximum then give up
$max_repeat = 5;
# Use Skim.app to preview generated PDFs
$pdf_previewer = 'open -a Skim';
# File extensions to remove when cleaning
$clean_ext = 'bbl fdb_latexmk nav pdfsync pyg pytxcode run.xml snm synctex.gz thm vrb';
# PythonTeX support
add_cus_dep('pytxcode', 'tex', 0, 'pythontex');
sub pythontex { return system("pythontex \"$_[0]\""); }
