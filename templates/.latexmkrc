#!/usr/bin/perl
$latex            = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$lualatex         = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$xelatex          = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$bibtex           = 'upbibtex %O %B';
$biber            = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$makeindex        = 'upmendex %O -o %D %S';
$dvipdf           = 'dvipdfmx %O -o %D %S';
