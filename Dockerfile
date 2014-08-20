FROM phusion/baseimage:0.9.12
MAINTAINER Nicolas Pace <nicolas.pace@unixono.com.ar>

# Set correct environment variables.
ENV HOME /root
ENV ANDROID_SDK_FILENAME android-sdk_r23.0.2-linux.tgz
ENV ANDROID_SDK http://dl.google.com/android/$ANDROID_SDK_FILENAME

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN apt-get update
RUN apt-get install -y nodejs npm git openjdk-6-jdk ant expect
# So ubuntu doesn't freak out about nodejs path, which is just silly
RUN ln -s /usr/bin/nodejs /usr/bin/node

## Create a user for the web app.
RUN addgroup --gid 9999 app
RUN adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
RUN usermod -L app
RUN mkdir -p /home/app/.ssh
RUN chmod 700 /home/app/.ssh
RUN chown app:app /home/app/.ssh


RUN curl -O $ANDROID_SDK -o /home/app/$ANDROID_SDK_FILENAME
RUN tar -xzvf /home/app/$ANDROID_SDK_FILENAME /home/app
RUN chown -R app /home/android-sdk-linux/

RUN echo "ANDROID_HOME=~/android-sdk-linux" >> /home/app/.bashrc
RUN echo "PATH=\$PATH:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools" >> /home/app/.bashrc

RUN npm install -g cordova
RUN npm install -g ionic
RUN expect -c '
set timeout -1;
spawn /home/app/android-sdk-linux/tools/android update sdk -u --all --filter platform-tool,android-19,build-tools-19.1.0
expect {
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
