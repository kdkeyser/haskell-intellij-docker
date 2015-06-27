# haskell-intellij-docker
A docker with IntelliJ + HaskForce plugin and GHC / cabal / Stackage

Separate branch per GHC version. Currently only 7.8.4 is working.

To build the docker, do: docker build -t haskell-intellij .

A run.bash script is included which sets up X-forwarding, as well as SSH agent forwarding 
to your host system.

To run the docker, do: ./run.bash haskell-intellij

In /root/haskell-projects, there is a directory base-project which contains a configured 
"Hello World" style project. Start IntelliJ through /opt/idea/bin/idea.sh, then choose 
"Open" and select the "/root/haskell-projects/base-project" directory.

To compile, press Ctrl-F9

To run, press Shift-F10

To get type info, press Alt-= (e.g. on putStrLn will show String -> IO () )

