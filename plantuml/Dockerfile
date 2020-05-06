FROM frozenbonito/pandoc-eisvogel-ja

RUN apk add --no-cache openjdk11 graphviz ttf-droid ttf-droid-nonlatin python3

ARG plantuml_version="1.2020.8"
RUN wget https://sourceforge.net/projects/plantuml/files/plantuml.${plantuml_version}.jar/download -O /root/plantuml.jar

RUN pip3 install --upgrade pip
RUN pip3 install pandoc-plantuml-filter

ENV PLANTUML_BIN="java -jar /root/plantuml.jar"

COPY plantuml.yaml /root/.pandoc/defaults/plantuml.yaml

ENTRYPOINT [ "docker-entrypoint.sh", "-d", "default", "-d", "plantuml" ]
