git clone https://github.com/ARMmbed/mbedtls
cd mbedtls
git checkout
cd mbedtls
git submodule update --init
mkdir build
cd build
cmake .. -DUSE_SHARED_MBEDTLS_LIBRARY=ON
make && make install
cd ../..


git clone https://github.com/BelledonneCommunications/bctoolbox.git
cd bctoolbox
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DENABLE_TESTS_COMPONENT=NO
make && make install
cd ../..

git clone https://github.com/BelledonneCommunications/ortp.git
cd ortp
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make && make install
cd ../..

echo "/usr/local/lib" | sudo tee -a /etc/ld.so.conf


wget https://download-mirror.savannah.gnu.org/releases/exosip/libeXosip2-2.2.2.tar.gz
tar -zxvf libeXosip2-2.2.2.tar.gz
cd ibeXosip2-2.2.2
./configure
make && install
cd ..
