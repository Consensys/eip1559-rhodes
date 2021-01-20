name=$1
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
sudo mkdir -p /data /var/log/geth /etc/geth
sudo chown -R ec2-user:ec2-user /data /var/log/geth /etc/geth
cd /etc/geth
wget https://raw.githubusercontent.com/ConsenSys/eip1559-rhodes/main/geth/genesis.json
wget https://raw.githubusercontent.com/ConsenSys/eip1559-rhodes/main/geth/config.toml
sudo tee -a /etc/systemd/system/geth.service > /dev/null <<EOT
[Unit]
Description=Geth client
After=syslog.target network.target

[Service]
User=ec2-user
Environment=HOME=/home/ec2-user
Type=simple
ExecStart=/bin/sh -c "/home/ec2-user/go-ethereum/build/bin/geth --config /etc/geth/config.toml --ethstats $name:7pyzQMYIWkrPZ7ab@3.21.227.120:3001 >> /var/log/geth/geth.log 2>&1"
SuccessExitStatus=143
Restart=on-failure
RestartSec=10s

[Install]
WantedBy=multi-user.target
EOT
sudo systemctl daemon-reload
