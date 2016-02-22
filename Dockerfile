# -*- docker-image-name: "fiuba/pandoc" -*-

# Queremos Pandoc 1.15 o posterior.
FROM debian:stretch

# Dependencias.
RUN apt-get update && env DEBIAN_FRONTEND=noninteractive \
    apt-get install --assume-yes --no-install-recommends \
        git     \
        make    \
        pandoc  \
        lmodern \
        openssh-client       \
        texlive-xetex        \
        texlive-lang-spanish \
        texlive-fonts-recommended

ENTRYPOINT ["pandoc"]
