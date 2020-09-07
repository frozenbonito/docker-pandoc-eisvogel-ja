ARG pandoc_version="2.10"
FROM pandoc/latex:${pandoc_version}

ARG pandoc_version

RUN tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet \
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
    ipaex

ARG eisvogel_version="1.5.0"
RUN mkdir -p /root/.pandoc/templates \
    && wget https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/v${eisvogel_version}/eisvogel.tex \
    -O /root/.pandoc/templates/eisvogel.latex

RUN mkdir -p /root/.pandoc/defaults
COPY default.yaml /root/.pandoc/defaults/default.yaml

ENTRYPOINT [ "/usr/local/bin/pandoc", "-d", "default" ]
