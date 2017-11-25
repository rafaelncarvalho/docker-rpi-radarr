FROM resin/rpi-raspbian

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install apt-transport-https -y --force-yes
RUN apt-get install wget
RUN apt-get install mediainfo
RUN apt-get install mono-devel
RUN apt-get install libmono-cil-dev
RUN mkdir -p /volumes/config /volumes/media
RUN cd /opt
RUN wget https://github.com/Radarr/Radarr/releases/download/v0.2.0.870/Radarr.develop.0.2.0.870.linux.tar.gz
RUN tar -xvzf Radarr.develop.0.2.0.870.linux.tar.gz
RUN rm Radarr.develop.0.2.0.870.linux.tar.gz

## Expose port
EXPOSE 7878

## Volume for radarr data
VOLUME /volumes/config /volumes/media

## Entrypoint to launch Radarr
ENTRYPOINT ["mono","/Radarr/Radarr.exe", "-nobrowswer", "-data=/volumes/config"]
