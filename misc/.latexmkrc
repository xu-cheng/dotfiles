# Use lualatex
$pdflatex = 'lualatex --shell-escape --synctex=1 %O %S';
# Always create PDFs
$pdf_mode = 1;
# Use Skim.app to preview generated PDFs
$pdf_previewer = 'open -a Skim';
# file extensions to remove when cleaning
$clean_ext = 'bbl nav pdfsync pyg snm synctex.gz thm vrb run.xml';
