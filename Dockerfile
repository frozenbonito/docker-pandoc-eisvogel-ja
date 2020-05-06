ARG pandoc_version="2.9.2.1"
FROM pandoc/latex:${pandoc_version}

ARG pandoc_version

RUN tlmgr install adjustbox \
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

ARG eisvogel_version="1.4.0"
RUN mkdir -p /root/.pandoc/templates \
    && wget https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/v${eisvogel_version}/eisvogel.tex \
    -O /root/.pandoc/templates/eisvogel.latex

ARG crossref_version="0.3.6.2a"
RUN mkdir -p /tmp/pandoc-crossref \
    && wget https://github.com/lierdakil/pandoc-crossref/releases/download/v${crossref_version}/pandoc-crossref-Linux-${pandoc_version}.tar.xz \
    -O /tmp/pandoc-crossref.tar.xz \
    && tar -Jxv -C /tmp/pandoc-crossref -f /tmp/pandoc-crossref.tar.xz \
    && mv /tmp/pandoc-crossref/pandoc-crossref /usr/local/bin \
    && rm -rf /tmp/pandoc-crossref.tar.xz /tmp/pandoc-crossref

RUN mkdir -p /root/.pandoc/defaults
COPY default.yaml /root/.pandoc/defaults/default.yaml

ENTRYPOINT [ "docker-entrypoint.sh", "-d", "default" ]
