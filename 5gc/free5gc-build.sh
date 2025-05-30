git clone --branch v0.9.5 --depth 1 https://github.com/free5gc/gtp5g.git
sudo apt -y update
sudo apt -y install gcc g++ cmake autoconf libtool pkg-config libmnl-dev libyaml-dev
cd gtp5g
make clean && make
sudo make install
cd ..
git clone https://github.com/free5gc/free5gc-compose.git
cd free5gc-compose
cd base
git clone --recursive -j `nproc` https://github.com/free5gc/free5gc.git
cd ..
make all
docker compose -f docker-compose-build.yaml build
cd ..
sudo apt remove cmake -y
snap install cmake --classic
git clone https://github.com/aligungr/UERANSIM
sudo apt install libsctp-dev lksctp-tools iproute2 -y
cd UERANSIM
make
cd ..