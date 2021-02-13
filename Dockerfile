FROM alpine:3.13
LABEL maintainer="Wiehann Matthysen <wcmatthysen@gmail.com>"

RUN apk add --no-cache autoconf automake make g++ gfortran sudo wget

RUN addgroup --gid 1000 voacap
RUN adduser --system --home /home/voacap --shell /bin/bash --ingroup voacap --uid 1000 voacap
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/wheel
RUN addgroup voacap wheel

USER voacap
WORKDIR /home/voacap

RUN wget -qO- https://github.com/jawatson/voacapl/archive/master.tar.gz | tar xzp
RUN cd voacapl-master && autoreconf && automake --add-missing && ./configure && sudo make install && makeitshfbc
