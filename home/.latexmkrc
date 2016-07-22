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
$clean_ext = 'bbl fdb_latexmk fls nav pdfsync pyg pytxcode run.xml ' .
             'snm synctex.gz thm upa vrb _minted-%R pythontex-files-%R ' .
             '**/*-eps-converted-to.pdf';
# PythonTeX support
add_cus_dep('pytxcode', 'tex', 0, 'pythontex');
sub pythontex { return system("pythontex \"$_[0]\""); }

no warnings 'redefine';

# Overwrite `cleanup1` functions to support more general pattern in $clean_ext.
# Ref: https://github.com/e-dschungel/latexmk-config/blob/master/latexmkrc
sub cleanup1 {
    my $dir = fix_pattern( shift );
    my $root_fixed = fix_pattern( $root_filename );
    foreach (@_) {
        (my $name = (/%R/ || /[\*\?]/) ? $_ : "%R.$_") =~ s/%R/$dir$root_fixed/;
        unlink_or_move( glob( "$name" ) );
    }
}

# Overwrite `unlink_or_move` to support clean directory.
use File::Path 'rmtree';
sub unlink_or_move {
    if ( $del_dir eq '' ) {
        foreach (@_) {
            if (-d $_) {
                rmtree $_;
            } else {
                unlink $_;
            }
        }
    }
    else {
        foreach (@_) {
            if (-e $_ && ! rename $_, "$del_dir/$_" ) {
                warn "$My_name:Cannot move '$_' to '$del_dir/$_'\n";
            }
        }
    }
}
