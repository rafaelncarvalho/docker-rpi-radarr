FROM resin/rpi-raspbian

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install libmono-cil-dev -y \
    && apt-get install wget \
    && wget http://sourceforge.net/projects/bananapi/files/mono_3.10-armhf.deb \
    && dpkg -i mono_3.10-armhf.deb \
    && rm mono_3.10-armhf.deb \
    && apt-get install apt-transport-https -y --force-yes

RUN curl -q0L $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 ) -o /tmp/radarr.tar.gz && \
     tar xfz /tmp/radarr.tar.gz -C / && \
     rm -f /tmp/radarr.tar.gz && \
     rm -rf /app && \
     mv /Radarr /app && \
     mkdir -p /etc/services.d/radarr && \
     echo '#!/usr/bin/execlineb -P\nmono --debug /app/Radarr.exe -data=/config --no-browser' > /etc/services.d/radarr/run && \
     mkdir -p /volumes/config /volumes/media

## Expose port
EXPOSE 7878

ENV HOME /volumes/config

## Volume for radarr data
VOLUME /volumes/config /volumes/media

## Entrypoint to launch Radarr
ENTRYPOINT ["/init"]
