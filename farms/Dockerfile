# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean
    
RUN apt-get update && apt-get install -y mysql-server

RUN R -e "install.packages(pkgs=c('shiny', 'DT', 'plumber', 'RMySQL','ggplot2','readr'), repos='https://cran.rstudio.com/')" 

RUN mkdir /root/app

COPY farms_api /root/shiny_save

EXPOSE 3838
EXPOSE 3306

# RUN dos2unix /usr/bin/shiny-server.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*
CMD ["R", "-e", "shiny::runApp('/root/shiny_save', host='127.0.0.1', port=3838)"]