FROM ubuntu:14.04
MAINTAINER Koen De Keyser <koen.dekeyser@gmail.com>

# Add the FPComplete repo, maybe to play with "stack"
ADD http://download.fpcomplete.com/ubuntu/fpco.key /tmp/fpco.key
RUN apt-key add /tmp/fpco.key
RUN echo 'deb http://download.fpcomplete.com/ubuntu/trusty stable main'| tee /etc/apt/sources.list.d/fpco.list

# Standard Ubuntu dependencies
RUN apt-get update -q && apt-get install -y -q unzip gcc xz-utils openjdk-7-jdk vim git libz-dev wget libgmp3-dev make

# Make it easy to try different version
ENV IDEA_VERSION 14.1.3
ENV IDEA_TGZ ideaIC-$IDEA_VERSION.tar.gz
ENV HASKFORCE_VERSION v0.3-beta.20
ENV HASKFORCE_ZIP intellij-haskforce-$HASKFORCE_VERSION.zip
ENV GHC_VERSION 7.8.4
ENV GHC_TXZ ghc-$GHC_VERSION-x86_64-unknown-linux-deb7.tar.xz 
ENV CABAL_VERSION 1.20.0.3
ENV CABAL_TGZ Cabal-$CABAL_VERSION.tar.gz
ENV CABAL_INSTALL_VERSION 1.20.1.0
ENV CABAL_INSTALL_TGZ cabal-install-$CABAL_INSTALL_VERSION.tar.gz

# GHC
ADD https://www.haskell.org/ghc/dist/$GHC_VERSION/$GHC_TXZ /tmp/
RUN tar xf /tmp/$GHC_TXZ -C /tmp
RUN cd /tmp/ghc-$GHC_VERSION && ./configure
RUN cd /tmp/ghc-$GHC_VERSION && make install

# Cabal
ADD https://www.haskell.org/cabal/release/cabal-$CABAL_VERSION/$CABAL_TGZ /tmp/
RUN tar xf /tmp/$CABAL_TGZ -C /tmp
RUN cd /tmp/Cabal-$CABAL_VERSION && ghc -threaded --make Setup && ./Setup configure && ./Setup build && ./Setup install

# Cabal-install
ADD https://www.haskell.org/cabal/release/cabal-install-$CABAL_INSTALL_VERSION/$CABAL_INSTALL_TGZ /tmp/
RUN tar xf /tmp/$CABAL_INSTALL_TGZ -C /tmp
RUN cd /tmp/cabal-install-$CABAL_INSTALL_VERSION && ./bootstrap.sh --global

# Default cabal config, using Stackage
ADD cabal_config_$GHC_VERSION /root/.cabal/config
RUN cabal update
# Some parsers/tools needed by the Haskell IntelliJ plugin
RUN cabal install --global happy alex hlint ghc-mod stylish-haskell

# IntelliJ
ADD http://download.jetbrains.com/idea/$IDEA_TGZ /opt/
RUN tar xf /opt/$IDEA_TGZ -C /opt
RUN mv /opt/idea-IC-* /opt/idea

# HaskForce plugin
ADD https://github.com/carymrobbins/intellij-haskforce/releases/download/$HASKFORCE_VERSION/$HASKFORCE_ZIP /opt/
RUN unzip /opt/$HASKFORCE_ZIP -d /opt/idea/plugins

# Copy default IntelliJ Haskell settings, to limit amount of manual setup
ADD idea-settings/ /root



