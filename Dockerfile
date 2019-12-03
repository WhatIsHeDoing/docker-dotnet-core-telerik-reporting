# https://docs.microsoft.com/en-gb/aspnet/core/host-and-deploy/docker/building-net-docker-images
# https://docs.telerik.com/reporting/use-reports-in-net-core-apps
# https://feedback.telerik.com/reporting/1406043-can-not-run-in-docker
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim

# Update and install global packages
RUN apt-get update \
    && apt-get install -y apt-transport-https \
    && apt-get install -y \
    fontconfig \
    libc6-dev \
    libgdiplus \
    libx11-dev \
    locales-all \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Cannot `apt-get fonts-open-sans` here 😢
# Instead, download and install.
# https://gist.github.com/lightonphiri/5811226a1fba0b3df3be73ff2d5b351c
# https://feedback.telerik.com/reporting/1406842-chinese-font-simsun-isn-t-usable-in-docker
WORKDIR /usr/local/share/fonts
RUN mkdir googlefonts
RUN mkdir opentype
RUN cd googlefonts
RUN wget https://www.opensans.com/download/open-sans.zip
RUN unzip -d . open-sans.zip
RUN rm open-sans.zip
RUN chmod -R --reference=opentype googlefonts

# Register the fonts.
RUN fc-cache -fv

# Ensure that they are installed.
RUN fc-match OpenSans
