# Basics

## Build

```console
$ docker run --rm -v $(pwd):/data frozenbonito/pandoc-eisvogel-ja \
    -d config.yaml \
    -o doc.pdf \
    doc.md
```
