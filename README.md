Ionic Box
=============================

Ionic Box is a ready-to-go hybrid development environment for building mobile apps with Ionic, Cordova, and Android. Ionic Box was built to make it easier for developers to build Android versions of their app, and especially for Windows users to get a complete dev environment set up without all the headaches.

For iOS developers, Ionic Box won't do much for you right now unless you are having trouble installing the Android SDK, and Ionic Box cannot be used for iOS development for a variety of legal reasons (however, the `ionic package` command in beta will soon fix that).

There are two ways of installing Ionic Box: Using Vagrant or using Docker.

### Vagrant Installation

To use it, you will require Docker in your system. To install Docker, go here: http://docs.docker.com/installation/

To run the VM, execute this:
```bash
CID=$(docker run -d nicopace/ionic-cordova-android-vagrant-)
```

to go inside the VM:
```bash
IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID)
ssh app@$IP # password: app
```

The username for vagrant is `vagrant` and the password is `vagrant`. 

This will download and install the image, and then go through the dependencies and install them one by one. `vagrant ssh` will connect you to the image and give you a bash prompt. Once everything completes, you'll have a working box to build your apps on Android.

### Docker Installation

To install, download and install [Docker](https://docker.com/) for your platform.

Once Docker is installed, you can run a downloadable image from Docker Hub, or build your own.
To download and use the Docker Hub image, you can run:

```bash
$ CID=$(docker run -d nicopace/ionic-cordova-android-vagrant-) # This runs the Docker Image

$ # And this gets you inside the Docker Image so you can use it
$ IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress  }}' $CID)
$ ssh app@$IP # password: app
```

If you prefer to build your own image, download the latest release of this GitHub repo, and unzip it. `cd` into the unzipped folder and run:

```bash
$ docker build --tag="username/ionicbox" --no-cache=false .
```

Then, you can run your own image, running the command specified before, changing the tag (in that case nicopace/ionic-cordova-android-vagrant-) with your own (in this case, username/ionicbox)

### Connected Android Devices

The image also has support for connected USB Android devices. To test whether devices are connected, you can run (from the box):

```bash
$ CID=$(docker run -d nicopace/ionic-cordova-android-vagrant-)
```

If that does not work, or shows `????? permissions`, then run:

```bash
sudo /opt/android-sdk-linux/platform-tools/adb kill-server
sudo /opt/android-sdk-linux/platform-tools/adb start-server
```

### Pre-built image

We are testing a pre-built Vagrant cloud image which should be faster than using the Vagrantfile method above. To try it, create a folder where you want to init your dev environment (a great place for this would be in the project folder of your app). Then run:

```bash
$ vagrant init drifty/ionic-android
$ vagrant up
```

If you try this method and it works or you encounter issues, please comment on issue #7.
