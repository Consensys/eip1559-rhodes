sudo yum install -y git gcc
wget https://dl.google.com/go/go1.13.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.13.linux-amd64.tar.gz
sudo touch /etc/profile.d/go.sh
echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a /etc/profile.d/go.sh
rm go1.13.linux-amd64.tar.gz
git clone https://github.com/vulcanize/go-ethereum.git
cd go-ethereum
git checkout 1559_update
make geth
echo 'export PATH=$PATH:/home/ec2-user/go-ethereum/build/bin' | sudo tee -a /etc/profile.d/geth.sh
source /etc/profile
