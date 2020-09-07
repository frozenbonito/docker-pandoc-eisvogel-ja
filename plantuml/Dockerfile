FROM frozenbonito/pandoc-eisvogel-ja

RUN apk add --no-cache \
    graphviz \
    openjdk11 \
    python3 \
    py3-pip \
    ttf-droid \
    ttf-droid-nonlatin

ARG plantuml_version="1.2020.16"
RUN wget https://sourceforge.net/projects/plantuml/files/plantuml.${plantuml_version}.jar/download -O /root/plantuml.jar

RUN pip3 install --upgrade pip
RUN pip3 install pandoc-plantuml-filter

ENV PLANTUML_BIN="java -jar /root/plantuml.jar"

COPY plantuml.yaml /root/.pandoc/defaults/plantuml.yaml

ENTRYPOINT [ "/usr/local/bin/pandoc", "-d", "default", "-d", "plantuml" ]
