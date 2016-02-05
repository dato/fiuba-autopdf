# -*- docker-image-name: "fiuba/pandoc" -*-

# NOTA: Debian 8 trae Pandoc 1.12; versiones posteriores traen 1.15.
#
# Cuando cambiemos a Pandoc 1.15 o posterior tendremos que cambiar
# `lang: spanish` por `lang: es` en nuestros archivos Markdown.
FROM debian:8

# Dependencias.
RUN apt-get update && env DEBIAN_FRONTEND=noninteractive \
    apt-get install --assume-yes --no-install-recommends \
        pandoc  \
        lmodern \
        texlive-xetex        \
        texlive-lang-spanish \
        texlive-fonts-recommended

ENTRYPOINT ["pandoc"]
