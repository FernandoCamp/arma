# Use the official Ubuntu 18.04 image as the base image
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV CPU_MHZ=2000

EXPOSE 2001/udp
EXPOSE 17777/udp

RUN useradd arma
WORKDIR /home/arma

# Prepare environment
RUN apt-get update -y
RUN apt-get install -y software-properties-common libcurl4 net-tools libssl1.1
RUN dpkg --add-architecture i386
RUN apt-get update -y

# Install steamcmd
RUN echo steam steam/question select "I AGREE" | debconf-set-selections
RUN echo steam steam/license note '' | debconf-set-selections
RUN apt-get install -y steamcmd

# Assign permissions to arma user for its home dir
RUN chown -R arma:arma /home/arma
RUN chmod -R 700 /home/arma
USER arma
WORKDIR /home/arma

# Download Arma Reforger Server
RUN /usr/games/steamcmd  \
    +force_install_dir /home/arma/  \
    +login anonymous  \
    +@sSteamCmdForcePlatformBitness 64  \
    +app_update 1874900 validate  \
    +quit
