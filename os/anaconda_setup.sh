cd ~
wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh
chmod +x Anaconda3-2024.10-1-Linux-x86_64.sh
./Anaconda3-2024.10-1-Linux-x86_64.sh
echo "export PATH=`pwd`/anaconda3/bin:\$PATH" >> /etc/profile; source /etc/profile
conda install pip
conda init
source ~/.bashrc
