#!/bin/bash

docker run --rm -t -i -v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -v $HOME/.gitconfig:/root/.gitconfig:ro -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net=host -v $HOME/.Xauthority:/root/.Xauthority -v $HOME/haskell-intellij-shared:/root/shared $1 /bin/bash

