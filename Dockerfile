FROM openanalytics/r-base
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssh2-1 \
    libssl1.1 \
    build-essential \
    cmake \
    git \
    libbamtools-dev \
    libboost-dev \
    libboost-iostreams-dev \
    libboost-log-dev \
    libboost-system-dev \
    libboost-test-dev \
    libxml2-dev \
    libmpfr-dev \
    libz-dev \
    curl \
    libarmadillo-dev \
    && rm -rf /var/lib/apt/lists/*
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('git2r', 'devtools','shinyFeedback', 'shiny', 'haven', 'labelled', 'dplyr', 'openxlsx', 'sjmisc',  'readxl','survey','feather', 'shinyWidgets', 'rlang', 'kableExtra', 'shinycssloaders', 'readr', 'shinybusy', 'shinyalert', 'writexl', 'shinyjs', 'tibble', 'plotly', 'pkgload'), repos='http://cran.rstudio.com/')"
RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 777 /root/.ssh/id_rsa
ADD id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 777 /root/.ssh/id_rsa.pub
RUN R -e "devtools::install_github('https://github.com/inesscc/calidad')"
RUN mkdir /root/calidadv2
COPY R /root/calidadv2
RUN R -e "devtools::install_github('https://github.com/ricardoflopiza/shiny_calidad_package')"
COPY Rprofile.site /usr/lib/R/etc/
EXPOSE 8080
ENTRYPOINT ["Rscript", "app.R"]
