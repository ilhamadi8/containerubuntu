# Use the official Ubuntu 18.04 base image
FROM ubuntu:18.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install required packages
RUN apt-get update && apt-get install -y vim xterm pulseaudio cups && \
	apt-get -y dist-upgrade && \
	apt-get install -y xfce4 xfce4-goodies software-properties-common \
	firefox nano sudo tasksel && \
	apt-get -y dist-upgrade
RUN apt-get install neofetch -y

RUN apt-get install -y wget curl


RUN curl -fSL "https://download.nomachine.com/download/8.13/Linux/nomachine_8.13.1_1_amd64.deb" \
    -o nomachine.deb && dpkg -i nomachine.deb && sed -i \
    "s|#EnableClipboard both|EnableClipboard both |g" /usr/NX/etc/server.cfg

RUN apt-get install libpangox-1.0-0 libgtkglext1 
RUN wget "https://download.anydesk.com/linux/anydesk_6.3.2-1_amd64.deb" && \
    dpkg -i anydesk_6.3.2-1_amd64.deb && \
    apt-get install -f


RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

EXPOSE 4000

VOLUME [/home/nomachine]

COPY nxserver.sh /nxserver.sh
RUN chmod +x /nxserver.sh
# Start service
ENTRYPOINT ["./nxserver.sh"]
