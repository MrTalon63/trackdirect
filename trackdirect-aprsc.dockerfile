FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
  gnupg \
  && rm -rf /var/lib/apt/lists/*

RUN printf "deb [trusted=yes] http://aprsc-dist.he.fi/aprsc/apt noble main" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv C51AA22389B5B74C3896EF3CA72A581E657A2B8D
RUN gpg --export C51AA22389B5B74C3896EF3CA72A581E657A2B8D | apt-key add -

RUN apt-get update && apt-get install -y \
  aprsc \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 10152
EXPOSE 14580
EXPOSE 10155
EXPOSE 14501

WORKDIR /opt/aprsc
USER aprsc

COPY config/aprsc.conf /opt/aprsc/etc/aprsc.conf
CMD /opt/aprsc/sbin/aprsc -c /opt/aprsc/etc/aprsc.conf
