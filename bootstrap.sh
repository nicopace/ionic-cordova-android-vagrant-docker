#!/usr/bin/env bash

apt-get update
apt-get install -y nodejs npm git
# So ubuntu doesn't freak out about nodejs path, which is just silly
ln -s /usr/bin/nodejs /usr/bin/node

npm install -g cordova
npm install -g ionic
