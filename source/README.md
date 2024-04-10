# KJV Version Bible

## Two folders

### `original_kjv`

Contains all the books of the original KJV version bible.

### `kjv_simplified`

Simplified most of the archaic English words with the simplified ones. For example, `thou` -> `you`, `hath` -> `has`, `cometh` -> `comes`, `humbledst` -> `humbled`, ...

## Format

The default format is `*.md`, which can be viewed in browser/html format. If you want to `git clone` your
own repo and make notes and prefer to reading the corresponding `*.pdf` format, just simply run
`md2pdf.sh` to convert the `*.md` ti `*.pdf`. How to run **`md2pdf.sh`**? Check below:

```bash
    cd kjv_simplified && ./md2pdf.sh --help

    ./md2pdf.sh ./01-Genesis-KJV.md      # Convert ./01-Genesis-KJV.md -> ./pdf/01-Genesis-KJV.pdf
    ./md2pdf.sh --all|-a                 # Convert ./*.md -> ./pdf/*.pdf, and merge all *.pdf to kjv.pdf
    ./md2pdf.sh --merge|-m               # Merge all ./pdf/*.pdf to one kjv.pdf
    ./md2pdf.sh --merge|-m output.pdf    # Merge all ./pdf/*.pdf to one output.pdf
```
