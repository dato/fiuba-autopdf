# -*- docker-image-name: "fiuba/autopdf" -*-

# Queremos Pandoc 1.15 o posterior.
FROM debian:stretch

RUN addgroup --gid 17541 fiuba7541             && \
     adduser --system --uid 17541 --gid 17541     \
             --home /fiuba7541 --disabled-login   \
             --gecos "" --shell /usr/sbin/nologin \
             --disabled-password fiuba7541

# Dependencias.
RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl     \
        gawk     \
        git      \
        make     \
        pandoc   \
        lmodern  \
        parallel \
        python-flask    \
        python-gevent   \
        openssh-client  \
        ca-certificates \
        texlive-xetex   \
        texlive-lang-spanish \
        texlive-fonts-extra  \
        texlive-fonts-recommended

# TODO(dato): compilar skicka en la imagen, o usar paquetes.
COPY ["ssh", "/fiuba7541/.ssh"]
COPY ["bin/autopdf", "bin/mk_autopdf", "bin/skicka", "/usr/local/bin/"]

EXPOSE 8080
USER "fiuba7541"

ENTRYPOINT ["autopdf"]
