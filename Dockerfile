# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/playwright:v1.56.1-noble

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y \
    x11vnc \
    fluxbox \
    novnc \
    supervisor \
    nodejs \
    dbus-x11 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g playwright

RUN mkdir -p /root/.vnc \
    && mkdir -p /opt/bin \
    && mkdir -p /app

# Set up VNC password
RUN x11vnc -storepasswd password /root/.vnc/passwd

COPY start-vnc.sh /opt/bin/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# Set working directory
WORKDIR /app

# Start supervisor
CMD ["/opt/bin/start-vnc.sh"]