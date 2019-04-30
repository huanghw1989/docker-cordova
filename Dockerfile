FROM huanghw/docker-android:latest

ENV NODEJS_VERSION=10.15.3 \
    PATH=$PATH:/opt/node/bin:/root/.sdkman/candidates/gradle/current/bin

RUN apt update && \
    apt install -y tar gzip

# nodejs
RUN mkdir -p /opt/node-tmp && cd /opt/node-tmp && \
    wget -O node.tar.xz https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.xz && \
    tar -xf node.tar.xz && \
    mv ./node-* /opt/node && rm -rf /opt/node-tmp

# cordova
RUN npm install -g npm@latest && \
    npm install -g cordova && \
    cordova telemetry off

# pre-download
RUN mkdir -p /home/tmp && cd /home/tmp && \
    cordova create hello com.example.hello HelloWorld && \
    cd hello && cordova platform add android && \
    cordova build android && \
    rm -rf /home/tmp

# clean
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get clean

