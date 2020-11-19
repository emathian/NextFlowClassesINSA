# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Emilie Mathian 

# Update the repository sources list
RUN apt-get update

# Install compiler and perl stuff
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils \
 zlib1g-dev

# Install git
RUN apt-get install -y git

# Install STAR
WORKDIR /usr/local/
RUN pwd
RUN git clone https://github.com/alexdobin/STAR.git
WORKDIR /usr/local/STAR/
RUN pwd
RUN git checkout 2.5.2b 
WORKDIR /usr/local/STAR/source 
RUN pwd
RUN make STAR
ENV PATH /usr/local/STAR/source:$PATH

# INSTALL BWA
RUN cd /
RUN  apt-get update && apt-get upgrade -y
RUN  apt-get install wget
RUN  wget 'https://vorboss.dl.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2'
RUN  bunzip2 bwa-0.7.17.tar.bz2 
RUN  tar xvf bwa-0.7.17.tar
RUN cd bwa-0.7.17
RUN make
ENV PATH=$PATH:/usr/local/STAR/source/bwa-0.7.17