# -*- docker-image-name: "fiuba/autopdf" -*-

# Queremos Pandoc 1.15 o posterior.
FROM debian:stretch

RUN addgroup --gid 17541 fiuba7541             && \
     adduser --system --uid 17541 --gid 17541     \
             --home /fiuba7541 --disabled-login   \
             --gecos "" --shell /usr/sbin/nologin \
             --disabled-password fiuba7541

# Dependencias.
RUN apt-get update && apt-get upgrade -y               && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl     \
        gawk     \
        git      \
        make     \
        pandoc   \
        lmodern  \
        cabextract      \
        python-flask    \
        python-gevent   \
        openssh-client  \
        ca-certificates \
        texlive-xetex   \
        texlive-lang-spanish \
        texlive-fonts-extra  \
        texlive-fonts-recommended && \

    curl -Lo /tmp/ppv.exe    \
        https://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe && \

    echo 'ab48a8ebac88219c84f293c6c1e81f1a0f420da6 /tmp/ppv.exe' \
        | sha1sum -c --status                                 && \

    cabextract -s -F ppviewer.cab -d /tmp /tmp/ppv.exe        && \

    cabextract -s -L -F 'CONSOLA*.TTF'                           \
        -d /usr/share/fonts/truetype/vista /tmp/ppviewer.cab  && \

    fc-cache -f /usr/share/fonts/truetype/vista && rm -f /tmp/ppv*

# TODO(dato): compilar skicka en la imagen, o usar paquetes.
COPY ["ssh", "/fiuba7541/.ssh"]
COPY ["bin/autopdf", "bin/mk_autopdf", "bin/skicka", "/usr/local/bin/"]

EXPOSE 8080
USER "fiuba7541"

ENTRYPOINT ["autopdf"]
