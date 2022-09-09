FROM frozenbonito/pandoc-eisvogel-ja

USER root

RUN apk add --no-cache \
    graphviz \
    openjdk11 \
    python3 \
    py3-pip \
    ttf-droid \
    ttf-droid-nonlatin

ARG plantuml_version="1.2022.7"
RUN wget https://sourceforge.net/projects/plantuml/files/plantuml.${plantuml_version}.jar/download -O /home/pandocuser/plantuml.jar

RUN pip3 install --upgrade pip
RUN pip3 install pandoc-plantuml-filter

ENV PLANTUML_BIN="java -jar /home/pandocuser/plantuml.jar"

COPY plantuml.yaml /home/pandocuser/.pandoc/defaults/plantuml.yaml

USER pandocuser

ENTRYPOINT [ "/usr/local/bin/pandoc", "-d", "default", "-d", "plantuml" ]
