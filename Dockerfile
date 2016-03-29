FROM ubuntu:14.04
MAINTAINER Koen De Keyser <koen.dekeyser@gmail.com>

# Add the FPComplete repo, to install "stack"
ADD http://download.fpcomplete.com/ubuntu/fpco.key /tmp/fpco.key
RUN apt-key add /tmp/fpco.key
RUN echo 'deb http://download.fpcomplete.com/ubuntu/trusty stable main'| tee /etc/apt/sources.list.d/fpco.list

# Standard Ubuntu dependencies
RUN apt-get update -q && apt-get install -y -q unzip gcc xz-utils vim vim-gtk git libz-dev wget libgmp3-dev make stack

RUN stack setup

RUN git clone --recursive https://github.com/sdiehl/haskell-vim-proto.git

RUN cd haskell-vim-proto && \
    cp vimrc ~/.vimrc && \
    cp -r vim ~/.vim

RUN cd ~/.vim/bundle/vimproc.vim && make

RUN stack install ghc-mod hlint

ENV PATH /root/.local/bin:$PATH
