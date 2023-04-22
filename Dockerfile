ARG pandoc_version="2.19.2.0-alpine"
FROM pandoc/latex:${pandoc_version}

ARG pandoc_version

RUN tlmgr option repository ftp://tug.org/historic/systems/texlive/2022/tlnet-final \
    && tlmgr install adjustbox \
    babel-japanese \
    background \
    collectbox \
    everypage \
    footmisc \
    footnotebackref \
    fvextra \
    luatexja \
    ly1 \
    mdframed \
    mweights \
    needspace \
    pagecolor \
    sourcecodepro \
    sourcesanspro \
    titling \
    zref \
    haranoaji \
    ipaex \
    koma-script \
    environ \
    tcolorbox \
    tikzfill

RUN apk add --no-cache font-ipaex python3 py3-pip chromium
RUN pip3 install --no-cache-dir pandocfilters jinja2
RUN ln -sf python3 /usr/bin/python

RUN adduser -h /home/pandocuser -D pandocuser

RUN mkdir -p /home/pandocuser/.pandoc/templates
RUN mkdir -p /home/pandocuser/.pandoc/defaults
RUN mkdir -p /home/pandocuser/.pandoc/filters
RUN mkdir /temp && chown pandocuser /temp

ARG eisvogel_version="2.0.0"
RUN mkdir -p /home/pandocuser/.pandoc/templates \
    && wget https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/v${eisvogel_version}/eisvogel.tex \
    -O /home/pandocuser/.pandoc/templates/eisvogel.latex

COPY filters/pandoc-svg.py /home/pandocuser/.pandoc/filters/pandoc-svg.py
COPY default.yaml /home/pandocuser/.pandoc/defaults/default.yaml

USER pandocuser

ENTRYPOINT [ "/usr/local/bin/pandoc", "-d", "default" ]
