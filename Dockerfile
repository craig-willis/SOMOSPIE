FROM jupyter/pyspark-notebook:7a0c7325e470

USER root

RUN apt update -qqy && \
    apt-get install -y software-properties-common vim && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && \
    apt-get install -y libcurl4 r-base-core r-base-dev libgdal-dev libudunits2-dev libssl-dev 

COPY install.R /tmp
COPY environment.yml /tmp

RUN Rscript /tmp/install.R

RUN conda install --file /tmp/environment.yml

USER $NB_USER
