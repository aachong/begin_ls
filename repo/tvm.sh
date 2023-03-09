#!/bin/bash
pip3 install decorator tornado xgboost cloudpickle

git clone --recursive https://github.com/apache/tvm tvm
echo 'export TVM_HOME=/opt/tiger/begin/tvm' >> ~/.bashrc
echo 'export PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}' >> ~/.bashrc
echo 'remember changing config.cmake...'
# config.cmake 改set(USE_LLVM /home/linuxbrew/.linuxbrew/opt/llvm@9/bin/llvm-config)

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /home/tiger/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/tiger/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo '-----brew install-----'

brew install llvm@9
echo 'export PATH="/home/linuxbrew/.linuxbrew/opt/llvm@9/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
echo '-----llvm install-----'

cd tvm
mkdir build
cp cmake/config.cmake build
cd build
cmake ..
make -j16
