FROM lcr.loongnix.cn/library/debian:unstable

RUN apt update && apt install -y git \
    golang \
    make \
    libseccomp-dev \
    wget \
    cmake \
    g++ \
    zip \
    ninja-build

    

ENV NINJA_VERSION=''

CMD ["sh", "-c","/workspace/process_version.sh $NINJA_VERSION"]
