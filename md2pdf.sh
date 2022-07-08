#!/bin/bash
#
# echo "Run the commands manually." && exit

TGTDIR=./pdf
[ ! -d $TGTDIR ] && mkdir $TGTDIR

md2pdf()
{
    file=$1                         # file=./01-Genesis-KJV.md
    base=${file#./}                 # base=01-Genesis-KJV.md
    base=${base%.md}                # base=01-Genesis-Kjv
    echo "$file -> $TGTDIR/$base.pdf"
    tmpfile=$(mktemp /tmp/kjv.pdf.XXXXXX)
echo '
---
header-includes: |
    \usepackage{fancyhdr}
    \pagestyle{fancy}
    \fancypagestyle{plain}
...
' > $tmpfile
    cat $file >> $tmpfile
    sed -i 's/<sup>\*\*\(.\)\*\*<\/sup>/**^\1^**/g' $tmpfile    # substitute '<sup>**1**</sup>' to '**^1^**'
    sed -i 's/<sup>\*\*\(..\)\*\*<\/sup>/**^\1^**/g' $tmpfile   # substitute '<sup>**12**</sup>' to '**^12^**'
    pandoc "$tmpfile" -f markdown+implicit_figures --highlight-style tango -V geometry:"top=2cm,bottom=2cm,left=1in,right=1in"  -V fontfaimly:dejavu -V fontsize=10pt -V classoption:twocolumn  -o $TGTDIR/$base.pdf;
}

md2pdfall()
{
    for book in `ls *.md`; do
        md2pdf $book
    done
}

mergepdf()
{
    echo "./pdf/*.pdf -> kjv.pdf"
    pdftk $(ls ./pdf/*.pdf) cat output ${2:-kjv.pdf}
}

usage()
{
    echo '
    Usage:
        1. ./md2pdf.sh ./01-Genesis-KJV.md      :Convert ./01-Genesis-KJV.md -> ./pdf/01-Genesis-KJV.pdf
        2. ./md2pdf.sh --all|-a                 :Convert ./*.md -> ./pdf/*.pdf, and merge all *.pdf to kjv.pdf
        3. ./md2pdf.sh --merge|-m               :Merge all ./pdf/*.pdf to one kjv.pdf 
        3. ./md2pdf.sh --merge|-m output.pdf    :Merge all ./pdf/*.pdf to one output.pdf 
    '
}

main()
{
    if [ $# -ge 1 ]; then
        case "$1" in
            --help|-h)
                usage 
                ;;
            --all|-a)
                md2pdfall
                mergepdf $*
                ;;
            --merge|-m)
                mergepdf $*
                ;;
            *)
                md2pdf $1
                ;;
        esac
    else
        usage
    fi
}
main $*

