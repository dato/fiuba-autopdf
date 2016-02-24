# -*- docker-image-name: "fiuba/pandoc" -*-

# Queremos Pandoc 1.15 o posterior.
FROM debian:stretch

RUN addgroup --gid 17541 fiuba7541             && \
     adduser --system --uid 17541 --gid 17541     \
             --home /fiuba7541 --disabled-login   \
             --gecos "" --shell /usr/sbin/nologin \
             --disabled-password fiuba7541

# Dependencias.
RUN apt-get update && env DEBIAN_FRONTEND=noninteractive \
    apt-get install --assume-yes --no-install-recommends \
        curl     \
        gawk     \
        git      \
        make     \
        pandoc   \
        lmodern  \
        parallel \
        openssh-client       \
        ca-certificates      \
        texlive-xetex        \
        texlive-lang-spanish \
        texlive-fonts-recommended

# TODO(dato): compilar skicka en la imagen, o usar paquetes.
COPY ["bin/skicka", "/usr/local/bin/"]

ENTRYPOINT ["pandoc"]
