# HaskellIntelliJDocker
A docker with IntelliJ + HaskForce plugin and GHC / cabal / Stackage

Separate branch per GHC version. Currently only 7.8.4 is working.

To build the docker, do: docker build -t haskell-intellij .

A run.bash script is included which sets up X-forwarding, as well as SSH agent forwarding to your host system.

To run the docker, do: ./run.bash haskell-intellij

