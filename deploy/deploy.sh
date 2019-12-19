rm -rf ~/blockchain/unisuper-blockchain-poc
cd $(System.DefaultWorkingDirectory)
cp -r _dummyTree.unisuper-blockchain-poc/unisuper-blockchain-poc ~/blockchain
cd ~/blockchain/unisuper-blockchain-poc
# tmux new-session -d -s unisuper
tmux send -t unisuper:0.0 "ganache-cli --host 0.0.0.0 --port 7545 & > log.txt" Enter
truffle migrate --reset
