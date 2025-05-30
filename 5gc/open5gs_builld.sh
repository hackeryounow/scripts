# curl -fsSL https://get.docker.com | bash -s docker

# Build docker images for open5gs EPC/5GC components
git clone https://github.com/herlesupreeth/docker_open5gs
cd docker_open5gs/base
docker build --no-cache --force-rm -t docker_open5gs .

# Build docker images for kamailio IMS components
cd ../ims_base
docker build --no-cache --force-rm -t docker_kamailio .

# Build docker images for srsRAN_4G eNB + srsUE (4G+5G)
cd ../srslte
docker build --no-cache --force-rm -t docker_srslte .

# Build docker images for srsRAN_Project gNB
cd ../srsran
docker build --no-cache --force-rm -t docker_srsran .

# Build docker images for UERANSIM (gNB + UE)
cd ../ueransim
docker build --no-cache --force-rm -t docker_ueransim .

# Build docker images for EUPF
cd ../eupf
docker build --no-cache --force-rm -t docker_eupf .

# Build docker images for OpenSIPS IMS
cd ../opensips_ims_base
docker build --no-cache --force-rm -t docker_opensips .


cd ..
set -a
source .env
set +a
sudo ufw disable
sudo sysctl -w net.ipv4.ip_forward=1
sudo cpupower frequency-set -g performance

# For 4G deployment only
# docker compose -f 4g-volte-deploy.yaml build

# For 5G deployment only
# docker compose -f sa-deploy.yaml build