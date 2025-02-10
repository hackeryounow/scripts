wget https://github.com/Kitware/CMake/releases/download/v3.10.0/cmake-3.10.0.tar.gz
tar -zxvf cmake-3.10.0.tar.gz
cd cmake-3.10.0
make && make install
cd ..
rm -rf cmake-3.10.0*