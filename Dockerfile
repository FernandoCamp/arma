# Use the official Ubuntu 18.04 image as the base image
FROM ubuntu:18.04

# Set a non-interactive environment variable to prevent prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV CPU_MHZ=2000

WORKDIR /home/arma

# Update package lists and install bash
RUN apt update -y
RUN apt install software-properties-common -y
RUN dpkg --add-architecture i386
RUN apt update

RUN echo steam steam/question select "I AGREE" | debconf-set-selections
RUN echo steam steam/license note '' | debconf-set-selections
RUN apt install steamcmd -y


RUN /usr/games/steamcmd  \
    +force_install_dir /home/arma/  \
    +login anonymous  \
    +@sSteamCmdForcePlatformBitness 64  \
    +app_update 1874900 validate  \
    +quit

EXPOSE 2001

CMD ["./ArmaReforgerServer", "-maxFPS", "60", "-config", "./configs/config.json"]