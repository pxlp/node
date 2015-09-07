FROM ubuntu:trusty

RUN apt-get update && apt-get install -y \
  make \
  python2.7 \
  gcc-4.8 \
  g++-4.8 \
  clang-3.5 \
  clang++-3.5 \
  git

RUN git clone https://github.com/nodejs/node.git
WORKDIR node

RUN CC=/usr/bin/gcc-4.8 CXX=/usr/bin/g++-4.8 PYTHON=/usr/bin/python2.7 ./configure --enable-static
RUN make

WORKDIR out/Release
COPY staticnode.cpp staticnode.cpp

RUN g++-4.8 staticnode.cpp \
    -Wl,--whole-archive libnode.a -Wl,--no-whole-archive \
    libuv.a \
    libcares.a \
    -Wl,--whole-archive libopenssl.a -Wl,--no-whole-archive \
    libzlib.a \
    libhttp_parser.a \
    libv8_libplatform.a \
    -Wl,--whole-archive libv8_base.a -Wl,--no-whole-archive \
    libv8_libbase.a \
    libv8_nosnapshot.a \
    -lstdc++ \
    -lm \
    -ldl \
    -lpthread \
    -L. \
    -o staticnode

RUN ./staticnode
